require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'

require File.join(File.dirname(__FILE__), '../regex_details/edit')
 
$o_c_spec = {
    :screen_size=>{ 
        "14.1\""=>{:count=>1, :votes=>0, :data=>["14.1", "\""], :sort=>14.1},
        "14.0\""=>{:count=>3, :votes=>0, :data=>["14", "\""], :sort=>14.0}},
    :cpu_speed=>{
        "1.70GHz"=>{:count=>3, :votes=>0, :data=>["1.70"], :sort=>1.7},
        "2.60GHz"=>{:count=>2, :votes=>0, :data=>["2.6"], :sort=>2.6}},
    :resolution=>{
        "1366 x 768"=>{:count=>3, :votes=>0, :data=>["1366", "768"], :sort=>1366}},
    :hd_size=>{
        "500GB"=>{:count=>3, :votes=>0, :data=>["500", "gb"], :sort=>500},
        "24GB"=>{:count=>4, :votes=>0, :data=>["24", "gb"], :sort=>24}},
    :memory_size=>{
        "4GB"=>{:count=>5, :votes=>0, :data=>["4"], :sort=>4}}
}

require File.join(File.dirname(__FILE__), 'common')

require File.join(File.dirname(__FILE__), 'organizer')
require File.join(File.dirname(__FILE__), '../regex_details/edit')


def organize_any(string)
    load_regex
    output = {}
    $regex.each{ |detail, array|
        output[detail] = parse_detail(detail,
            string
        )   
    }
    return output
end

def parse_any_site(url)
    doc = Nokogiri::HTML(open(url))

    specs = organize_any(doc.to_s)

    return specs
rescue OpenURI::HTTPError => e
    raise e
end

new_regex

url = "http://www.bhphotovideo.com/bnh/controller/home?O=&sku=891225&Q=&is=REG&A=details"

spec = parse_any_site(url)

p combine_any($o_c_spec, spec)
