class OrdersController < ApplicationController
  before_action :authenticate_user!      # ログインしてないと購入できない
  before_action :set_item                # 購入対象の商品を取得
  before_action :prevent_seller_access   # 出品者は自分の商品を買えないようにする
  before_action :prevent_sold_item       # 売り切れの商品は購入できないようにする

  def new
    @order_address = OrderAddress.new
  end

  def index
  @item = Item.find(params[:item_id])
  if current_user.id == @item.user_id || @item.order.present?
    redirect_to root_path
  end
  @order_address = OrderAddress.new
end


  def create
  @item = Item.find(params[:item_id])
  @order_address = OrderAddress.new(order_address_params)
  if @order_address.valid?
    @order_address.save
    redirect_to root_path
  else
    render :index, status: :unprocessable_entity
  end
end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
  params.require(:order_address).permit(
    :postal_code, :prefecture_id, :city, :street_address,
    :building_name, :phone_number, :token
  ).merge(user_id: current_user.id, item_id: params[:item_id])
end

  def prevent_seller_access
    redirect_to root_path if current_user.id == @item.user_id
  end

  def prevent_sold_item
    redirect_to root_path if @item.order.present?
  end
end
