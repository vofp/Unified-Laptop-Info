def parse_detail(detail_name, *array)
    regex = {
        :cpu_speed => "(\\d+\\.\\d*)\\s*ghz",
        :resolution => "(\\d+)\\s*x\\s*(\\d+)",
        :hd_size => "(\\d+)\\s*(gb|tb)",
        :memory_size => "(\\d+)\\s*gb",
        :screen_size => "(\\d+\\.?\\d*)\\s*(\"|inch)"
        }
    output = []
    for string in array
        next if string.nil?
        output << parse_data(string.downcase, regex[detail_name])
    end
    return output.flatten(1)
end

def parse_data(string, regex)
    r = Regexp.new(regex, Regexp::IGNORECASE)
    return [] if string.nil?
    return string.scan(r) 

end


def organize_details(dataDictionary, specs)
    output = {}
    dataDictionary.each{ |detail, array|
        detail_specs = []
        array.each{ |string|
            detail_specs << specs[string]
        }
        output[detail] = parse_detail(detail,
            *detail_specs
        )   
    }
    return output
end