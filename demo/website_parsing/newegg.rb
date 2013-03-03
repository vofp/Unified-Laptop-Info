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

puts specs.keys
