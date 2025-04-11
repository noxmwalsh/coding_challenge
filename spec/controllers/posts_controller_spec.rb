require "rails_helper"

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  render_views

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post_instance) { create(:post, user: user) }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { { title: "", body: "" } }
  # Michael: Named post_instance since it can be confused with the
  # request action within a controller spec

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
    # Add more index tests as needed
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { slug: post_instance.slug }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    context "when user is signed in" do
      before { sign_in user }

      it "returns a successful response" do
        get :new
        expect(response).to be_successful
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "when user is signed in" do
      before { sign_in user }

      context "with valid parameters" do
        it "creates a new Post" do
          expect {
            post :create, params: { post: valid_attributes }
          }.to change(Post, :count).by(1)
        end

        it "redirects to the created post" do
          post :create, params: { post: valid_attributes }
          expect(response).to redirect_to(Post.last)
        end
      end

      context "with invalid parameters" do
        it "does not create a new Post" do
          expect {
            post :create, params: { post: invalid_attributes }
          }.not_to change(Post, :count)
        end

        it "renders the new template" do
          post :create, params: { post: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #edit" do
    context "when user is signed in" do
      before { sign_in user }

      context "when user owns the post" do
        it "returns a successful response" do
          get :edit, params: { slug: post_instance.slug }
          expect(response).to be_successful
        end
      end

      context "when user does not own the post" do
        let(:other_user_post) { create(:post) }

        it "redirects to posts index" do
          get :edit, params: { slug: other_user_post.slug }
          expect(response).to redirect_to(posts_url)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        get :edit, params: { slug: post_instance.slug }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PUT #update" do
    context "when user is signed in" do
      before { sign_in user }

      context "when user owns the post" do
        context "with valid parameters" do
          let(:new_attributes) { { title: "Updated Title" } }

          it "updates the requested post" do
            put :update, params: { slug: post_instance.slug, post: new_attributes }
            post_instance.reload
            expect(post_instance.title).to eq("Updated Title")
          end

          it "redirects to the post" do
            put :update, params: { slug: post_instance.slug, post: new_attributes }
            expect(response).to redirect_to(post_instance)
          end
        end

        context "with invalid parameters" do
          it "renders the edit template" do
            put :update, params: { slug: post_instance.slug, post: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      context "when user does not own the post" do
        let(:other_user_post) { create(:post) }

        it "redirects to posts index" do
          put :update, params: { slug: other_user_post.slug, post: valid_attributes }
          expect(response).to redirect_to(posts_url)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        put :update, params: { slug: post_instance.slug, post: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is signed in" do
      before { sign_in user }

      context "when user owns the post" do
        it "destroys the requested post" do
          post_to_delete = post_instance
          expect {
            delete :destroy, params: { slug: post_to_delete.slug }
          }.to change(Post, :count).by(-1)
        end

        it "redirects to the posts list" do
          delete :destroy, params: { slug: post_instance.slug }
          expect(response).to redirect_to(posts_url)
        end
      end

      context "when user does not own the post" do
        let(:other_user_post) { create(:post) }

        it "does not destroy the post" do
          expect {
            delete :destroy, params: { slug: other_user_post.slug }
          }.not_to change(Post, :count)
        end

        it "redirects to posts index" do
          delete :destroy, params: { slug: other_user_post.slug }
          expect(response).to redirect_to(posts_url)
        end
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in page" do
        delete :destroy, params: { slug: post_instance.slug }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
