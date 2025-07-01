require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = OrderAddress.new(
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '渋谷区',
      street_address: '1-1',
      building_name: 'テストビル',
      phone_number: '09012345678',
      user_id: @user.id,
      item_id: @item.id,
      token: 'tok_abcdefghijk00000000000000000',
      price: 3000
    )
  end

  context '内容に問題がない場合' do
    it 'すべての値が正しく入力されていれば保存できる' do
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

    it '郵便番号にハイフンがないと保存できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid')
    end

    it '都道府県が1（---）だと保存できない' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '市区町村が空では保存できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では保存できない' do
      @order_address.street_address = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Street address can't be blank")
    end

    it '電話番号が空では保存できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁以下では保存できない' do
      @order_address.phone_number = '090123456'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が12桁以上では保存できない' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号にハイフンがあると保存できない' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid')
    end

    

    it 'user_idが空では保存できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では保存できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    # ★追加テスト：priceが空の場合は保存できない
    it 'priceが空では保存できない' do
      @order_address.price = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Price can't be blank")
    end

    # ★追加テスト：tokenが空の場合は保存できない
    it 'tokenが空では保存できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
