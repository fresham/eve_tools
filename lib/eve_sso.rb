class EveSSO
  def self.authorization_url
    query_params = {
      response_type: :code,
      redirect_uri: callback_url,
      client_id: client_id,
      scope: scopes.join(' ')
    }

    build_url(path: '/oauth/authorize', query: query_params.to_query)
  end

  def self.request_access_token(authorization_code)
    uri = build_url(path: '/oauth/token')
    request = Net::HTTP::Post.new(uri)
    request.basic_auth(client_id, secret_key)

    # NOTE: WebMock reorders encoded body fields, so tests will fail if this hash key order changes
    request.set_form_data(code: authorization_code, grant_type: :authorization_code)

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def self.callback_url
    Rails.configuration.x.eve_sso.callback_url
  end

  def self.client_id
    Rails.application.credentials.eve_sso[:client_id]
  end

  def self.secret_key
    Rails.application.credentials.eve_sso[:secret_key]
  end

  def self.scopes
    Rails.configuration.x.eve_sso.scopes
  end

  private

  def self.build_url(options)
    URI::HTTPS.build(options.merge(host: Rails.configuration.x.eve_sso.host))
  end
end
