class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user, :order).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  if current_user != @item.user || @item.order.present?
    redirect_to root_path
  end
end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item) # アイテムの更新に成功した場合、詳細ページへリダイレクト
    else
      render :edit, status: :unprocessable_entity # バリデーション失敗時、入力フォームに戻す
    end
  end

  def destroy
    @item.destroy if current_user == @item.user
    redirect_to root_path
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path # アイテムの保存に成功した場合、トップページへリダイレクト
    else
      render :new, status: :unprocessable_entity # バリデーション失敗時、入力フォームに戻す
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :image, :price,
      :category_id, :status_id, :delivery_cost_id,
      :prefecture_id, :shipping_day_id
    ).merge(user_id: current_user.id)
  end
end
