require "csv"
require "date"
require "json"

$json_dir = ARGV.fetch(0)

def collection_hours(day)
  ->(j) do
    last_col = j.fetch("locationServiceHours", []).find { |o| o["name"] == "LASTCOLLECTION" }
    return nil if !last_col
    daily_hours = last_col.fetch("dailyHoursList").find { |dh| dh["dayOfTheWeek"] == day }
    reutrn nil if !daily_hours
    close = daily_hours.dig("times", 0, "close")
    return nil if !close
    time = DateTime.strptime(close, "%T").strftime("%I:%M %p")
    "#{day} #{time}"
  end
end

FIELDS = {
  "OUTLETID" => ->(j) { j["locationID"] },
  "BUSNAME" => ->(j) { j["locationName"] },
  "ADDR1" => ->(j) { j["address1"] },
  "CITY" => ->(j) { j["city"] },
  "STATE" => ->(j) { j["state"] },
  "ZIP" => ->(j) { j["zip5"] },
  "COLLECTIONHOURS1" => collection_hours("MO"),
  "COLLECTIONHOURS2" => collection_hours("TU"),
  "COLLECTIONHOURS3" => collection_hours("WE"),
  "COLLECTIONHOURS4" => collection_hours("TH"),
  "COLLECTIONHOURS5" => collection_hours("FR"),
  "COLLECTIONHOURS6" => collection_hours("SA"),
  "COLLECTIONHOURS7" => collection_hours("SU"),
  "LATITUDE" => ->(j) { j["latitude"] },
  "LONGITUDE" => ->(j) { j["longitude"] }
}

def locations
  Enumerator.new do |y|
    Dir.glob("#{$json_dir}/*.json").each do |json_file|
      json = JSON.parse(IO.read(json_file))
      json.fetch("locations", []).each do |location|
        y << location
      end
    rescue JSON::ParserError
      # ignore; there's a messed-up file
    end
  end
end

# a given collection box (a "location") can appear in multiple files
def unique_locations
  locations.lazy.uniq { |l| l['locationID'] }
end

def output_csv
  CSV do |csv_out|
    csv_out << FIELDS.keys
    unique_locations.each do |location|
      csv_out << FIELDS.values.map { |l| l.call(location) }
    end
  end
end

output_csv
