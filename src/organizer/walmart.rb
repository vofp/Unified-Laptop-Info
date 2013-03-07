require File.join(File.dirname(__FILE__), 'common')
# {"Processor Brand:"=>"Intel", "Walmart No.:"=>"551072641", "Operating System:"=>"Windows 8 64-bit", "Resolution:"=>"1366 x 768", "Screen Type:"=>"LED Backlight, HD Touchscreen Display", "Hard Drive Size:"=>"24 GB", "Accessories Included:"=>"Power Cord,Battery", "Network Connection:"=>"10/100/1000 Gigabit Ethernet & 802.11b/g/n Wireless LAN", "Name"=>"Asus Grey 14.1\" S400CA-DH51T Ultrabook PC with Intel Core i5-3317U Processor and Windows 8 Operating System", "Maximum Memory Expansion:"=>"4 GB", "Platform:"=>"PC", "Graphics Card:"=>"Intel HD Graphics 4000", "Primary Color:"=>"Gray", "Model No.:"=>"Asus S400CA-DH51T", "Connector Type:"=>"1 x DC-in, 1 x Ethernet, 1 x HDMI, 1 x Headphone/Microphone, 2 x USB 2.0, 1 x USB 2.0/3.0, 1 x VGA", "Price"=>"$699.", "Product in Inches (L x W x H):"=>"13.3\302\240x\302\2409.4\302\240x\302\2400.8", "System Ram:"=>"4 GB", "Battery Type:"=>"Lithium Ion", "Laptop Screen Size:"=>"14.0 inch", "Processor Type:"=>"Intel Core i5-3317U Processor", "Processor Speed:"=>"1.70 GHz, with a Max Turbo Speed of 2.60 GHz", "Shipping Weight (in pounds):"=>"6.0", "Card Reader Type:"=>"1 x SD Card Reader"}

$dataDictionary = {
    :cpu_speed => [
        "Processor Type:",
        "Processor Speed:"],
    :resolution => [
        "Resolution:"],
    :hd_size => [
        "Hard Drive Size:"],
    :memory_size => [
        "Maximum Memory Expansion:",
        "System Ram:"],
    :screen_size => [
        "Laptop Screen Size:"]
}

def organizer_walmart(specs)
    return organize_details($dataDictionary,specs)
end