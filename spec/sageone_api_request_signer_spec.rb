RSpec.describe SageoneApiRequestSigner do
  it { expect(subject).to respond_to :request_method }
  it { expect(subject).to respond_to :url }
  it { expect(subject).to respond_to :body_params }
  it { expect(subject).to respond_to :nonce }
  it { expect(subject).to respond_to :secret }
  it { expect(subject).to respond_to :token }

  it 'should set everything on initialize' do
    obj = described_class.new(
      request_method: 'method',
      url: 'url',
      body_params: 'body',
      nonce: 'nonce',
      secret: 'secret',
      token: 'token',
    )

    expect(obj.request_method).to eql 'METHOD'
    expect(obj.url).to            eql 'url'
    expect(obj.body_params).to    eql 'body'
    expect(obj.nonce).to          eql 'nonce'
    expect(obj.secret).to         eql 'secret'
    expect(obj.token).to          eql 'token'
  end

  describe '#nonce' do
    it 'should build a rondom one by default' do
      expect(SecureRandom).to receive(:hex).once.and_return('random nonce')
      obj = described_class.new

      expect(obj.nonce).to eql 'random nonce'
    end
  end

  describe '#uri' do
    it 'should be an URI with the URL' do
      subject.url = 'http://www.google.com.br'
      expect(subject.uri).to eql URI('http://www.google.com.br')
    end
  end

  describe '#base_url' do
    describe 'using the default port' do
      before { subject.url = 'https://api.sageone.com/accounts/v1/contacts?config_setting=foo' }
      it { expect(subject.base_url).to eql 'https://api.sageone.com/accounts/v1/contacts' }
    end

    describe 'with a specific port' do
      before { subject.url = 'https://api.sageone.com:123/accounts/v1/contacts?config_setting=foo' }
      it { expect(subject.base_url).to eql 'https://api.sageone.com:123/accounts/v1/contacts' }
    end
  end

  describe '#url_params' do
    it 'should give me a has from the url query' do
      subject.url = 'https://api.sageone.com/accounts/v1/contacts?response_type=code&client_id=4b64axxxxxxxxxx00710&scope=full_access'

      expect(subject.url_params).to eql({
        'response_type' => 'code',
        'client_id' => '4b64axxxxxxxxxx00710',
        'scope' => 'full_access'
      })
    end
  end

  describe '#parameter_string' do
    it 'should match the website example' do
      subject.url = 'https://api.sageone.com/accounts/v1/contacts?config_setting=foo'
      subject.body_params = {
        'contact[contact_type_id]' => 1,
        'contact[name]' => 'My Customer',
      }

      expect(subject.parameter_string).to eql 'config_setting=foo&contact%5Bcontact_type_id%5D=1&contact%5Bname%5D=My%20Customer'
    end

    it 'should sort the params' do
      subject.url = 'https://api.sageone.com/accounts/v1/contacts?zee=4&bee=2'
      subject.body_params = {
        'aaa' => 1,
        'dee' => 3,
      }

      expect(subject.parameter_string).to eql 'aaa=1&bee=2&dee=3&zee=4'
    end
  end
end