FactoryBot.define do
  factory :item do
    name              { "テスト商品" }
    description       { "テストの説明です" }
    price             { 500 }
    category_id       { 2 }  # ActiveHashの「選択してください（1）」以外
    status_id         { 2 }
    delivery_cost_id  { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }

    association :user  # 出品者を紐づける

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec/fixtures/test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end

