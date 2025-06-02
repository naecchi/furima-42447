# DB 設計


### users table（ユーザー情報）

| Column               | Type       | Options                          | 説明             |
|----------------------|------------|----------------------------------|------------------|
| nickname             | string     | null: false                      | ニックネーム     |
| email                | string     | null: false, unique              | メールアドレス   |
| password             | string     | null: false                      | パスワード（暗号化 |
| last_name            | string     | null: false                      | 姓               |
| first_name           | string     | null: false                      | 名               |
| last_name_kana       | string     | null: false                      | セイ（カナ）     |
| first_name_kana      | string     | null: false                      | メイ（カナ）     |
| birthday_date        | date       | null: false                      | 生年月日         |


### Association
* has_many :items
* has_many :purchases


### items table（出品商品情報）

| Column            | Type       | Options                          | 説明                     |
|-------------------|------------|----------------------------------|-------------------------
| user_id           | references | null: false, foreign_key: true   | 出品者（user）           |
| name              | string     | null: false                      | 商品名                   |
| description       | text       | null: false                      | 商品の説明               |
| category_id       | integer    | null: false                      | カテゴリー（ActiveHash） |
| status_id         | integer    | null: false                      | 商品の状態（ActiveHash） |
| area_id           | integer    | null: false                      | 配送元の地域（ActiveHash）|
| shipping_day_id   | integer    | null: false                      | 発送までの日数（ActiveHas|
| price             | integer    | null: false                      | 価格                    |

### Association

* belongs_to :user
* has_one :purchase



### purchases table（購入記録）

| Column     | Type       | Options                        | 説明           |
|------------|------------|------------------------------- |----------------|
| user_id    | references | null: false, foreign_key: true | 購入者（user） |
| item_id    | references | null: false, foreign_key: true | 購入された商品 |

### Association

* belongs_to :user
* belongs_to :item
* has_one :address



### addresses table（発送先住所）

| Column          | Type       | Options                       | 説明               |
|-----------------|------------|-------------------------------|--------------------|
| purchase_id     | references | null: false, foreign_key: true| 購入情報との紐付け |
| prefecture_id   | integer    | null: false                   | 都道府県（ActiveHash）|
| city            | string     | null: false                   | 市区町村           |
| street_address  | string     | null: false                   | 番地               |
| building_name   | string     |                               | 建物名             |
| phone_number    | string     | null: false                   | 電話番号           |


### Association
* belongs_to :purchase



