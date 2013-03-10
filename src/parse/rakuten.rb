require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'


require File.join(File.dirname(__FILE__), 'common')

def organizer_rakuten(specs)
    return organize_details(:rakuten,specs)
end

def parse_rakuten_site(url)
    doc = Nokogiri::HTML(open(url))

    specs = {}

    specs["Name"] = doc.css(".pr-hidden-title").first.text.strip

    # specs["Price"] = doc.css("#spanMainTotalPrice").first.text.strip

    doc.css("#featuresAndSpecs tr").each do |item|
        begin
            key = item.at_css("td:nth-child(2)").text.strip
            data = item.at_css("td:nth-child(3)").text.strip
            specs[key] = data
        rescue NoMethodError
            next
        end
    end
    return specs
rescue OpenURI::HTTPError => e
    raise 
end


# url = "http://www.buy.com/prod/asus-vivobook-s400ca-dh51t-14-1-led-ultrabook-intel-core-i5-i5-3317u-1/242783117.html?listingId=250509702"

# specs = parse_rakuten_site(url)
# p organizer_rakuten(specs)
# puts specs.keys