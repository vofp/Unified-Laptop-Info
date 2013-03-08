require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'

require File.join(File.dirname(__FILE__), 'common')

def organizer_walmart(specs)
    dataDictionary = {
        :cpu_speed => [
            "Processor Type:",
            "Processor Speed:"],
        :resolution => [
            "Resolution:"],
        :hd_size => [
            "Hard Drive Size:"],
        :memory_size => [
            "Maximum Memory Expansion:",
            "System Ram:"],
        :screen_size => [
            "Laptop Screen Size:"]
    }
    return organize_details(dataDictionary,specs)
end

def parse_walmart_site(url)
    doc = Nokogiri::HTML(open(url))

    specs = {}

    specs["Name"] = doc.css(".productTitle").first.text.strip

    specs["Price"] = doc.css(".bigPriceText1").first.text.strip

    doc.css(".SpecTable tr").each do |item|
        begin
    		key = item.at_css("td:nth-child(1)").text.strip
    		data = item.at_css("td:nth-child(2)").text.strip
    		specs[key] = data
        rescue NoMethodError
            next
        end
    end
    return specs
rescue OpenURI::HTTPError => e
    raise 
end
