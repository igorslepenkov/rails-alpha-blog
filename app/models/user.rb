class User < ApplicationRecord
  has_many :articles

  VALID_EMAIL_REGEX = /\A([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)\z/i
  validates :username,
            presence: true,
            length: { in: 3..25 },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: true
end
