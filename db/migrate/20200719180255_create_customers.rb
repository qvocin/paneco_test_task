class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.date :date_of_birth, null: false
      t.timestamps
    end
    add_index :customers, :email, unique: true
    add_index :customers, :date_of_birth
  end
end
