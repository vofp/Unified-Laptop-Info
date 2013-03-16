require File.join(File.dirname(__FILE__), "../src/parse/newegg")
require File.join(File.dirname(__FILE__), '../src/regex_details/edit')
require "test/unit"

$specs_newegg = {"Card Reader"=>"SD only", "Max Memory Supported"=>"4GB", "HDD"=>"500GB HDD + 24GB SSD", "Graphic Type"=>"Integrated Card", "Screen Size"=>"14\"", "Weight"=>"4 lbs.", "Communication"=>"Gigabit LAN and WLAN", "Graphics Card"=>"Intel HD Graphics 4000", "Hard Disk"=>"500GB HDD+24GB SSD", "Memory Size"=>"4GB DDR3", "Color"=>"Gray", "Brand"=>"ASUS", "Audio Ports"=>"1 x Headphone-out & Audio-in Combo Jack", "CPU Type"=>"Intel Core i5", "Audio"=>"Built-in microphoneSonic Master", "LAN"=>"10/100/1000Mbps", "HDD RPM"=>"5400rpm", "Dimensions"=>"13.3\" x 9.4\" x 0.7\"-0.8\"", "AC Adapter"=>"65-watt AC adapter", "Usage"=>"Consumer", "Webcam"=>"0.3 Mega Pixel web camera (Fixed type)", "Speaker"=>"Integrated Stereo Speakers", "Video Port"=>"1 x VGA", "Video Memory"=>"Shared system memory", "Name"=>"ASUS VivoBook S400CA-DH51T Touchscreen Ultrabook", "Battery"=>"44WHrs, 4000mAh,3S1P, 3-cell Li-ion Battery pack", "Keyboard"=>"Chiclet Keyboard", "GPU/VPU"=>"Intel HD Graphics 4000", "LCD Features"=>"16:9 Display type: (Typical 220-nit) 16ms response timeNTSC:45%", "Series"=>"VivoBook", "USB"=>"2 x USB 2.01 x USB 3.0", "Memory"=>"4GB", "Style"=>"Ultrabook", "WLAN"=>"802.11b/g/n Wireless LAN", "Memory Spec"=>"4GB On Board", "Wide Screen Support"=>"Yes", "Accidental Damage Warranty"=>"1 Year Accidental Damage/30-Day Zero Bright Dot", "Type"=>"Mainstream", "CPU Support"=>"3MB L3 CacheMax Turbo Frequency 2.6 GHz", "CPU Speed"=>"3317U(1.70GHz)", "Operating System"=>"Windows 8 64-Bit", "Resolution"=>"1366 x 768", "Touchscreen"=>"Yes", "Screen"=>"14\"", "HDMI"=>"1 x HDMI", "Model"=>"S400CA-DH51T"}
$o_specs_newegg = {:memory_size=>[["4"], ["4"]], :screen_size=>[["14", "\""], ["14", "\""]], :cpu_speed=>[["1.70"], ["2.6"]], :resolution=>[["1366", "768"]], :hd_size=>[["500", "gb"], ["24", "gb"], ["500", "gb"], ["24", "gb"]]}

class TestParseNewegg < Test::Unit::TestCase
 
    def test_parse_site()
        url = "http://www.newegg.com/Product/Product.aspx?Item=N82E16834230770"
        specs = parse_newegg_site(url)
        assert(!specs.empty?, "Website should have been parsed, and specs should not be empty.")
        assert_equal("ASUS VivoBook S400CA-DH51T 14\" Touchscreen Ultrabook", specs["Name"], "Name of laptop is incorrect")
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
 
     def test_organizer
        output = organizer_newegg($specs_newegg)
        assert_equal([["1.70"]],output[:cpu_speed])
        assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["500", "gb"], ["24", "gb"], ["500", "gb"], ["24", "gb"]],output[:hd_size])
        assert_equal([["4", "gb"], ["4", "gb"], ["4", "gb"]],output[:ram_size])
        assert_equal([["14", "\""], ["14", "\""]],output[:screen_size])
    end

end