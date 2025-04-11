require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    let(:post) { create(:post) }

    it 'routes to #index' do
      expect(get: '/posts').to route_to('posts#index')
    end

    it 'routes to #new' do
      expect(get: '/posts/new').to route_to('posts#new')
    end

    it 'routes to #show using slug' do
      expect(get: "/posts/#{post.slug}").to route_to('posts#show', slug: post.slug)
    end

    it 'routes to #edit using slug' do
      expect(get: "/posts/#{post.slug}/edit").to route_to('posts#edit', slug: post.slug)
    end

    it 'routes to #create' do
      expect(post: '/posts').to route_to('posts#create')
    end

    it 'routes to #update via PUT using slug' do
      expect(put: "/posts/#{post.slug}").to route_to('posts#update', slug: post.slug)
    end

    it 'routes to #update via PATCH using slug' do
      expect(patch: "/posts/#{post.slug}").to route_to('posts#update', slug: post.slug)
    end

    it 'routes to #destroy using slug' do
      expect(delete: "/posts/#{post.slug}").to route_to('posts#destroy', slug: post.slug)
    end

    it 'does not route to #show using id' do
      expect(get: "/posts/#{post.id}").not_to be_routable
    end

    it 'does not route to #edit using id' do
      expect(get: "/posts/#{post.id}/edit").not_to be_routable
    end

    it 'does not route to #update using id' do
      expect(patch: "/posts/#{post.id}").not_to be_routable
    end

    it 'does not route to #destroy using id' do
      expect(delete: "/posts/#{post.id}").not_to be_routable
    end
  end
end
