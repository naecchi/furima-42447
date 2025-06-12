class AddDetailsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :category_id, :integer
    add_column :items, :status_id, :integer
    add_column :items, :delivery_cost_id, :integer
    add_column :items, :prefecture_id, :integer
    add_column :items, :shipping_day_id, :integer
  end
end
