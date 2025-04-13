class RemoveHeroImageUrlFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :hero_image_url, :string
  end
end
