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

    it 'is not valid without an author' do
      post.author = nil
      expect(post).not_to be_valid
    end

    describe 'hero_image' do
      it 'is valid without a hero image' do
        expect(post).to be_valid
      end

      it 'is valid with a valid image attachment' do
        post = build(:post, :with_hero_image)
        expect(post).to be_valid
      end

      it 'is not valid with an invalid file type' do
        post.hero_image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test.txt')),
          filename: 'test.txt',
          content_type: 'text/plain'
        )
        expect(post).not_to be_valid
        expect(post.errors[:hero_image]).to include('must be a JPEG, PNG, or GIF')
      end
    end
  end

  describe 'friendly_id' do
    it 'generates a slug from the title' do
      post.save
      expect(post.slug).to eq(post.title.parameterize)
    end

    it 'updates the slug when the title changes' do
      post.save
      original_slug = post.slug
      post.update(title: 'Updated Title')
      expect(post.slug).not_to eq(original_slug)
      expect(post.slug).to eq('updated-title')
    end
  end

  describe 'attributes' do
    it 'has a title' do
      expect(post.title).to be_present
    end

    it 'has a description' do
      expect(post.description).to be_present
    end

    it 'has a body' do
      expect(post.body).to be_present
    end

    it 'has an author' do
      expect(post.author).to be_present
    end

    it 'belongs to a user' do
      expect(post.user).to be_present
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:post)).to be_valid
    end

    it 'can create a post with a hero image' do
      post = create(:post, :with_hero_image)
      expect(post.hero_image).to be_attached
    end
  end
end
