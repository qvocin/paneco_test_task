class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :product_name, null: false
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2
      t.references :order, foreign_key: true,  index: true
      t.timestamps
    end
  end
end
