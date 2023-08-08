class User < ApplicationRecord
  has_many :articles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, email: { mode: :strict }, uniqueness: true
end
