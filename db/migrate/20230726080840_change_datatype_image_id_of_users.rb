class ChangeDatatypeImageIdOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :image_id, :string
  end
end
