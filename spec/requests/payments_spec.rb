require 'rails_helper'

RSpec.describe 'Payments API', types: :request do
  let!(:user) { create(:user) }
  let(:headers) { valid_headers }
  let(:item) { create(:item) }
  let(:payment_id) { create(:payment).id }

  # add Payment
  describe 'POST /payments' do
    let(:valid_data) do 
       {name: 'Payment name', description: 'Payment description', item_id: item.id, amount: 50 }.to_json 
    end

    context 'when valid data' do
      before { post '/payments', params: valid_data, headers: headers}
      
      it 'returns status code 201' do        
        expect(response).to have_http_status(201)
      end
    end

    context 'when invalid data' do
      before do
        post '/payments',
        params: { name: nil, description: 'Payment description', item_id: item.id }.to_json,
        headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  #edit Payment
  describe 'PUT /paments/:payment_id' do
    let(:valid_data) do 
      { name:'edit data', description:'edit_description', item_id: item.id, amount: 50 }.to_json 
    end

    before do
      put "/payments/#{payment_id}",
      params: valid_data,
      headers: headers
    end

    context 'when payment exist' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when payment does not exist' do
      let(:payment_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  #delete Payment
  describe 'DELETE /payments/:payment_id' do
    before { delete "/payments/#{payment_id}",params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
