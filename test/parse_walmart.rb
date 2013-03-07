require "../src/parse/walmart"
require "test/unit"


class TestParseNewegg < Test::Unit::TestCase
 
    def test_parse_newegg()
        url = "http://www.walmart.com/ip/Asus-Grey-14.1-S400CA-DH51T-Ultrabook-PC-with-Intel-Core-i5-3317U-Processor-and-Windows-8-Operating-System/22306737?ci_src=14110944&ci_sku=22306737&sourceid=1500000000000003142050"
        p specs = parse_walmart_site(url)
        assert(!specs.empty?, "Website should have been parsed, and specs should not be empty.")
        assert_equal(specs["Name"],"Asus Grey 14.1\" S400CA-DH51T Ultrabook PC with Intel Core i5-3317U Processor and Windows 8 Operating System", "Name of laptop is incorrect")
    end

    def test_parse_invalid()
        url = "http://www.newegg.com/Product"
        begin
            specs = parse_walmart_site(url)
        rescue OpenURI::HTTPError
            specs = {}
        end

        assert(specs.empty?, "Parser should not have been able to parse this page.")
    end
 
end