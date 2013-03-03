file = File.open('LaptopDetails.csv', 'r')

specs = {}

first = true
topline = []

file.each do |line|
	line = line.chomp.split(',')
	if first then
		first = false
		topline = line
	else
		if !specs.has_key?(line[0]) then
			specs[line[0]] = {}
		end
		if !specs[line[0]].has_key?(line[1]) then
			specs[line[0]][line[1]] = {}
		end
		for i in 2...(line.size) do
			if line[i] != "" then
				if !specs[line[0]][line[1]].has_key?(topline[i]) then
					specs[line[0]][line[1]][topline[i]] = {}
				end
				specs[line[0]][line[1]][topline[i]][line[i]] = ""
			end	
		end
	end
end

specs.each do |type, nameSet|
	puts type
	nameSet.each do |name, storeSet|
		puts "   #{name}"
		storeSet.each do |store, detailSet|
			puts "      #{store}"
			detailSet.each do |detail, data| 
				puts "         #{detail}"
			end
		end
	end

end

