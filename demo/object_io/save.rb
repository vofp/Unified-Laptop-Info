regex = {:hello => "bye"}
File.open('regex_details','w') do|file|
    Marshal.dump(regex, file)
end