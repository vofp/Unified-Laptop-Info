require File.join(File.dirname(__FILE__), 'common')

def organizer_newegg(specs)
    output = {}
    output[:cpu_speed] = parse_detail(:cpu_speed,
        specs["CPU Type"],
        specs["CPU Speed"],
        specs["CPU Support"]
        )
    output[:resolution] = parse_detail(:resolution,
        specs["Resolution"]
        )
    output[:hd_size] = parse_detail(:hd_size,
        specs["Hard Disk"], 
        specs["HDD"]
        )
    output[:memory_size] = parse_detail(:memory_size,
        specs["Memory Size"], 
        specs["Memory"]
        )
    output[:screen_size] = parse_detail(:screen_size,
        specs["Screen Size"], 
        specs["Screen"]
        )
    
    return output
end