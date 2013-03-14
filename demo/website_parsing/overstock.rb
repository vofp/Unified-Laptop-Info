require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
url = "http://www.overstock.com/Electronics/Asus-S400CA-DH51T-14.1-LED-Ultrabook-Intel-Core-i5-i5-3317U-1.70-G/7458742/product.html?cid=123620"
doc = Nokogiri::HTML(open(url))

specs = {}

specs["Name"] = doc.css("h1").first.text.strip

specs["Price"] = doc.css(".Ovalue").first.text.strip

doc.css("#details_descFull li").each do |item|
	begin
		details = item.text.strip.split(":")
		details.map!{|x| 
			x.strip
		}
		key, data = details

		#key = item.at_css(".label").text.strip
		#data = item.at_css(".value").text.strip
		specs[key] = data
	rescue Exception
			
	end
end

specs.each_pair{ |key, data|
    puts "#{key}, #{data}"
}
