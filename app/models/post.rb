class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_rich_text :body
  has_one_attached :hero_image

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 200 }
  validates :body, presence: true
  validates :author, presence: true
  validate :hero_image_content_type

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  private

  def hero_image_content_type
    return unless hero_image.attached?
    return if hero_image.content_type.in?(%w[image/jpeg image/png image/gif])

    errors.add(:hero_image, 'must be a JPEG, PNG, or GIF')
  end
end
