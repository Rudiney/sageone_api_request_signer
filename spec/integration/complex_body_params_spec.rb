require 'rest_client'
require 'json'

RSpec.describe 'testing complex body params' do
  subject do
    SageoneApiRequestSigner.new({
      request_method: 'post',
      url: 'https://api.sageone.com/test/accounts/v1/contacts',
      signing_secret: 'TestSigningSecret',
      access_token: 'TestToken',
    })
  end

  let(:headers) do
    subject.request_headers.merge({
      'Accept' => '*/*',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'User-Agent' => 'NPSS'
    })
  end

  it 'with multi-level hashes' do
    subject.body_params = {
      first: 'level',
      second: {
        multi: 'level',
        third: {
          level: 'the last one'
        },
        ok: 'this is enough'
      }
    }

    check_signature!
  end

  it 'with something like "arrays"' do
    subject.body_params = {
      simple: 'param',
      complex: {
        0 => {one:11, two:12, three:13},
        1 => {one:21, two:22, three:23},
      }
    }
    check_signature!
  end

  def check_signature!
    RestClient.post subject.url, subject.body_params, headers

    rescue => e
      raise e unless e.respond_to? :response

      response = JSON.parse(e.response.to_s)

      expect(subject.nonce).to eql(response['nonce'])
      expect(subject.request_method).to eql(response['request_method'])
      expect(subject.access_token).to eql(response['token'])
      expect(subject.base_url).to eql(response['base_url'])
      expect(subject.parameter_string).to eql(response['parameter_string'])
      expect(subject.signature_base_string).to eql(response['signature_base_string'])
      expect(subject.signing_secret).to eql(response['signing_secret'])
  end
end