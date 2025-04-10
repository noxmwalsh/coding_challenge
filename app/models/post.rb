class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  
  validates :title, presence: true
  validates :description, presence: true
  validates :body, presence: true
  validates :author, presence: true
  
  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
