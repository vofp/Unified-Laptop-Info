require "../src/organizer/newegg"
require "../src/organizer/organizer"
require "test/unit"

$specs = {"Card Reader"=>"SD only", "Max Memory Supported"=>"4GB", "HDD"=>"500GB HDD + 24GB SSD", "Graphic Type"=>"Integrated Card", "Screen Size"=>"14\"", "Weight"=>"4 lbs.", "Communication"=>"Gigabit LAN and WLAN", "Graphics Card"=>"Intel HD Graphics 4000", "Hard Disk"=>"500GB HDD+24GB SSD", "Memory Size"=>"4GB DDR3", "Color"=>"Gray", "Brand"=>"ASUS", "Audio Ports"=>"1 x Headphone-out & Audio-in Combo Jack", "CPU Type"=>"Intel Core i5", "Audio"=>"Built-in microphoneSonic Master", "LAN"=>"10/100/1000Mbps", "HDD RPM"=>"5400rpm", "Dimensions"=>"13.3\" x 9.4\" x 0.7\"-0.8\"", "AC Adapter"=>"65-watt AC adapter", "Usage"=>"Consumer", "Webcam"=>"0.3 Mega Pixel web camera (Fixed type)", "Speaker"=>"Integrated Stereo Speakers", "Video Port"=>"1 x VGA", "Video Memory"=>"Shared system memory", "Name"=>"ASUS VivoBook S400CA-DH51T Touchscreen Ultrabook", "Battery"=>"44WHrs, 4000mAh,3S1P, 3-cell Li-ion Battery pack", "Keyboard"=>"Chiclet Keyboard", "GPU/VPU"=>"Intel HD Graphics 4000", "LCD Features"=>"16:9 Display type: (Typical 220-nit) 16ms response timeNTSC:45%", "Series"=>"VivoBook", "USB"=>"2 x USB 2.01 x USB 3.0", "Memory"=>"4GB", "Style"=>"Ultrabook", "WLAN"=>"802.11b/g/n Wireless LAN", "Memory Spec"=>"4GB On Board", "Wide Screen Support"=>"Yes", "Accidental Damage Warranty"=>"1 Year Accidental Damage/30-Day Zero Bright Dot", "Type"=>"Mainstream", "CPU Support"=>"3MB L3 CacheMax Turbo Frequency 2.6 GHz", "CPU Speed"=>"3317U(1.70GHz)", "Operating System"=>"Windows 8 64-Bit", "Resolution"=>"1366 x 768", "Touchscreen"=>"Yes", "Screen"=>"14\"", "HDMI"=>"1 x HDMI", "Model"=>"S400CA-DH51T"}
$o_specs = {
    :cpu_speed=>[[], ["1.70"], ["2.6"]], 
    :resolution=>[["1366", "768"]], 
    :hd_size=>[["500", "gb"], ["500", "gb"]], 
    :memory_size=>[["4"], ["4"]], 
    :screen_size=>[["14"], ["14"]]}


class TestOrganizer < Test::Unit::TestCase
    def test_newegg
        output = organizer_newegg($specs)
        assert_equal([[], ["1.70"], ["2.6"]],output[:cpu_speed])
        assert_equal([["1366", "768"]],output[:resolution])
        assert_equal([["500", "gb"], ["500", "gb"]],output[:hd_size])
        assert_equal([["4"], ["4"]],output[:memory_size])
        assert_equal([["14"], ["14"]],output[:screen_size])
        assert_equal($o_specs,output)
    end
    def test_combine
        c_spec = new_complete_spec
        p output = combine(c_spec, $o_specs)
        assert_equal({"1.70GHz"=>{:count=>1, :votes=>0, :data=>["1.70"], :sort=>1.7}, "2.6GHz"=>{:count=>1, :votes=>0, :data=>["2.6"], :sort=>2.6}}, output[:cpu_speed])
        assert_equal({"1366 x 768"=>{:count=>1, :votes=>0, :data=>["1366", "768"], :sort=>1366}}, output[:resolution])
        assert_equal({"500gb"=>{:count=>2, :votes=>0, :data=>["500", "gb"], :sort=>500}},output[:hd_size]) 
        assert_equal({"4GB"=>{:count=>2, :votes=>0, :data=>["4"], :sort=>4}},output[:memory_size])
        assert_equal({"14\""=>{:count=>2, :votes=>0, :data=>["14"], :sort=>14}}, output[:screen_size])
        assert_equal({:cpu_speed=>{"1.70GHz"=>{:count=>1, :votes=>0, :data=>["1.70"], :sort=>1.7}, "2.6GHz"=>{:count=>1, :votes=>0, :data=>["2.6"], :sort=>2.6}}, :resolution=>{"1366 x 768"=>{:count=>1, :votes=>0, :data=>["1366", "768"], :sort=>1366}}, :hd_size=>{"500gb"=>{:count=>2, :votes=>0, :data=>["500", "gb"], :sort=>500}}, :memory_size=>{"4GB"=>{:count=>2, :votes=>0, :data=>["4"], :sort=>4}}, :screen_size=>{"14\""=>{:count=>2, :votes=>0, :data=>["14"], :sort=>14}}}, output)
    end
end
