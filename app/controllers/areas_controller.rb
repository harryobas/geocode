class AreasController < ApplicationController

  def index
    locations = Locations.all
    render json: locations
  end

  def inside
    result = Locations.inside?(params[:geometry][:coordinates])
    render json: {inside: result}
  end
end
