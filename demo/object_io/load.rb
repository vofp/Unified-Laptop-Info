regex = nil
File.open('regex_details','r') do|file|
    regex = Marshal.load(file)
end
p regex