class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_seller_and_sold_out
  

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
  @order_address = OrderAddress.new(order_params)
  if @order_address.valid?
    pay_item
    @order_address.save
    return redirect_to root_path
  else
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render 'index', status: :unprocessable_entity
  end
end


  def edit
  if @item.order.present? || current_user.id != @item.user_id
    redirect_to root_path
  end
end

  private

  def order_params
  params.require(:order_address).permit(
    :postal_code, :prefecture_id, :city,
    :street_address, :building_name, :phone_number,
    :price, :user_id, :item_id
  ).merge(
    token: params[:token],
    user_id: current_user.id,
    item_id: params[:item_id],
    price: @item.price
    )  
end
  
  def redirect_if_invalid_order
     # 自分が出品した商品 or 売り切れてる商品 の場合はトップページへ
  if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def prevent_seller_and_sold_out
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
