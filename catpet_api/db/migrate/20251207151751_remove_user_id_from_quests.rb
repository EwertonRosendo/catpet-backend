class RemoveUserIdFromQuests < ActiveRecord::Migration[8.0]
  def change
    remove_column :quests, :user_id, :integer
  end
end
