require 'rails_helper'

RSpec.describe AreasController, type: :controller do

  let(:valid_geo_location){
    {type: "Feature", geometry: {type: "Point", coordinates: [7.36083984375, 50.666872321810715]}, properties: {} }
  }

  let(:invalid_geo_location){
    {type: "Feature", geometry: {type: "Point", coordinates: [7.3, 50.666872321810715]}, properties: {} }
  }

  let(:wrong_geo_location){
    {type: "Feature", geometry: {type: "Polygon", coordinates: [7.3, 50.666872321810715]}, properties: {} }
  }

  let(:incomplete_coordinates){
    {type: "Feature", geometry: {type: "Point", coordinates: [7.3]}, properties: {} }
  }

  let(:empty_coordinates){
    {type: "Feature", geometry: {type: "Point", coordinates: []}, properties: {} }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
    it "returns list of all areas" do
      Locations.expects(:all)
      get :index, params: {}
    end
    it "renders JSON response" do
      get :index, params: {}
      expect(response.content_type).to eq ('application/json')
    end
  end

  describe "POST #inside" do
    it "renders JSON response" do
      get :index, params: valid_geo_location
      expect(response.content_type).to eq ('application/json')
    end
    context "when incoming geo location is inside list of areas" do
      it "returns true" do
        post :inside, params: valid_geo_location
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['inside']).to eq true
      end
    end
    context "when incoming geo location is not inside list of areas" do
      it "returns false" do
        post :inside, params: invalid_geo_location
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['inside']).to eq false
      end
    end
    context "when incoming location is not of type point" do
      it "returns error" do
        post :inside, params: wrong_geo_location
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq "incorret location type"
      end
    end
    context "when incoming location has incomplete coordinates" do
      it "returns error" do
        post :inside, params: incomplete_coordinates
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq "incomplete coordinates"
      end
    end

  end


end
