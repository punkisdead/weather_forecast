require 'rails_helper'

RSpec.describe SearchWeather do
  subject { described_class.new }
  let(:interactors) do
    [
      GeocodeAddress,
      ParseGeocodeInfo,
      FetchWeather
    ]
  end

  before do
    interactors.each do |interactor|
      allow(interactor).to receive(:call!) { :success }
    end
  end

  it { is_expected.to be_kind_of(Interactor::Organizer) }
  it 'organizes the correct interactors' do
    expect(described_class.organized).to eq(interactors)
  end
end
