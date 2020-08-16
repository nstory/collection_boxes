require "csv"
require "pry"

# diff.rb <added|removed>
# Lists collection boxes that were added/removed between Sep 2019 (when
# coll_report.csv was received via FOIA from USPS) and 8/15/2020.
#
# A collection box is considered removed if both 1. the OUTLETID is not present
# in the new file AND 2. the address (ADDR1 + ZIP) is not present in the new file.

BOXES_FILE_2019 = "coll_report.csv"
BOXES_FILE_2020 = "collection_boxes_2020-08-15.csv"

def csv(file)
  CSV.foreach(file, headers: true)
end

def headers(file)
  CSV.foreach(file).first
end

def set(file)
  csv(file)
    .map { |row| [yield(row), true] }
    .to_h
end

def address_key(row)
  # 1234 -> 01234
  zip = row['ZIP'].rjust(5, "0")
  addr = row['ADDR1'].strip.upcase
  "#{addr} #{zip}"
end

# set of addresses (ADDR1 + ZIP) that appear in file
def address_set(file)
  set(file) { |row| address_key(row) }
end

def id_key(row)
  row['OUTLETID'].sub(/^0+/, "").strip
end

# set of OUTLETIDs that appear in file
def id_set(file)
  set(file) { |row| id_key(row) }
end

# outputs rows in original that do not appear in comp
def output_missing(original, comp)
  address_set_comp = address_set(comp)
  id_set_comp = id_set(comp)
  puts headers(original).to_csv
  csv(original)
    .reject { |row| address_set_comp[address_key(row)] }
    .reject { |row| id_set_comp[id_key(row)] }
    .each do |row|
      puts row.to_csv
    end
end

def removed
  output_missing(BOXES_FILE_2019, BOXES_FILE_2020)
end

def added
  output_missing(BOXES_FILE_2020, BOXES_FILE_2019)
end

send(ARGV[0].to_sym)
