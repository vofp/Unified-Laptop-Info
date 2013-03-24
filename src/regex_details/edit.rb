require File.join(File.dirname(__FILE__), "../obj_io/obj_io")
$regex_file = File.join(File.dirname(__FILE__), 'regex_details')
def new_regex
  $regex = {}
  add_regex(:cpu_speed, "(\\d+\\.\\d*)\\s*ghz")
  add_detail(:cpu_speed, :newegg, "CPU Type", "CPU Speed", "CPU Support")
  add_detail(:cpu_speed, :rakuten, "Processor Speed")
  add_detail(:cpu_speed, :walmart, "Processor Type:", "Processor Speed:")
  add_detail(:cpu_speed, :any, "cpu_speed")

  add_regex(:resolution, "(\\d+)\\s*x\\s*(\\d+)")
  add_detail(:resolution, :newegg,  "Resolution")
  add_detail(:resolution, :rakuten, "Screen Resolution")
  add_detail(:resolution, :walmart, "Resolution:")
  add_detail(:resolution, :any, "Resolution")

  add_regex(:hd_size, "(\\d+)\\s*(gb|tb)")
  add_detail(:hd_size, :newegg, "Hard Disk", "HDD")
  add_detail(:hd_size, :rakuten, "Hard Drive Capacity", "Solid State Drive Capacity")
  add_detail(:hd_size, :walmart, "Hard Drive Size:")
  add_detail(:hd_size, :any, "Hard Disk")

  add_regex(:memory_size, "(\\d+)\\s*gb")
  add_detail(:memory_size, :newegg, "Memory Size", "Memory")
  add_detail(:memory_size, :rakuten, "Standard Memory")
  add_detail(:memory_size, :walmart, "Maximum Memory Expansion:", "System Ram:")
  add_detail(:memory_size, :any, "Memory Size")

  add_regex(:screen_size, "(\\d+\\.?\\d*)\\s*(\"|inch)")
  add_detail(:screen_size, :newegg, "Screen Size", "Screen")
  add_detail(:screen_size, :rakuten, "Screen Size")
  add_detail(:screen_size, :walmart, "Laptop Screen Size:")
  add_detail(:screen_size, :any, "Screen Size")

  save_regex
  return $regex
end

def new_regex_csv(filename_regex,filename_detail)
  $regex = {}
  filename_regex = File.join(File.dirname(__FILE__), filename_regex)
  file = File.open(filename_regex, 'r')
  file.each do |line|
    line = line.chomp.split(',')
    add_regex(line[0].strip.to_sym, line[1], line[2])
  end

  filename_detail = File.join(File.dirname(__FILE__), filename_detail)
  file = File.open(filename_detail, 'r')
  file.each do |line|
    line = line.chomp.split(',')
    add_detail(line[0].strip.to_sym, line[1].strip.to_sym, line[2])
  end
  save_regex
  return $regex
end

def load_regex
  $regex = load_obj($regex_file)
end

def save_regex
   save_obj($regex_file, $regex) 
end

def add_detail(detail, store, *name)
  if !$regex.include?(detail)
    $regex[detail] = {:regex => ".*"}
  end
  if $regex[detail].include?(store)
    $regex[detail][store] += name
  else
    $regex[detail][store] = name
  end
  $regex[detail][store].uniq!
end

def add_regex(detail, regex, format="%s")
  if $regex.include?(detail)
    $regex[detail][:regex] = regex
    $regex[detail][:format] = format
  else    
    $regex[detail] = {:regex => regex, :format => format}
  end
end

p new_regex_csv("add_regex.csv", "add_detail.csv")
