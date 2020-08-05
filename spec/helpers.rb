module Helpers
  def login_as(user)
	  post '/auth/sign_in', params: { email: user.email, password: user.password }, as: :json
    @headers = {
      'uid' => response.headers['uid'],
      'client' => response.headers['client'],
      'access-token' => response.headers['access-token']
    }
	end
end