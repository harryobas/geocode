require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  let(:locations){File.read(File.expand_path("spec/fixtures/locations.json"))}
  let(:valid_geo_location){
    {type: "Feature", geometry: {type: "Point", coordinates: [7.36083984375, 50.666872321810715]}, properties: {} }
  }

  describe "GET #index" do
    it "returns a success response" do
      Locations.expects(:all).returns(locations)
      get :index, params: {}
      expect(response).to be_successful
    end
    it "renders JSON response" do
      Locations.expects(:all).returns(locations)
      get :index, params: {}
      expect(response.content_type).to eq ('application/json')
    end
  end

  describe "POST #inside" do
    context "when incoming geo location is inside list of areas" do
      it "returns true" do
        post :inside, params: valid_geo_location
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['inside']).to eq true

      end
    end

  end


end
