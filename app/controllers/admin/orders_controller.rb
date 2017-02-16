module Admin
  class OrdersController < ApplicationController
    before_action :require_admin
    before_action :set_menus, only: [:index]

    def index
      @statuses = Order.statuses_attributes
      @orders = Order.all
      @current_filter = params[:filter]
      @orders = @orders.where(status: @current_filter) if @current_filter
      flash.now[:info] = 'Não foram encontrados pedidos' if @orders.empty?
    end

    private

    def require_admin
      redirect_to root_path unless current_user.try(:admin?)
    end
  end
end
