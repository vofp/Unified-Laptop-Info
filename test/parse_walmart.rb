require File.join(File.dirname(__FILE__), "../src/parse/walmart")
require File.join(File.dirname(__FILE__), '../src/regex_details/edit')
require "test/unit"

$specs_walmart = {"Processor Brand:"=>"Intel", "Walmart No.:"=>"551072641", "Operating System:"=>"Windows 8 64-bit", "Resolution:"=>"1366 x 768", "Screen Type:"=>"LED Backlight, HD Touchscreen Display", "Hard Drive Size:"=>"24 GB", "Accessories Included:"=>"Power Cord,Battery", "Network Connection:"=>"10/100/1000 Gigabit Ethernet & 802.11b/g/n Wireless LAN", "Name"=>"Asus Grey 14.1\" S400CA-DH51T Ultrabook PC with Intel Core i5-3317U Processor and Windows 8 Operating System", "Maximum Memory Expansion:"=>"4 GB", "Platform:"=>"PC", "Graphics Card:"=>"Intel HD Graphics 4000", "Primary Color:"=>"Gray", "Model No.:"=>"Asus S400CA-DH51T", "Connector Type:"=>"1 x DC-in, 1 x Ethernet, 1 x HDMI, 1 x Headphone/Microphone, 2 x USB 2.0, 1 x USB 2.0/3.0, 1 x VGA", "Price"=>"$699.", "Product in Inches (L x W x H):"=>"13.3\302\240x\302\2409.4\302\240x\302\2400.8", "System Ram:"=>"4 GB", "Battery Type:"=>"Lithium Ion", "Laptop Screen Size:"=>"14.0 inch", "Processor Type:"=>"Intel Core i5-3317U Processor", "Processor Speed:"=>"1.70 GHz, with a Max Turbo Speed of 2.60 GHz", "Shipping Weight (in pounds):"=>"6.0", "Card Reader Type:"=>"1 x SD Card Reader"}


class TestParseWalmart < Test::Unit::TestCase
 
    def test_parse_site()
        url = "http://www.walmart.com/ip/Asus-Grey-14.1-S400CA-DH51T-Ultrabook-PC-with-Intel-Core-i5-3317U-Processor-and-Windows-8-Operating-System/22306737?ci_src=14110944&ci_sku=22306737&sourceid=1500000000000003142050"
        specs = parse_walmart_site(url)
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

    def test_organizer
        p output = organizer_walmart($specs_walmart)
        # assert_equal([["1.70"], ["2.60"]],output[:cpu_speed])
        # assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["24", "gb"]],output[:hd_size])
        # assert_equal([["4"], ["4"]],output[:ram_size])
        # assert_equal([["14.0", "inch"]],output[:screen_size])
    end
 
end