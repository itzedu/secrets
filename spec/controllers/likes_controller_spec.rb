require 'rails_helper'

RSpec.describe LikesController, :type => :controller do
  before do
    @user = create_user
    @secret = @user.secrets.create(content: "Oops")
    @like = @user.likes.create(user: @user, secret: @secret)
  end

  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end

    it "cannot access create" do 
      post :create
      expect(response).to redirect_to("/sessions/new")      
    end

    it "cannot access destroy" do
      delete :destroy, id: @like
      expect(response).to redirect_to("/sessions/new")
    end
  end

  describe "when signed in as the wrong user" do
    before do
      @wrong_user = create_user 'julius', 'julius@lakers.com'
      session[:user_id] = @user.id
    end

    it "cannot access create like if another user" do
      post :create, id: @wrong_user, secret_id: @secret
      expect(response).to redirect_to("/users/#{@user.id}")
    end

    it "cannot access destroy like if another user" do
      delete :destroy, id: @like, user_id: @wrong_user
      expect(response).to redirect_to("/users/#{@user.id}")
    end
  end
end
