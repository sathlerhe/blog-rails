class User < ApplicationRecord
  has_many :articles

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, email: { mode: :strict }, uniqueness: true
end
