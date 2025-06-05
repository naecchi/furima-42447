require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      # 「すべて空では登録できない」
      it 'すべての項目が空では登録できない' do
        @user.nickname = ''
        @user.email = ''
        @user.password = ''
        @user.password_confirmation = ''
        @user.last_name = ''
        @user.first_name = ''
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.birthday_date = ''
        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Nickname can't be blank",
          "Email can't be blank",
          "Password can't be blank",
          "Last name can't be blank",
          "First name can't be blank",
          "Last name kana can't be blank",
          "First name kana can't be blank",
          "Birthday date can't be blank"
        )
      end

      #  条件違反（7つ）

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'invalidemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'xyz789'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'last_name_kanaがカタカナでないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it 'first_name_kanaがカタカナでないと登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
    end
  end
end
