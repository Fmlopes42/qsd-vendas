class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    if payment_boleto?
      @payment.boleto = Boleto.create
      msg = 'Boleto gerado, aguardando confirmação de pagamento pelo banco.'
    else
      @payment.credit = Credit.create(credit_params)
      if @payment.credit.valid?
        msg = 'Aguardando confirmação de pagamento pelo banco.'
      else
        msg = 'Não foi possível realizar seu pedido'
        flash[:danger] = msg
        redirect_to checkout_order_path @payment.order
        return
      end
    end
    @payment.save
    flash[:success] = msg
    redirect_to checkout_order_path @payment.order
  end

  private

  def payment_params
    params.require(:payment).permit(:order_id)
  end

  def credit_params
    params.require(:payment)[:credits].permit(:payment_id, :card_name,
                                              :card_number, :card_validity,
                                              :card_ccv)
  end

  def payment_boleto?
    params[:payment][:boleto] if params[:payment][:boleto] == 'boleto'
  end
end
