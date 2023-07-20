class Category < ApplicationRecord
  has_many :skills, dependent: :destroy
end
