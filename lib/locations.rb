class Locations

  Geographical_locations = "#{Rails.root}/data/Given_areas.json"
  Geo_json = JSON.parse(File.read(Geographical_locations), object_class: OpenStruct)

  def self.all
    File.read(Geographical_locations)
  end

  def self.inside?(geo_location)
    raise StandardError, "incomplete coordinates" if geo_location.size < 2
    locations_list = Geo_json.features.map{|f| f.geometry.coordinates}.flatten(2)
    geo_location = [geo_location.first.to_f, geo_location.last.to_f]
    locations_list.include?(geo_location)
  end


end
