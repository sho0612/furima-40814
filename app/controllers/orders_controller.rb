class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)

    if @order_address.valid?

      pay_item
      @order_address.save
      return redirect_to root_path, notice: 'Order and address were successfully created.'
    else

      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :street, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Rails.logger.debug("Token: #{order_address_params[:token]}")  # デバッグ用
    begin
      Payjp::Charge.create(
        amount: @item.price,
        card: order_address_params[:token],
        currency: 'jpy'
      )
    rescue Payjp::PayjpError => e
      Rails.logger.error("Payjp error: #{e.message}")
      render :index, alert: 'Payment processing failed. Please try again.', status: :unprocessable_entity
    end
  end

end