class CreateQuests < ActiveRecord::Migration[7.1]
  def change
    create_table :quests do |t|
      t.string :name, null: false
      t.text :description
      t.integer :times, default: 1          # quantas vezes pode fazer
      t.integer :xp, default: 0             # xp ganho por vez
      t.references :user, foreign_key: true # quem é dono da quest

      t.timestamps
    end
  end
end
