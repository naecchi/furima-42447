class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string     :name, null: false
      t.text       :description, null: false
      t.integer    :category_id, null: false
      t.integer    :status_id, null: false
      t.integer    :delivery_cost_id, null: false
      t.integer    :prefecture_id, null: false
      t.integer    :shipping_day_id, null: false
      t.integer    :price, null: false

      t.timestamps
    end
  end
end
