require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
require File.join(File.dirname(__FILE__), 'common')


def organizer_newegg(specs)
    dataDictionary = {
        :cpu_speed => [
            "CPU Type",
            "CPU Speed",
            "CPU Support"],
        :resolution => [
            "Resolution"],
        :hd_size => [
            "Hard Disk", 
            "HDD"],
        :memory_size => [
            "Memory Size", 
            "Memory"],
        :screen_size => [
            "Screen Size", 
            "Screen"]
    }
    return organize_details(dataDictionary,specs)
end

def parse_newegg_site(url)
    doc = Nokogiri::HTML(open(url))

    specs = {}

    doc.css(".price-main-product").first

    specs["Name"] = doc.css(".wrapper span").first.text.strip

    doc.css("#Specs dl").each do |item|
        begin
            key = item.at_css("dt").text
            data = item.at_css("dd").text
            specs[key] = data
        rescue NoMethodError
            next
        end
    end

    return specs
rescue OpenURI::HTTPError => e
    raise e
end

# {"Card Reader"=>"SD only", "Max Memory Supported"=>"4GB", "HDD"=>"500GB HDD + 24GB SSD", "Graphic Type"=>"Integrated Card", "Screen Size"=>"14\"", "Weight"=>"4 lbs.", "Communication"=>"Gigabit LAN and WLAN", "Graphics Card"=>"Intel HD Graphics 4000", "Hard Disk"=>"500GB HDD+24GB SSD", "Memory Size"=>"4GB DDR3", "Color"=>"Gray", "Brand"=>"ASUS", "Audio Ports"=>"1 x Headphone-out & Audio-in Combo Jack", "CPU Type"=>"Intel Core i5", "Audio"=>"Built-in microphoneSonic Master", "LAN"=>"10/100/1000Mbps", "HDD RPM"=>"5400rpm", "Dimensions"=>"13.3\" x 9.4\" x 0.7\"-0.8\"", "AC Adapter"=>"65-watt AC adapter", "Usage"=>"Consumer", "Webcam"=>"0.3 Mega Pixel web camera (Fixed type)", "Speaker"=>"Integrated Stereo Speakers", "Video Port"=>"1 x VGA", "Video Memory"=>"Shared system memory", "Name"=>"ASUS VivoBook S400CA-DH51T Touchscreen Ultrabook", "Battery"=>"44WHrs, 4000mAh,3S1P, 3-cell Li-ion Battery pack", "Keyboard"=>"Chiclet Keyboard", "GPU/VPU"=>"Intel HD Graphics 4000", "LCD Features"=>"16:9 Display type: (Typical 220-nit) 16ms response timeNTSC:45%", "Series"=>"VivoBook", "USB"=>"2 x USB 2.01 x USB 3.0", "Memory"=>"4GB", "Style"=>"Ultrabook", "WLAN"=>"802.11b/g/n Wireless LAN", "Memory Spec"=>"4GB On Board", "Wide Screen Support"=>"Yes", "Accidental Damage Warranty"=>"1 Year Accidental Damage/30-Day Zero Bright Dot", "Type"=>"Mainstream", "CPU Support"=>"3MB L3 CacheMax Turbo Frequency 2.6 GHz", "CPU Speed"=>"3317U(1.70GHz)", "Operating System"=>"Windows 8 64-Bit", "Resolution"=>"1366 x 768", "Touchscreen"=>"Yes", "Screen"=>"14\"", "HDMI"=>"1 x HDMI", "Model"=>"S400CA-DH51T"}
