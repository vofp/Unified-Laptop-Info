def parse_detail(detail_name, *array)

    output = []
    for string in array
        next if string.nil?
        output << parse_data(string.downcase, $regex[detail_name][:regex])
    end
    return output.flatten(1)
end

def parse_data(string, regex)
    r = Regexp.new(regex, Regexp::IGNORECASE)
    return [] if string.nil?
    return string.scan(r) 

end


def organize_details(store, specs)
    output = {}
    $regex.each{ |detail, array|
        detail_specs = []
        
        $regex[detail][store].each{ |string|
            detail_specs << specs[string]
        }
        output[detail] = parse_detail(detail,
            *detail_specs
        )   
    }
    return output
end