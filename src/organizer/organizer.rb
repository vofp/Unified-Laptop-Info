
$details = [:cpu_speed,:resolution,:hd_size,:memory_size,:screen_size]

def new_complete_spec
    c_spec = {}
    for detail in $details
        c_spec[detail] = {}
    end
    return c_spec
end

def combine_cpu_speed(c_spec, spec)
    detail = :cpu_speed
    for data in spec[detail]
        next if data.empty?
        number = '%.2f' % data[0]
        display_detail = number + "GHz"
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            c_spec[detail][display_detail] = {
                :count => 1, 
                :votes => 0,
                :data => data,
                :sort => number.to_f
            }
        end
    end
end

def combine_resolution(c_spec, spec)
    detail = :resolution
    for data in spec[detail]
        next if data.empty?
        display_detail = data[0] + " x " + data[1]
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            c_spec[detail][display_detail] = {
                :count => 1, 
                :votes => 0,
                :data => data,
                :sort => data[0].to_i
            }
        end
    end
end

def combine_hd_size(c_spec, spec)
    detail = :hd_size
    for data in spec[detail]
        next if data.empty?
        display_detail = data[0]+data[1]
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            c_spec[detail][display_detail] = {
                :count => 1, 
                :votes => 0,
                :data => data,
                :sort => data[0].to_i
            }
        end
    end
end

def combine_memory_size(c_spec, spec)
    detail = :memory_size
    for data in spec[detail]
        next if data.empty?
        display_detail = data[0]+"GB"
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            c_spec[detail][display_detail] = {
                :count => 1, 
                :votes => 0,
                :data => data,
                :sort => data[0].to_i
            }
        end
    end
end

def combine_screen_size(c_spec, spec)
    detail = :screen_size
    for data in spec[detail]
        next if data.empty?
        number = '%.1f' % data[0]
        display_detail = number+"\""
        if c_spec[detail].include?(display_detail)
            c_spec[detail][display_detail][:count] += 1;
        else
            c_spec[detail][display_detail] = {
                :count => 1, 
                :votes => 0,
                :data => data,
                :sort => number.to_f
            }
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