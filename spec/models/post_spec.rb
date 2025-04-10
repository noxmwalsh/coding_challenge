require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:author) }
    it { should belong_to(:user) }
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
