require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
def parse_walmart_site(url)
    doc = Nokogiri::HTML(open(url))

    specs = {}

    specs["Name"] = doc.css(".productTitle").first.text.strip

    specs["Price"] = doc.css(".bigPriceText1").first.text.strip

    doc.css(".SpecTable tr").each do |item|
		key = item.at_css("td:nth-child(1)").text.strip
		data = item.at_css("td:nth-child(2)").text.strip
		specs[key] = data
    end
    return specs
rescue OpenURI::HTTPError => e
    raise 
end
