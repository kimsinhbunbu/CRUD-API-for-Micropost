require 'rails_helper'

RSpec.describe Api::V1::MicropostsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user: user) }
  let(:valid_attributes) { { content: 'This is a test micropost' } }
  let(:invalid_attributes) { { content: '' } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body)).to be_an_instance_of(Array)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: micropost.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body)['id']).to eq(micropost.id)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Micropost' do
        expect {
          post :create, params: { micropost: valid_attributes }
        }.to change(Micropost, :count).by(1)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors' do
        post :create, params: { micropost: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested micropost' do
        put :update, params: { id: micropost.id, micropost: valid_attributes }
        micropost.reload
        expect(micropost.content).to eq(valid_attributes[:content])
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors' do
        put :update, params: { id: micropost.id, micropost: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested micropost' do
      micropost = FactoryBot.create(:micropost, user: user)
      expect {
        delete :destroy, params: { id: micropost.id }
      }.to change(Micropost, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
