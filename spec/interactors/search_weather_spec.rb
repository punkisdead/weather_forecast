require 'rails_helper'

RSpec.describe SearchWeather do
  subject { described_class.new }

  before do
    allow(GeocodeAddress).to receive(:call!) { :success }
    allow(FetchWeather).to receive(:call!) { :success }
  end

  it { is_expected.to be_kind_of(Interactor::Organizer) }
  it 'organizes the correct interactors' do
    expect(described_class.organized).to eq([GeocodeAddress, FetchWeather])
  end
end
