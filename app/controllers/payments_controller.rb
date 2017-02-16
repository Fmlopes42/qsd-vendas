class PaymentsController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    payment_boleto? ? create_boleto : create_credit
    @payment.order.seller = User.seller.find_by(nickname: params[:seller])
    @payment.order.save
    @payment.save
    flash[:success] = @msg
    redirect_to @redirect_path
  end

  private

  def payment_params
    params.require(:payment).permit(:order_id, :credits)
  end

  def credit_params
    params.require(:payment)[:credits].permit(:payment_id, :card_name,
                                              :card_number, :card_validity,
                                              :card_ccv)
  end

  def payment_boleto?
    params[:payment_type] == 'boleto'
  end

  def create_credit
    @payment.credit = Credit.create(credit_params)
    @msg = 'Aguardando confirmação de pagamento pelo banco.'
    @redirect_path = resume_order_path @payment.order
    return if @payment.credit.valid?
    @msg = 'Não foi possível realizar seu pedido'
    @redirect_path = checkout_order_path @payment.order
  end

  def create_boleto
    @payment.boleto = Boleto.create
    @msg = 'Boleto gerado, aguardando confirmação de pagamento pelo banco.'
    @redirect_path = resume_order_path @payment.order
  end
end
