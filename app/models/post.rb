class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  has_rich_text :body
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :body, presence: true
  validates :hero_image_url, 
    length: { maximum: 1000 }, 
    allow_blank: true,
    format: { 
      with: /\Ahttps:\/\/.+\z/,
      message: "must be a valid HTTPS URL"
    }
  validates :author, presence: true
  
  def should_generate_new_friendly_id?
    title_changed? || super
  end
end
