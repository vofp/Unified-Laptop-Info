require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
url = "http://www.newegg.com/Product/Product.aspx?Item=N82E16834230770"
doc = Nokogiri::HTML(open(url))

specs = {}

doc.css(".price-main-product").first

specs["Name"] = doc.css(".wrapper span").first.text.strip

doc.css("#Specs dl").each do |item|
    key = item.at_css("dt").text
    data = item.at_css("dd").text
    specs[key] = data
end

# specs.each_pair{ |key, data|
#     puts "#{key}: #{data}"
# }
r = Regexp.new("(\\d+\\.\\d*)\\s*ghz", Regexp::IGNORECASE)
puts r
p r.match(specs["CPU Type"])
p r.match(specs["CPU Speed"]).captures
p r.match(specs["CPU Support"]).captures

r = Regexp.new("(\\d+)\\s*x\\s*(\\d+)", Regexp::IGNORECASE)
p r.match(specs["Resolution"]).captures


r = Regexp.new("(\\d+)(gb|tb)", Regexp::IGNORECASE)
p r.match(specs["Hard Disk"]).captures
p r.match(specs["HDD"]).captures

r = Regexp.new("(\\d+)gb", Regexp::IGNORECASE)
p r.match(specs["Memory Size"]).captures
p r.match(specs["Memory"]).captures


r = Regexp.new("(\\d+\\.?\\d*)\"", Regexp::IGNORECASE)
p r.match(specs["Screen Size"]).captures
p r.match(specs["Screen"]).captures