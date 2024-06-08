class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.save
      redirect_to root_path, notice: 'Order and address were successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Item not found'
  end

  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :street, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

end