require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
url = "http://www.walmart.com/ip/Asus-Grey-14.1-S400CA-DH51T-Ultrabook-PC-with-Intel-Core-i5-3317U-Processor-and-Windows-8-Operating-System/22306737?ci_src=14110944&ci_sku=22306737&sourceid=1500000000000003142050"
doc = Nokogiri::HTML(open(url))

specs = {}

specs["Name"] = doc.css(".productTitle").first.text.strip

specs["Price"] = doc.css(".bigPriceText1").first.text.strip

doc.css(".SpecTable tr").each do |item|
	begin
		key = item.at_css("td:nth-child(1)").text.strip
		data = item.at_css("td:nth-child(2)").text.strip
		specs[key] = data
	rescue Exception
			
	end
end

specs.each_pair{ |key, data|
    puts "#{key}, #{data}"
}
