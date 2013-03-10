require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'

require File.join(File.dirname(__FILE__), '../../src/parse/common')

def parse_data(string, regex)
    r = Regexp.new(regex, Regexp::IGNORECASE)
    return [] if string.nil?
    return string.scan(r) 

end

url = "http://www.bhphotovideo.com/bnh/controller/home?O=&sku=891225&Q=&is=REG&A=details"
doc = Nokogiri::HTML(open(url))

a = parse_detail(:cpu_speed, doc.to_s) + [" "]
s = a.flatten.join("ghz ")

p parse_detail(:cpu_speed, s)

p parse_data(doc.to_s, "(\\d+\\.\\d*)\\s*ghz")