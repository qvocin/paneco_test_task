class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end
  end
end
