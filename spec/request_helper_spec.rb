# frozen_string_literal: true

RSpec.describe RequestHelper do
  include RequestHelper

  context 'Get request' do
    let(:url_without_params) { 'https://restcountries.com/v3.1/all' }
    let(:url_with_params) { 'https://restcountries.com/v3.1/name/aruba' }
    let(:invalid_url) { 'https://restcountries.com/v3.1/al' }
    let(:params) { { fullText: true } }

    it 'when params doesnt exist' do
      params = {}

      expect(send_request(url_without_params, params, :get)[:code]).to eq('200')
    end

    it 'when params exist' do
      expect(send_request(url_with_params, params, :get)[:code]).to eq('200')
    end

    it 'when invalid request' do
      expect(send_request(invalid_url, params, :get)[:code]).to eq('404')
    end
  end

  context 'Post request' do
    let(:url_with_params) { 'https://reqres.in/api/register' }
    let(:correct_params) { { email: 'eve.holt@reqres.in', password: 'pistol' } }
    let(:incorrect_params) { { email: 'sydney@fife' } }

    it 'when correct request' do
      expect(send_request(url_with_params, correct_params, :post)[:code]).to eq('200')
    end

    it 'when incorrect request' do
      expect(send_request(url_with_params, incorrect_params, :post)[:code]).to eq('400')
    end
  end
end
