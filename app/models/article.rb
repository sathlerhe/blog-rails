class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
