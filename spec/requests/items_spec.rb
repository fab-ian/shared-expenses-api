require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  let!(:user) { create(:user) }
  let!(:items) { create_list(:item, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { items.first.id }

  describe 'GET /users/:user_id/items' do
    before { get "/users/#{user_id}/items" }

    context 'when user exist' do
      it 'returns all users items' do
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /users/:user_id/items/:id' do
    before { get "/users/#{user_id}/items/#{id}" }

    context 'when user item exist' do
      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user item does not exist' do
      let(:id) { 0 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /users/:user_id/items' do
    let(:valid_attributes) { { name: 'Item name', description: 'Item description' } }

    context 'when data are valid' do
      before { post "/users/#{user_id}/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when data are invalid' do
      before { post "/users/#{user_id}/items", params: { name: nil } }

      it 'returns code status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /users/:user_id/items/:id' do
    let(:valid_attributes) { { name: 'valid name', description: 'valid description' } }
    before { put "/users/#{user_id}/items/#{id}", params: valid_attributes }

    context 'when item exist' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'update the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/valid name/)
      end
    end

    context 'when item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'DELETE /users/:user_id/items/:id' do
    before { delete "/users/#{user_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
