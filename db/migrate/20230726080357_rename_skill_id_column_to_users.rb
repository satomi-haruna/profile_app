class RenameSkillIdColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :skill_id, :image_id
  end
end
