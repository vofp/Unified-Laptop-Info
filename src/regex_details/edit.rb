require File.join(File.dirname(__FILE__), "../obj_io/obj_io")

def new_regex
    $regex = {}
    save_regex
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


