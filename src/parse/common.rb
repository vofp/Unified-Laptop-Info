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
    details_parsed = []
    $regex.each{ |detail, array|
        detail_specs = []
        next if !$regex[detail].include?(store)
        $regex[detail][store].each{ |string|
            details_parsed << string
            next if !specs.include?(string)
            detail_specs << specs[string]
        }
        output[detail] = parse_detail(detail,
            *detail_specs
        )
    }
    details_unparsed = specs.keys - details_parsed
    details_unparsed.each{ |key|
        output[key.to_sym] = specs[key]
    }
    return output
end