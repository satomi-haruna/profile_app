class CreateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :skills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :skill_name
      t.integer :level

      t.timestamps
    end
    add_index :skills, [:user_id, :created_at]
  end
end
