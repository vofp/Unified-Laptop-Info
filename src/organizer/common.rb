def parse_detail(detail_name, *array)
    regex = {
        :cpu_speed => "(\\d+\\.\\d*)\\s*ghz",
        :resolution => "(\\d+)\\s*x\\s*(\\d+)",
        :hd_size => "(\\d+)\\s*(gb|tb)",
        :memory_size => "(\\d+)\\s*gb",
        :screen_size => "(\\d+\\.?\\d*)\""
        }
    output = []
    for string in array
        output << parse_data(string, regex[detail_name])
    end
    return output 
end

def parse_data(string, regex)
   r = Regexp.new(regex, Regexp::IGNORECASE)
    if match = r.match(string.downcase)
        return match.captures
    end
    return [] 
end