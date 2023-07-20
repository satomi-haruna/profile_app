class Skill < ApplicationRecord
  belongs_to :user
  belongs_to :category
  default_scope -> { order(:created_at) }
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :skill_name, presence: true, length: { maximum: 30 }
end
