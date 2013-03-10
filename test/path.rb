require File.join(File.dirname(__FILE__), "../src/parse/any")
require File.join(File.dirname(__FILE__), "../src/parse/common")
require File.join(File.dirname(__FILE__), "../src/parse/newegg")
require File.join(File.dirname(__FILE__), "../src/parse/organizer")
require File.join(File.dirname(__FILE__), "../src/parse/rakuten")
require File.join(File.dirname(__FILE__), "../src/parse/walmart")
require "test/unit"

class TestParseAll < Test::Unit::TestCase

    def test_parse_all
        url = "http://www.newegg.com/Product/Product.aspx?Item=N82E16834230770"
        specs = parse_newegg_site(url)
        newegg_specs = organizer_newegg(specs)

        url = "http://www.buy.com/prod/asus-vivobook-s400ca-dh51t-14-1-led-ultrabook-intel-core-i5-i5-3317u-1/242783117.html?listingId=250509702"
        specs = parse_rakuten_site(url)
        rakuten_specs = organizer_rakuten(specs)
        
        url = "http://www.walmart.com/ip/Asus-Grey-14.1-S400CA-DH51T-Ultrabook-PC-with-Intel-Core-i5-3317U-Processor-and-Windows-8-Operating-System/22306737?ci_src=14110944&ci_sku=22306737&sourceid=1500000000000003142050"
        specs = parse_walmart_site(url)
        walmart_specs = organizer_walmart(specs)

        p c_spec = combine(new_complete_spec, newegg_specs, rakuten_specs, walmart_specs)    

        url = "http://www.bhphotovideo.com/bnh/controller/home?O=&sku=891225&Q=&is=REG&A=details"
        spec = parse_any_site(url)

        p c_spec = combine_any(c_spec, spec)

        url = "http://www.abt.com/product/66142/ASUS-S400CADH51T.html?utm_source=scfroogle&utm_medium=sc&utm_campaign=S400CADH51T&adtype=pla"
        spec = parse_any_site(url)

        p c_spec = combine_any(c_spec, spec)

        url = "http://www.samsclub.com/sams/14-1-touch-notebook-intel-core-i5-3317u/prod8170030.ip?refcd=GL05251200010028&pid=_CSE_Google_PLA_Office-Electronics&ci_src=17588969&ci_sku=sku8764026S"
        spec = parse_any_site(url)

        p c_spec = combine_any(c_spec, spec)
    end

end 