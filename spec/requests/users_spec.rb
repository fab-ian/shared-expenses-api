require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 20) }
  let(:user_id) { users.first.id }
  let(:user) { users.first }
  let(:credential) { create(:credential, user_id: user_id)}
  let(:headers2) { valid_headers }

  describe 'GET /users' do
    before { get '/users', params: {}, headers: headers2 }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", params: {}, headers: headers2 }

    context 'when the record exist' do
      it 'return the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) { { name: 'Paulina' }.to_json }

    context 'when the record exist' do
      before { put "/users/#{user_id}", params: valid_attributes, headers: headers2 }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}", params: {}, headers: headers2 }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  # User signup test suite
  describe 'POST /signup' do
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_registered_user_attributes) do
      attributes_for(
        :credential, name: 'New Register User', password_confirmation: credential.password, type: 'RegisteredUser'
      )
    end

    let(:valid_virtual_user_attributes) do
      attributes_for(
        :credential, name: 'New Virtual User', type: 'VirtualUser'
      )
    end

    let(:invalid_attributes) do
      attributes_for(:credential, name: nil, password_confirmation: credential.password, type: 'RegisteredUser')
    end

    context 'when valid RegisteredUser request' do
      before { post '/signup', params: valid_registered_user_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when valid VirtualUser request' do
      before { post '/signup', params: valid_virtual_user_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Virtual User created/)
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: invalid_attributes.to_json, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end
end
