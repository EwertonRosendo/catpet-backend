# rails g model UserTaskCompleted user:references quest:references

class CreateUserTaskCompleteds < ActiveRecord::Migration[7.1]
  def change
    create_table :user_task_completeds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true

      t.timestamps
    end

    # Impede que o mesmo user complete duas vezes a mesma quest
    add_index :user_task_completeds, [:user_id, :quest_id], unique: true
  end
end
