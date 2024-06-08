
  class OrdersController < ApplicationController
    before_action :set_item, only: [:index]
  
    def index
    end
  
    private
  
    def set_item
      @item = Item.find(params[:item_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Item not found'
    end
  end

