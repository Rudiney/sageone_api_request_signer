require 'rest_client'
require 'json'

RSpec.describe SageoneApiRequestSigner do
  subject do
    SageoneApiRequestSigner.new({
      request_method: 'post',
      url: 'https://api.sageone.com/test/accounts/v1/contacts?config_setting=foo',
      body_params: {
        'contact[contact_type_id]' => 1,
        'contact[name]' => 'My Customer'
      },
      signing_secret: 'TestSigningSecret',
      access_token: 'TestToken',
    })
  end

  describe 'doing a real call to the test endpoint' do
    it 'should check with the test server data' do
      headers = subject.request_headers.merge({
        'Accept' => '*/*',
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => 'NPSS'
      })

      begin
        RestClient.post subject.url, subject.body_params, headers
      rescue => e
        response =  JSON.parse(e.response.to_s)
        raise "#{response['error']}: #{response['error_description']}"
      end

    end
  end
end