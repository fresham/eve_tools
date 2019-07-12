class EveSSO
  def self.authorization_url
    query_params = {
      response_type: :code,
      redirect_uri: Rails.configuration.x.eve_sso.callback_url,
      client_id: Rails.application.credentials.eve_sso[:client_id],
      scope: Rails.configuration.x.eve_sso.scopes.join(' '),
    }

    URI::HTTPS.build(host: Rails.configuration.x.eve_sso.host,
                     path: '/oauth/authorize',
                     query: query_params.to_query)
  end
end
