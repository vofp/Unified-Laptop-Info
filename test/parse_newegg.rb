require File.join(File.dirname(__FILE__), "../src/parse/newegg")
require "test/unit"


class TestParseNewegg < Test::Unit::TestCase
 
    def test_parse_newegg()
        url = "http://www.newegg.com/Product/Product.aspx?Item=N82E16834230770"
        specs = parse_newegg_site(url)
        assert(!specs.empty?, "Website should have been parsed, and specs should not be empty.")
        assert_equal(specs["Name"],"ASUS VivoBook S400CA-DH51T Touchscreen Ultrabook", "Name of laptop is incorrect")
    end

    def test_parse_invalid()
        url = "http://www.newegg.com/Product"
        begin
            specs = parse_newegg_site(url)
        rescue OpenURI::HTTPError
            specs = {}
        end

        assert(specs.empty?, "Parser should not have been able to parse this page.")
    end
 
end