class Post < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :description, presence: true
  validates :body, presence: true
  validates :author, presence: true
end
