require 'rails_helper'

RSpec.describe FetchWeather do
  subject { described_class.call(lat: lat, lon: lon, postal_code: postal_code) }

  let(:lat) { 123 }
  let(:lon) { 234 }
  let(:postal_code) { "12345" }
  let(:forecast) { OpenStruct.new(main: 'Some forecast data') }

  before do
    allow(OpenWeatherClient).to receive(:current_weather).and_return(forecast)
  end

  describe '.call' do
    context 'when result is cached' do
      before do
        allow(Rails.cache).to receive(:fetch).and_return(forecast)
      end

      it { is_expected.to be_success }

      it 'returns the forecast data' do
        expect(subject.forecast).to eq(forecast.main)
      end

      it 'sets the cached flag to true' do
        subject

        expect(subject.cached).to be_truthy
      end
    end

    context 'when result is not cached' do
      it { is_expected.to be_success }

      it 'returns the forecast data' do
        expect(subject.forecast).to eq(forecast.main)
      end

      it 'sets the cached flag to true' do
        subject

        expect(subject.cached).to be_falsey
      end
    end

    context 'when OpenWeatherClient raises error' do
      before do
        allow(OpenWeatherClient).to receive(:current_weather).and_raise(Faraday::ClientError.new("oops"))
      end

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("Unable to retrieve forecast")
      end
    end

    context 'when result is missing the forecast' do
      let(:forecast) { OpenStruct.new }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No weather forecast found")
      end
    end

    context 'when lat missing' do
      let(:lat) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No lat/lon found")
      end
    end

    context 'when lon missing' do
      let(:lon) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No lat/lon found")
      end
    end

    context 'when postal code is missing' do
      let(:postal_code) { nil }

      it { is_expected.to be_a_failure }

      it 'sets the failure message' do
        expect(subject.message).to eq("No postal code found")
      end
    end
  end
end
