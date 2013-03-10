
$details = [:cpu_speed,:resolution,:hd_size,:memory_size,:screen_size]

def new_complete_spec
    c_spec = {}
    for detail in $details
        c_spec[detail] = {}
    end
    return c_spec
end

def combine_cpu_speed(c_spec, spec, any = false)
    detail = :cpu_speed
    h = spec[detail]
    h = h.uniq if any
    for data in h
        next if data.empty?
        number = '%.2f' % data[0]
        display_detail = number + "GHz"
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            if !any
                c_spec[detail][display_detail] = {
                    :count => 1, 
                    :votes => 0,
                    :data => data,
                    :sort => number.to_f
                }
            end
        end
    end
end

def combine_resolution(c_spec, spec, any = false)
    detail = :resolution
    h = spec[detail]
    h = h.uniq if any
    for data in h
        next if data.empty?
        display_detail = data[0] + " x " + data[1]
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            if !any
                c_spec[detail][display_detail] = {
                    :count => 1, 
                    :votes => 0,
                    :data => data,
                    :sort => data[0].to_i
                }
            end
        end
    end
end

def combine_hd_size(c_spec, spec, any = false)
    detail = :hd_size
    h = spec[detail]
    h = h.uniq if any
    for data in h
        next if data.empty?
        display_detail = data[0]+data[1].upcase
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            if !any
                c_spec[detail][display_detail] = {
                    :count => 1, 
                    :votes => 0,
                    :data => data,
                    :sort => data[0].to_i
                }
            end
        end
    end
end

def combine_memory_size(c_spec, spec, any = false)
    detail = :memory_size
    h = spec[detail]
    h = h.uniq if any
    for data in h
        next if data.empty?
        display_detail = data[0]+"GB"
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            if !any
                c_spec[detail][display_detail] = {
                    :count => 1, 
                    :votes => 0,
                    :data => data,
                    :sort => data[0].to_i
                }
            end
        end
    end
end

def combine_screen_size(c_spec, spec, any = false)
    detail = :screen_size
    h = spec[detail]
    h = h.uniq if any
    for data in h
        next if data.empty?
        number = '%.1f' % data[0]
        display_detail = number+"\""
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            if !any
                c_spec[detail][display_detail] = {
                    :count => 1, 
                    :votes => 0,
                    :data => data,
                    :sort => number.to_f
                }
            end
        end
    end
end

def combine(c_spec = new_complete_spec, *specs)
    for spec in specs
        combine_cpu_speed(c_spec, spec)
        combine_resolution(c_spec, spec)
        combine_hd_size(c_spec, spec)
        combine_memory_size(c_spec, spec)
        combine_screen_size(c_spec, spec)
    
    end
    return c_spec
end

def combine_any(c_spec, *specs)
    for spec in specs
        combine_cpu_speed(c_spec, spec, true)
        combine_resolution(c_spec, spec, true)
        combine_hd_size(c_spec, spec, true)
        combine_memory_size(c_spec, spec, true)
        combine_screen_size(c_spec, spec, true)
    end
    return c_spec
end