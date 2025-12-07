class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name, null: false
      t.string :specialty, null: false
      t.integer :rating, default: 5
      t.string :phone
      t.string :email
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
