class User < ApplicationRecord
  has_many :skills, dependent: :destroy
  before_save { email.downcase! }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # 画像
  mount_uploader :image_id, ImageIdUploader


  # 渡された文字列のハッシュ値を返す fixture
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # chart
  # scope :backend, -> { where(category_id: 1) }
  # scope :frontend, -> { where(category_id: 2) }
  # scope :infra, -> { where(category_id: 3) }
end
