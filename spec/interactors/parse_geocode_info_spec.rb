require 'rails_helper'

RSpec.describe ParseGeocodeInfo do
  subject { described_class.call(geocoded_address: geocoded_address) }

  let(:geocoded_address) { OpenStruct.new(latitude: lat, longitude: lon, postal_code: postal_code) }
  let(:lat) { 123 }
  let(:lon) { 234 }
  let(:postal_code) { "12345" }

  describe '.call' do
    context 'valid geocode address in context' do
      it { is_expected.to be_success }

      it 'sets the latitude in the context' do
        expect(subject.lat).to eq(lat)
      end

      it 'sets the longitude in the context' do
        expect(subject.lon).to eq(lon)
      end

      it 'sets the postal code in the context' do
        expect(subject.postal_code).to eq(postal_code)
      end
    end

    context 'no lat found in address' do
      let(:lat) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No latitude found")
      end
    end

    context 'no lon found in address' do
      let(:lon) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No longitude found")
      end
    end

    context 'no postal code found in address' do
      let(:postal_code) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No postal code found")
      end
    end
  end
end
