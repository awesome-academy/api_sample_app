class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email, presence: true,
    length: {maximum: 100}
  validates :email, uniqueness: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates :password, length: {minimum: 8}

  has_secure_password

  scope :newest, ->{order created_at: :desc}
end
