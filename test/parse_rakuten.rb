require "../src/parse/rakuten"
require "test/unit"

$specs_rakuten = {"Hard Drive Capacity"=>"500 GB", "Product Type"=>"Ultrabook", "Height"=>"0.8\"", "Green Compliance Certificate/Authority"=>"RoHS", "Graphics Controller Model"=>"HD 4000", "Green Compliant"=>"Yes", "Memory Technology"=>"DDR3 SDRAM", "Product Series"=>"S400", "Display Screen Type"=>"Active Matrix TFT Color LCD", "Total Number of USB Ports"=>"3", "Operating System Architecture"=>"64-bit", "Processor Type"=>"Core i5", "Processor Speed"=>"1.70 GHz", "Package Contents"=>"VivoBook S400CA-DH51T UltrabookLithium Ion BatteryAC Adapter", "Touchscreen"=>"Yes", "Screen Mode"=>"HD", "Screen Size"=>"14.1\"", "HDMI"=>"Yes", "Operating System"=>"Genuine Windows 8", "Cache"=>"3 MB", "Width"=>"13.3\"", "Weight (Approximate)"=>"4.40 lb", "Wi-Fi"=>"Yes", "Brand Name"=>"Asus", "Screen Resolution"=>"1366 x 768", "Webcam"=>"Yes", "Processor Manufacturer"=>"Intel", "Solid State Drive Capacity"=>"24 GB", "Color"=>"Black", "Product Name"=>"VivoBook S400CA-DH51T Ultrabook", "Manufacturer"=>"ASUS Computer International", "Manufacturer Part Number"=>"S400CA-DH51T", "Graphics Controller Manufacturer"=>"Intel", "Processor Core"=>"Dual-core (2 Core)", "Wi-Fi Standard"=>"IEEE 802.11b/g/n", "Graphics Memory Accessibility"=>"Shared", "Name"=>"Asus VivoBook S400CA-DH51T 14.1\" HD Touchscreen Ultrabook, Intel Cor i5-3317U, 4GB RAM, 500GB HDD+24GB SSD, Windows 8", "64-bit Processing"=>"Yes", "Depth"=>"9.4\"", "Battery Chemistry"=>"Lithium Ion (Li-Ion)", "Processor Model"=>"i5-3317U", "Backlight Technology"=>"LED", "Aspect Ratio"=>"16:9", "Number of Cells"=>"3-cell", "Standard Memory"=>"4 GB", "Product Line"=>"VivoBook", "Product Model"=>"S400CA-DH51T", "Manufacturer Website Address"=>"usa.asus.com"}

class TestParseRakuten < Test::Unit::TestCase
 
    def test_parse_site()
        url = "http://www.buy.com/prod/asus-vivobook-s400ca-dh51t-14-1-led-ultrabook-intel-core-i5-i5-3317u-1/242783117.html?listingId=250509702"
        specs = parse_rakuten_site(url)
        assert(!specs.empty?, "Website should have been parsed, and specs should not be empty.")
        assert_equal(specs["Name"],"Asus VivoBook S400CA-DH51T 14.1\" HD Touchscreen Ultrabook, Intel Cor i5-3317U, 4GB RAM, 500GB HDD+24GB SSD, Windows 8", "Name of laptop is incorrect")
    end

    def test_parse_invalid()
        url = "http://www.newegg.com/Product"
        begin
            specs = parse_rakuten_site(url)
        rescue OpenURI::HTTPError
            specs = {}
        end

        assert(specs.empty?, "Parser should not have been able to parse this page.")
    end

    def test_organizer
        p output = organizer_rakuten($specs_rakuten)
        assert_equal([["1.70"]],output[:cpu_speed])
        assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["500", "gb"], ["24", "gb"]],output[:hd_size])
        assert_equal([["4"]],output[:memory_size])
        assert_equal([["14.1", "\""]],output[:screen_size])
    end

end