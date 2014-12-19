require "sageone_api_request_signer/version"

# "Sign" an Sageone API request call following the steps detailed here:
# https://developers.sageone.com/docs#signing_your_requests
class SageoneApiRequestSigner

  attr_accessor :request_method, :url, :body_params, :nonce, :secret, :token

  def initialize(params = {})
    params.each do |attr, val|
      self.public_send("#{attr}=", val)
    end
  end

  def request_method=(v)
    @request_method = v.upcase
  end
end
