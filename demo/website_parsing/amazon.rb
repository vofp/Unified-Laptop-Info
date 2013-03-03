require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
url = "http://www.amazon.com/VivoBook-S400CA-DH51T-14-1-Inch-Touch-Ultrabook/dp/B009F1JL5A"
doc = Nokogiri::HTML(open(url))

specs = {}

specs["Name"] = doc.css("#btAsinTitle").first.text.strip

specs["Price"] = doc.css(".priceLarge").first.text.strip

doc.css("#prodDetails tr").each do |item|
	begin
		key = item.at_css(".label").text.strip
		data = item.at_css(".value").text.strip
		specs[key] = data
	rescue Exception
			
	end
end

puts specs.keys
