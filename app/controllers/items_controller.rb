class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def show
  @item = Item.find(params[:id])
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

  def item_params
    params.require(:item).permit(
      :name, :description, :image, :price,
      :category_id, :status_id, :delivery_cost_id,
      :prefecture_id, :shipping_day_id
    ).merge(user_id: current_user.id)
  end
end
