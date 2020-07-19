class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :number, null: false
      t.date :order_date, null: false
      t.decimal :order_total, precision: 10, scale: 2, null: false
      t.references :customer, foreign_key: true,  index: true
      t.timestamps
    end
    add_index :orders, :order_total
  end
end
