require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:micropost) { FactoryBot.create(:micropost, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe "GET /api/v1/microposts" do
    it "returns a success response" do
      get "/api/v1/microposts", headers: headers
      expect(response).to be_successful
    end
  end

  describe "POST /api/v1/microposts" do
    it "creates a new Micropost" do
      post "/api/v1/microposts", params: { micropost: { content: "New micropost" } }, headers: headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /api/v1/microposts/:id" do
    it "edits a Micropost" do
      put "/api/v1/microposts/#{micropost.id}", params: { micropost: { content: "Edited content" } }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(micropost.reload.content).to eq("Edited content")
    end
  end

  describe "DELETE /api/v1/microposts/:id" do
    it "deletes a Micropost" do
      delete "/api/v1/microposts/#{micropost.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(Micropost.exists?(micropost.id)).to be_falsey
    end
  end
end
