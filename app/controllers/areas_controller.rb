class AreasController < ApplicationController

  def index
    locations = Locations.all
    render json: locations
  end

  def inside
    if params[:geometry][:type] != "Point"
      return render json: {error: "incorret location type"}, status: :unprocessable_entity
    end
    result = Locations.inside?(params[:geometry][:coordinates])
    render json: {inside: result}
  end
end
