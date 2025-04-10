require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user: user) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(post).to be_valid
    end

    it 'is not valid without a title' do
      post.title = nil
      expect(post).not_to be_valid
    end

    it 'is not valid with a title shorter than 3 characters' do
      post.title = 'ab'
      expect(post).not_to be_valid
    end

    it 'is not valid with a title longer than 100 characters' do
      post.title = 'a' * 101
      expect(post).not_to be_valid
    end

    it 'is not valid without a description' do
      post.description = nil
      expect(post).not_to be_valid
    end

    it 'is not valid with a description shorter than 10 characters' do
      post.description = 'short'
      expect(post).not_to be_valid
    end

    it 'is not valid with a description longer than 200 characters' do
      post.description = 'a' * 201
      expect(post).not_to be_valid
    end

    it 'is not valid without a body' do
      post.body = nil
      expect(post).not_to be_valid
    end

    it 'is valid without a hero_image_url' do
      post.hero_image_url = nil
      expect(post).to be_valid
    end

    it 'is valid with a valid hero_image_url' do
      post.hero_image_url = 'https://example.com/image.jpg'
      expect(post).to be_valid
    end

    it 'is not valid with a hero_image_url longer than 1000 characters' do
      post.hero_image_url = 'https://example.com/' + 'a' * 1000
      expect(post).not_to be_valid
    end

    it 'is not valid without an author' do
      post.author = nil
      expect(post).not_to be_valid
    end
  end

  describe 'friendly_id' do
    it 'generates a slug from the title' do
      post.title = 'My First Post'
      post.save!
      expect(post.slug).to eq('my-first-post')
    end

    it 'updates the slug when the title changes' do
      post.save!
      original_slug = post.slug
      post.title = 'Updated Title'
      post.save!
      expect(post.slug).not_to eq(original_slug)
      expect(post.slug).to eq('updated-title')
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'attributes' do
    let(:post) { build(:post) }

    it 'has a title' do
      expect(post).to respond_to(:title)
    end

    it 'has a description' do
      expect(post).to respond_to(:description)
    end

    it 'has a body' do
      expect(post).to respond_to(:body)
    end

    it 'has an author' do
      expect(post).to respond_to(:author)
    end

    it 'belongs to a user' do
      expect(post).to respond_to(:user)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:post)).to be_valid
    end
  end
end
