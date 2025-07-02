class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_seller_and_sold_out

  def index
    redirect_if_invalid_order # 自分が出品した商品 or 売り切れてる商品 の場合はトップページへ
    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
  end

  def new
    redirect_if_invalid_order # 自分が出品した商品 or 売り切れてる商品 の場合はトップページへ
    # 商品の情報を取得
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil) # これがトークン生成に必須！
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
      render 'index', status: :unprocessable_entity
    end
  end

  def edit
    return unless @item.order.present? || current_user.id != @item.user_id

    redirect_to root_path
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :street_address,
      :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def redirect_if_invalid_order
    # 自分が出品した商品 or 売り切れてる商品 の場合はトップページへ
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def prevent_seller_and_sold_out
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path
  end

  def pay_item
    item = Item.find(params[:item_id])
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY', nil)
    Payjp::Charge.create(
      amount: item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
