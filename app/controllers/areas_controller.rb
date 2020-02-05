class AreasController < ApplicationController

  def index
    locations = Locations.all
    render json: locations
  end

  def inside
  end
end
