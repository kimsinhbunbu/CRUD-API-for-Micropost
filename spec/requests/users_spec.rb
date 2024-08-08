require 'rails_helper'

RSpec.describe "User", type: :request do
  let(:user) { FactoryBot.create(:user) }
  
  describe "POST /users" do
    it "registrations user" do
      post "/users", params: { user: { email: "phankimsinh20@gmail.com", password: "12345678" } }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_in" do
    it "registrations user" do
      post "/users/sign_in", params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:ok)
    end
  end
end
