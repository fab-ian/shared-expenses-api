require 'rails_helper'

RSpec.describe 'ItemUsers API', type: :request do
  let!(:item) { create(:item) }
  let!(:item_users) { create_list(:item_user, 5, item_id: item.id) }
  let(:id) { item_users.first.id }
  let(:item_id) { item.id }
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers) { valid_headers }

  describe 'GET /items/:item_id/item_users' do
    before { get "/items/#{item_id}/item_users", params: {}, headers: headers }

    context 'when item exist' do
      it 'returns number of users assigned to item' do
        expect(json.size).to eq 5
      end
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when item does not exist' do
      let(:item_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /users/:user_id/items/:item_id/item_users' do
    before { post "/users/#{user_id}/items/#{item_id}/item_users", params: {}, headers: headers }

    context 'when data are valid' do
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when no Item' do
      let(:item_id) { 0 }

      it 'returns code status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end

    context 'when no User' do
      let(:user_id) { 0 }

      it 'returns code status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end

    context 'when adding second time an existing record' do
      before do
        post(
          "/users/#{item_users.last.user_id}/items/#{item_users.last.item_id}/item_users",
          params: {},
          headers: headers
        )
      end

      it 'returns code status 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        expect(response.body).to match(/You can't add the same info twice./)
      end
    end
  end

  describe 'DELETE /item_users/:id' do
    before { delete "/item_users/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
