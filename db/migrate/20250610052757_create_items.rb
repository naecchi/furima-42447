class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false

      with_options numericality: { other_than: 1 } do
      t.integer :category_id
      t.integer :status_id
      t.integer :delivery_cost_id
      t.integer :prefecture_id
      t.integer :shipping_day_id
      t.timestamps
      end
    end
  end
end
