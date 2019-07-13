require 'rails_helper'
require 'eve_sso'

RSpec.describe EveSSO do
  let(:host) { 'sisilogin.testeveonline.com' }
  let(:scopes) { %w[esi-markets.structure_markets.v1] }
  let(:callback_url) { 'http://localhost:3000/authenticate' }
  let(:configuration) { OpenStruct.new({ host: host, scopes: scopes, callback_url: callback_url }) }

  let(:client_id) { '3rdparty_clientid' }
  let(:secret_key) { 'jkfopwkmif90e0womkepowe9irkjo3p9mkfwe' }
  let(:credentials) { { client_id: client_id, secret_key: secret_key } }

  before(:example) do
    allow(Rails.application.credentials).to receive(:eve_sso).and_return(credentials)
    allow(Rails.configuration.x).to receive(:eve_sso).and_return(configuration)
  end

  describe '.authorization_url' do
    it 'provides the correct SSO auth URL based on application settings' do
      expected_params = { response_type: :code,
                          redirect_uri: callback_url,
                          client_id: client_id,
                          scope: scopes.join(' ') }

      expected_url = URI::HTTPS.build(host: host, path: '/oauth/authorize', query: expected_params.to_query)
      expect(EveSSO.authorization_url).to eq(expected_url)
    end
  end

  describe '.request_access_token' do
    let(:authorization_code) { SecureRandom::urlsafe_base64 }
    let(:access_token) { SecureRandom::urlsafe_base64 }
    let(:refresh_token) { SecureRandom::urlsafe_base64 }
    let(:token_url) { URI::HTTPS.build(host: host, path: '/oauth/token') }

    let(:request_headers) { {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Host' => 'sisilogin.testeveonline.com',
      'User-Agent' => 'Ruby'
    } }

    let(:request_body) { { code: authorization_code,  grant_type: 'authorization_code' } }

    before(:example) do
      response_body = {
        access_token: access_token,
        token_type: :Bearer,
        expires_in: 1200,
        refresh_token: refresh_token
      }

      stub_request(:post, "https://sisilogin.testeveonline.com/oauth/token")
          .with(basic_auth: [client_id, secret_key], headers: request_headers, body: request_body)
          .to_return(status: 200, body: response_body.to_json, headers: {})
    end

    it 'makes the correct POST request to the EVE SSO server' do
      EveSSO.request_access_token(authorization_code)

      expect(WebMock).to have_requested(:post, token_url)
          .with(basic_auth: [client_id, secret_key], headers: request_headers, body: request_body.to_query
      )
    end
  end
end
