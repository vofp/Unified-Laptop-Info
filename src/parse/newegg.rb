require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 

def parse_newegg(url)
    doc = Nokogiri::HTML(open(url))

    specs = {}

    doc.css(".price-main-product").first

    specs["Name"] = doc.css(".wrapper span").first.text.strip

    doc.css("#Specs dl").each do |item|
        key = item.at_css("dt").text
        data = item.at_css("dd").text
        specs[key] = data
    end

    return specs
rescue OpenURI::HTTPError => e
    raise e
end