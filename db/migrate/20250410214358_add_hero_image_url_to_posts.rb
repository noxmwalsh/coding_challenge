class AddHeroImageUrlToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :hero_image_url, :string, limit: 1000, null: true
  end
end
