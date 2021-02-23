class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :last_name, :email, presence: true,
    length: {maximum: 100}
  validates :email, uniqueness: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates :password, length: {minimum: 8}

  has_secure_password

  after_create :generate_new_auth_token

  scope :newest, ->{order created_at: :desc}

  def generate_new_auth_token
    token = User.generate_unique_secure_token
    self.update_columns auth_token: token
  end

  def encode_auth_token
    JWT.encode auth_token, ENV["API_SECURE_KEY"], Settings.algorithm
  end
end
