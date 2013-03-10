require File.join(File.dirname(__FILE__), "../obj_io/obj_io")

def new_regex
    $regex = {}
    add_regex(:cpu_speed, "(\\d+\\.\\d*)\\s*ghz")
    add_detail(:cpu_speed, :newegg, "CPU Type", "CPU Speed", "CPU Support")
    add_detail(:cpu_speed, :rakuten, "Processor Speed")
    add_detail(:cpu_speed, :newegg, "Processor Type:", "Processor Speed:")

    add_regex(:resolution, "(\\d+)\\s*x\\s*(\\d+)")
    add_detail(:resolution, :newegg,  "Resolution")
    add_detail(:resolution, :rakuten, "Screen Resolution")
    add_detail(:resolution, :newegg, "Resolution:")

    add_regex(:hd_size, "(\\d+)\\s*(gb|tb)")
    add_detail(:hd_size, :newegg, "Hard Disk", "HDD")
    add_detail(:hd_size, :rakuten, "Hard Drive Capacity", "Solid State Drive Capacity")
    add_detail(:hd_size, :newegg, "Hard Drive Size:")

    add_regex(:memory_size, "(\\d+)\\s*gb")
    add_detail(:memory_size, :newegg, "Memory Size", "Memory")
    add_detail(:memory_size, :rakuten, "Standard Memory")
    add_detail(:memory_size, :newegg, "Maximum Memory Expansion:", "System Ram:")

    add_regex(:screen_size, "(\\d+\\.?\\d*)\\s*(\"|inch)")
    add_detail(:screen_size, :newegg, "Screen Size", "Screen")
    add_detail(:screen_size, :rakuten, "Screen Size")
    add_detail(:screen_size, :newegg, "Laptop Screen Size:")

    save_regex
    return $regex
end

def load_regex
    $regex = load_obj("regex_details")
end

def save_regex
   save_obj("regex_details", $regex) 
end

def add_detail(detail, store, *name)
    return if !$regex.include?(detail)
    if $regex[detail].include?(store)
        $regex[detail][store] += name
    else
        $regex[detail][store] = name
    end
    $regex[detail][store].uniq!
end

def add_regex(detail, regex)
    if $regex.include?(detail)
        $regex[detail][:regex] = regex
    else    
        $regex[detail] = {:regex => regex}
    end
end

p new_regex
