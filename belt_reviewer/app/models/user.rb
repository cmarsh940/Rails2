class User < ApplicationRecord
  has_many :events
  has_many :comments
  has_many :rosters
  has_many :attending, through: :rosters
  has_secure_password

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, :email, :address, :state, presence: true
  # validates :password, length: { minimum: 8 }

  before_save :downcase_email

  def downcase_email
    self.email.downcase!     # Change email to lowercase before saving
  end
end
