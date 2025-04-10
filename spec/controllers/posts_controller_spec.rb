require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_item) { create(:post, user: user) }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { attributes_for(:post, title: '') }
  # Michael: Named post_item since it can be confused with the 
  #request action within a controller spec

  describe 'GET #index' do
    before do
      post_item # Create the post before the request
      get :index
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'includes the post in the rendered view' do
      expect(response.body).to include(post_item.title)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { slug: post_item.slug } }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'includes the post details in the rendered view' do
      expect(response.body).to include(post_item.title)
      expect(response.body).to include(post_item.body)
      expect(response.body).to include(post_item.description)
      expect(response.body).to include(post_item.slug)
    end
  end

  describe 'GET #new' do
    context 'when user is signed in' do
      before do
        sign_in user
        get :new
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'includes the new post form in the rendered view' do
        expect(response.body).to include('New Post')
      end
    end

    context 'when user is not signed in' do
      before { get :new }

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid params' do
        it 'creates a new Post' do
          expect {
            post :create, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it 'redirects to the created post' do
          post :create, params: { post: valid_attributes }
          expect(response).to redirect_to(post_path(Post.last))
        end
      end

      context 'with invalid params' do
        it 'does not create a new Post' do
          expect {
            post :create, params: { post: invalid_attributes }
          }.to_not change(Post, :count)
        end

        it 'returns unprocessable entity status' do
          post :create, params: { post: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'includes the new post form in the rendered view' do
          post :create, params: { post: invalid_attributes }
          expect(response.body).to include('New Post')
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is signed in' do
      before do
        sign_in user
        get :edit, params: { slug: post_item.slug }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'includes the post details in the rendered view' do
        expect(response.body).to include(post_item.title)
      end
    end

    context 'when user is not signed in' do
      before { get :edit, params: { slug: post_item.slug } }

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before do
        sign_in other_user
        get :edit, params: { slug: post_item.slug }
      end

      it 'redirects to posts index' do
        expect(response).to redirect_to(posts_path)
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) { { title: "Updated Title", description: "Updated Description", body: "Updated Body" } }

    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid params' do
        it 'updates the post' do
          patch :update, params: { slug: post_item.slug, post: new_attributes }
          post_item.reload
          expect(post_item.title).to eq("Updated Title")
        end

        it 'redirects to the post' do
          patch :update, params: { slug: post_item.slug, post: new_attributes }
          post_item.reload
          expect(response).to redirect_to(post_path(post_item))
        end
      end

      context 'with invalid params' do
        it 'does not update the post' do
          patch :update, params: { slug: post_item.slug, post: invalid_attributes }
          post_item.reload
          expect(post_item.title).to_not eq("")
        end

        it 'returns unprocessable entity status' do
          patch :update, params: { slug: post_item.slug, post: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'includes the edit form in the rendered view' do
          patch :update, params: { slug: post_item.slug, post: invalid_attributes }
          expect(response.body).to include("Edit Post")
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        patch :update, params: { slug: post_item.slug, post: { title: 'Test' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before { sign_in other_user }

      it 'redirects to posts index' do
        patch :update, params: { slug: post_item.slug, post: { title: 'Test' } }
        expect(response).to redirect_to(posts_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is signed in' do
      before { sign_in user }

      it 'destroys the post' do
        post_to_delete = create(:post, user: user)
        expect {
          delete :destroy, params: { slug: post_to_delete.slug }
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to posts index' do
        delete :destroy, params: { slug: post_item.slug }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        delete :destroy, params: { slug: post_item.slug }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before { sign_in other_user }

      it 'redirects to posts index' do
        delete :destroy, params: { slug: post_item.slug }
        expect(response).to redirect_to(posts_path)
      end
    end
  end
end 