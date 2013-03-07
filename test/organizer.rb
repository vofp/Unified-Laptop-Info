require File.join(File.dirname(__FILE__), "../src/organizer/newegg")
require File.join(File.dirname(__FILE__), "../src/organizer/walmart")
require File.join(File.dirname(__FILE__), "../src/organizer/organizer")
require "test/unit"

$specs_newegg = {"Card Reader"=>"SD only", "Max Memory Supported"=>"4GB", "HDD"=>"500GB HDD + 24GB SSD", "Graphic Type"=>"Integrated Card", "Screen Size"=>"14\"", "Weight"=>"4 lbs.", "Communication"=>"Gigabit LAN and WLAN", "Graphics Card"=>"Intel HD Graphics 4000", "Hard Disk"=>"500GB HDD+24GB SSD", "Memory Size"=>"4GB DDR3", "Color"=>"Gray", "Brand"=>"ASUS", "Audio Ports"=>"1 x Headphone-out & Audio-in Combo Jack", "CPU Type"=>"Intel Core i5", "Audio"=>"Built-in microphoneSonic Master", "LAN"=>"10/100/1000Mbps", "HDD RPM"=>"5400rpm", "Dimensions"=>"13.3\" x 9.4\" x 0.7\"-0.8\"", "AC Adapter"=>"65-watt AC adapter", "Usage"=>"Consumer", "Webcam"=>"0.3 Mega Pixel web camera (Fixed type)", "Speaker"=>"Integrated Stereo Speakers", "Video Port"=>"1 x VGA", "Video Memory"=>"Shared system memory", "Name"=>"ASUS VivoBook S400CA-DH51T Touchscreen Ultrabook", "Battery"=>"44WHrs, 4000mAh,3S1P, 3-cell Li-ion Battery pack", "Keyboard"=>"Chiclet Keyboard", "GPU/VPU"=>"Intel HD Graphics 4000", "LCD Features"=>"16:9 Display type: (Typical 220-nit) 16ms response timeNTSC:45%", "Series"=>"VivoBook", "USB"=>"2 x USB 2.01 x USB 3.0", "Memory"=>"4GB", "Style"=>"Ultrabook", "WLAN"=>"802.11b/g/n Wireless LAN", "Memory Spec"=>"4GB On Board", "Wide Screen Support"=>"Yes", "Accidental Damage Warranty"=>"1 Year Accidental Damage/30-Day Zero Bright Dot", "Type"=>"Mainstream", "CPU Support"=>"3MB L3 CacheMax Turbo Frequency 2.6 GHz", "CPU Speed"=>"3317U(1.70GHz)", "Operating System"=>"Windows 8 64-Bit", "Resolution"=>"1366 x 768", "Touchscreen"=>"Yes", "Screen"=>"14\"", "HDMI"=>"1 x HDMI", "Model"=>"S400CA-DH51T"}
$specs_walmart = {"Processor Brand:"=>"Intel", "Walmart No.:"=>"551072641", "Operating System:"=>"Windows 8 64-bit", "Resolution:"=>"1366 x 768", "Screen Type:"=>"LED Backlight, HD Touchscreen Display", "Hard Drive Size:"=>"24 GB", "Accessories Included:"=>"Power Cord,Battery", "Network Connection:"=>"10/100/1000 Gigabit Ethernet & 802.11b/g/n Wireless LAN", "Name"=>"Asus Grey 14.1\" S400CA-DH51T Ultrabook PC with Intel Core i5-3317U Processor and Windows 8 Operating System", "Maximum Memory Expansion:"=>"4 GB", "Platform:"=>"PC", "Graphics Card:"=>"Intel HD Graphics 4000", "Primary Color:"=>"Gray", "Model No.:"=>"Asus S400CA-DH51T", "Connector Type:"=>"1 x DC-in, 1 x Ethernet, 1 x HDMI, 1 x Headphone/Microphone, 2 x USB 2.0, 1 x USB 2.0/3.0, 1 x VGA", "Price"=>"$699.", "Product in Inches (L x W x H):"=>"13.3\302\240x\302\2409.4\302\240x\302\2400.8", "System Ram:"=>"4 GB", "Battery Type:"=>"Lithium Ion", "Laptop Screen Size:"=>"14.0 inch", "Processor Type:"=>"Intel Core i5-3317U Processor", "Processor Speed:"=>"1.70 GHz, with a Max Turbo Speed of 2.60 GHz", "Shipping Weight (in pounds):"=>"6.0", "Card Reader Type:"=>"1 x SD Card Reader"}

$o_specs_newegg = {:memory_size=>[["4"], ["4"]], :screen_size=>[["14", "\""], ["14", "\""]], :cpu_speed=>[["1.70"], ["2.6"]], :resolution=>[["1366", "768"]], :hd_size=>[["500", "gb"], ["24", "gb"], ["500", "gb"], ["24", "gb"]]}
$o_specs_walmart = {:memory_size=>[["4"], ["4"]], :screen_size=>[["14.0", "inch"]], :cpu_speed=>[["1.70"], ["2.60"]], :resolution=>[["1366", "768"]], :hd_size=>[["24", "gb"]]}

$o_c_spec = {
    :hd_size=>{
        "24GB"=>{:count=>3, :votes=>0, :sort=>24, :data=>["24", "gb"]}, 
        "500GB"=>{:count=>2, :votes=>0, :sort=>500, :data=>["500", "gb"]}}, 
    :memory_size=>{
        "4GB"=>{:count=>4, :votes=>0, :sort=>4, :data=>["4"]}}, 
    :screen_size=>{
        "14.0\""=>{:count=>3, :votes=>0, :sort=>14.0, :data=>["14", "\""]}}, 
    :cpu_speed=>{
        "1.70GHz"=>{:count=>2, :votes=>0, :sort=>1.7, :data=>["1.70"]}, 
        "2.60GHz"=>{:count=>2, :votes=>0, :sort=>2.6, :data=>["2.6"]}}, 
    :resolution=>{
        "1366 x 768"=>{:count=>2, :votes=>0, :sort=>1366, :data=>["1366", "768"]}}
}




class TestOrganizer < Test::Unit::TestCase
    def test_newegg
        output = organizer_newegg($specs_newegg)
        assert_equal([["1.70"], ["2.6"]],output[:cpu_speed])
        assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["500", "gb"], ["24", "gb"], ["500", "gb"], ["24", "gb"]],output[:hd_size])
        assert_equal([["4"], ["4"]],output[:memory_size])
        assert_equal([["14", "\""], ["14", "\""]],output[:screen_size])
    end
    def test_walmart
        output = organizer_walmart($specs_walmart)
        assert_equal([["1.70"], ["2.60"]],output[:cpu_speed])
        assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["24", "gb"]],output[:hd_size])
        assert_equal([["4"], ["4"]],output[:memory_size])
        assert_equal([["14.0", "inch"]],output[:screen_size])
    end
    def test_combine
        c_spec = new_complete_spec
        output = combine(c_spec, $o_specs_newegg, $o_specs_walmart)
        assert_equal($o_c_spec, output)
    end
end
