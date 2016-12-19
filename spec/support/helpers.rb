module Helpers
  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    {
      'Content-Type': 'application/vnd.api+json',
      'Authorization': "Bearer #{token}"
    }
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :request
end
