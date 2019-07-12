require 'rails_helper'
require 'eve_sso'

RSpec.describe EveSSO do
  let(:host) { 'sisilogin.testeveonline.com' }
  let(:scopes) { %w[esi-markets.structure_markets.v1] }
  let(:callback_url) { 'http://localhost:3000/authenticate' }
  let(:configuration) { OpenStruct.new({ host: host,
                                         scopes: scopes,
                                         callback_url: callback_url }) } 

  let(:client_id) { 'SSO_CLIENT_ID' }
  let(:secret_key) { 'SSO_SECRET_KEY' }
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

      expected_url = URI::HTTPS.build(host: host,
                                      path: '/oauth/authorize',
                                      query: expected_params.to_query)

      expect(EveSSO.authorization_url).to eq(expected_url)
    end
  end

  # describe '.request_access_token' do
  # end
end
