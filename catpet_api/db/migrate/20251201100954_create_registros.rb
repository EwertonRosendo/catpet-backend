class CreateRegistros < ActiveRecord::Migration[8.0]
  def change
    create_table :registros do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
