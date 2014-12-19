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
end