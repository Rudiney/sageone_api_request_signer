# Sageone Api Request Signer

This gem do the signing process needed to make every request to a [SageOne](http://www.sageone.com) API.

The signing proccess is described here: [https://developers.sageone.com/docs#signing_your_requests](https://developers.sageone.com/docs#signing_your_requests)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sageone_api_request_signer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sageone_api_request_signer

## Usage

To create the signature string, you need to provide these data:

```ruby
  @signer = SageoneApiRequestSigner.new({
    request_method: 'post',
    url: 'https://api.sageone.com/test/accounts/v1/contacts?config_setting=foo',
    body_params: {
      'contact[contact_type_id]' => 1,
      'contact[name]' => 'My Customer'
    },
    signing_secret: 'TestSigningSecret',
    access_token: 'TestToken',
  })
```

With the `@signer` you can get the request headers related to the signature part:

```ruby
  @signer.request_headers
  => {
  =>   'Authorization' => "Bearer #{@signer.access_token}",
  =>   'X-Nonce' => @signer.nonce,
  =>   'X-Signature' => @signer.signature,
  => }

```

You can see a real example here: [Integration test making a real api call to a test endpoint](spec/integration/check_signature_data_spec.rb)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sageone_api_request_signer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
