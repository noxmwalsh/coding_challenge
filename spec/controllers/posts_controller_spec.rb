require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_item) { create(:post, user: user) }
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
    before { get :show, params: { id: post_item.id } }

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'includes the post details in the rendered view' do
      expect(response.body).to include(post_item.title)
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
        let(:valid_attributes) do
          {
            title: 'New Post',
            description: 'Description',
            body: 'Body content'
          }
        end

        it 'creates a new post' do
          expect {
            process :create, method: :post, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it 'redirects to the created post' do
          process :create, method: :post, params: { post: valid_attributes }
          expect(response).to redirect_to(Post.last)
        end

        it 'sets the author to the current user email' do
          process :create, method: :post, params: { post: valid_attributes }
          expect(Post.last.author).to eq(user.email)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) do
          {
            title: '',
            description: '',
            body: ''
          }
        end

        it 'does not create a new post' do
          expect {
            process :create, method: :post, params: { post: invalid_attributes }
          }.not_to change(Post, :count)
        end

        it 'returns unprocessable entity status' do
          process :create, method: :post, params: { post: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'includes the new post form in the rendered view' do
          process :create, method: :post, params: { post: invalid_attributes }
          expect(response.body).to include('New Post')
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        process :create, method: :post, params: { post: { title: 'Test' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'when user is signed in' do
      before do
        sign_in user
        get :edit, params: { id: post_item.id }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'includes the post details in the rendered view' do
        expect(response.body).to include(post_item.title)
      end
    end

    context 'when user is not signed in' do
      before { get :edit, params: { id: post_item.id } }

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before do
        sign_in other_user
        get :edit, params: { id: post_item.id }
      end

      it 'redirects to posts index' do
        expect(response).to redirect_to(posts_url)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is signed in' do
      before { sign_in user }

      context 'with valid params' do
        let(:new_attributes) do
          {
            title: 'Updated Title',
            description: 'Updated Description',
            body: 'Updated Body'
          }
        end

        before do
          process :update, method: :patch, params: { id: post_item.id, post: new_attributes }
        end

        it 'updates the post' do
          post_item.reload
          expect(post_item.title).to eq('Updated Title')
          expect(post_item.description).to eq('Updated Description')
          expect(post_item.body).to eq('Updated Body')
        end

        it 'redirects to the post' do
          expect(response).to redirect_to(post_item)
        end
      end

      context 'with invalid params' do
        let(:invalid_attributes) do
          {
            title: '',
            description: '',
            body: ''
          }
        end

        before do
          process :update, method: :patch, params: { id: post_item.id, post: invalid_attributes }
        end

        it 'does not update the post' do
          post_item.reload
          expect(post_item.title).not_to eq('')
        end

        it 'returns unprocessable entity status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'includes the edit form in the rendered view' do
          expect(response.body).to include('Edit Post')
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        process :update, method: :patch, params: { id: post_item.id, post: { title: 'Test' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before { sign_in other_user }

      it 'redirects to posts index' do
        process :update, method: :patch, params: { id: post_item.id, post: { title: 'Test' } }
        expect(response).to redirect_to(posts_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is signed in' do
      before { sign_in user }

      it 'destroys the post' do
        post_to_delete = create(:post, user: user)
        expect {
          process :destroy, method: :delete, params: { id: post_to_delete.id }
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to posts index' do
        process :destroy, method: :delete, params: { id: post_item.id }
        expect(response).to redirect_to(posts_url)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        process :destroy, method: :delete, params: { id: post_item.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not the author' do
      before { sign_in other_user }

      it 'redirects to posts index' do
        process :destroy, method: :delete, params: { id: post_item.id }
        expect(response).to redirect_to(posts_url)
      end
    end
  end
end 