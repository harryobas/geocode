require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  let(:locations){File.read(File.expand_path("spec/fixtures/locations.json"))}

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


end
