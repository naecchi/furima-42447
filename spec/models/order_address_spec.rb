require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = OrderAddress.new(
      user_id: user.id,
      item_id: item.id,
      postal_code: "123-4567",
      prefecture_id: 2,
      city: "横浜市",
      street_address: "青山1-1-1",
      building_name: "柳ビル103",
      phone_number: "09012345678",
      token: "tok_abcdefghijk00000000000000000"
    )
  end

  describe '購入内容の保存' do
    context '内容に問題がない場合' do
      it '全て正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では保存できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
    end
  end
end

