require 'spec_helper'

describe 'foreman_proxy_content::host_from_url' do

  it { expect(subject).not_to eq(nil) }
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params('').and_raise_error(ArgumentError) }
  it { is_expected.to run.with_params('just a string').and_raise_error(ArgumentError) }

  context 'with basic URL' do
    let(:url) { 'https://test.example.com' }

    it { is_expected.to run.with_params(url).and_return('test.example.com') }
  end

  context 'with path on the URL' do
    let(:url) { 'https://test.example.com/api/v2/blah' }

    it { is_expected.to run.with_params(url).and_return('test.example.com') }
  end

  context 'with trailing /' do
    let(:url) { 'https://test.example.com/' }

    it { is_expected.to run.with_params(url).and_return('test.example.com') }
  end
end
