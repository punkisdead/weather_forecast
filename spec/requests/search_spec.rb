require 'rails_helper'

RSpec.describe "Search", type: :request do
  describe "GET /search" do
    context "no search performed" do
      before do
        get "/search"
      end

      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "does not display any results" do
        expect(response.body).to_not include("Current Temp:")
      end
    end

    context "with valid address" do
      before do
        get "/search?query=2066+Crist+Drive+Los+Altos%2C+Ca"
      end

      it "searches for the weather" do
        expect(response.body).to include("Current Temp:")
      end
    end

    context "with invalid address" do
      before do
        get "/search?query=a"
      end

      it "does not display any results" do
        expect(response.body).to_not include("Current Temp:")
      end

      it "renders the error message" do
        expect(response.body).to include("No geocode info found")
      end
    end

    context "with address that can't resolve to single postal code" do
      before do
        get "/search?query=New+York+NY"
      end

      it "does not display any results" do
        expect(response.body).to_not include("Current Temp:")
      end

      it "renders the error message" do
        expect(response.body).to include("No postal code found")
      end
    end
  end
end
