require 'rails_helper'

RSpec.describe GeocodeAddress do
  subject { described_class.call(address: "34th Street, New York City, USA") }

  let(:geocode_results) { [] }

  before do
    allow(Geocoder).to receive(:search).and_return(geocode_results)
  end

  describe '.call' do
    context 'address results returned' do
      let(:geocode_results) { [ 'foo', 'bar' ] }

      it { is_expected.to be_success }

      it 'returns the first address result returned' do
        expect(subject.geocoded_address).to eq('foo')
      end
    end

    context 'no results returned' do
      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No geocode info found")
      end
    end

    context 'when Geocoder raises error' do
      before do
        allow(Geocoder).to receive(:search).and_raise(Geocoder::Error.new("oops"))
      end

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("Unable to geocode address")
      end
    end
  end
end
