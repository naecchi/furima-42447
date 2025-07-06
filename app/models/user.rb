class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthday_date, presence: true

  # パスワード：半角英数字混合で入力
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }

  # 名前：全角（漢字・ひらがな・カタカナ）
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヴー々一-龥]+\z/
  validates :last_name, format: { with: VALID_NAME_REGEX, message: 'is invalid' }
  validates :first_name, format: { with: VALID_NAME_REGEX, message: 'is invalid' }

  # カナ名：全角カタカナ
  VALID_KANA_REGEX = /\A[ァ-ヴー－]+\z/
  validates :last_name_kana, format: { with: VALID_KANA_REGEX, message: 'is invalid' }
  validates :first_name_kana, format: { with: VALID_KANA_REGEX, message: 'is invalid' }

  has_many :items
  has_many :orders
end
