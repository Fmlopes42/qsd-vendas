class Admin::OrdersController < ApplicationController
  before_action :set_menus, only: [:index]
  def index
    @statuses = Order.statuses_attributes
    @orders = Order.all
    @current_filter = params[:filter]
    @orders = @orders.where(status: @current_filter) if @current_filter
  end
end
