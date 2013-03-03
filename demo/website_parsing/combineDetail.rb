require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
 
url = "http://www.amazon.com/VivoBook-S400CA-DH51T-14-1-Inch-Touch-Ultrabook/dp/B009F1JL5A"
amazon_doc = Nokogiri::HTML(open(url))
amazon_specs = {}

amazon_specs["Name"] = amazon_doc.css("#btAsinTitle").first.text.strip
amazon_specs["Price"] = amazon_doc.css(".priceLarge").first.text.strip

amazon_doc.css("#prodDetails tr").each do |item|
	begin
		key = item.at_css(".label").text.strip
		data = item.at_css(".value").text.strip
		amazon_specs[key] = data
	rescue Exception
			
	end
end



url = "http://www.newegg.com/Product/Product.aspx?Item=N82E16834230770"
newegg_doc = Nokogiri::HTML(open(url))

newegg_specs = {}

newegg_doc.css(".price-main-product").first

newegg_specs["Name"] = newegg_doc.css(".wrapper span").first.text.strip

newegg_doc.css("#Specs dl").each do |item|
	key = item.at_css("dt").text
	data = item.at_css("dd").text
	newegg_specs[key] = data
end


url = "http://www.overstock.com/Electronics/Asus-S400CA-DH51T-14.1-LED-Ultrabook-Intel-Core-i5-i5-3317U-1.70-G/7458742/product.html?cid=123620"
overstock_doc = Nokogiri::HTML(open(url))

overstock_specs = {}

overstock_specs["Name"] = overstock_doc.css("h1").first.text.strip
overstock_specs["Price"] = overstock_doc.css(".Ovalue").first.text.strip

overstock_doc.css("#details_descFull li").each do |item|
	begin
		details = item.text.strip.split(":",2)
		details.map!{|x| 
			x.strip
		}
		key, data = details

		#key = item.at_css(".label").text.strip
		#data = item.at_css(".value").text.strip
		overstock_specs[key] = data
	rescue Exception
			
	end
end

url = "http://www.buy.com/prod/asus-vivobook-s400ca-dh51t-14-1-led-ultrabook-intel-core-i5-i5-3317u-1/242783117.html?listingId=250509702"
buy_doc = Nokogiri::HTML(open(url))

buy_specs = {}

buy_specs["Name"] = buy_doc.css(".pr-hidden-title").first.text.strip
# buy_specs["Price"] = buy_doc.css("#spanMainTotalPrice").first.text.strip

buy_doc.css("#featuresAndSpecs tr").each do |item|
	begin
		key = item.at_css("td:nth-child(2)").text.strip
		data = item.at_css("td:nth-child(3)").text.strip
		buy_specs[key] = data
	rescue Exception
			
	end
end


url = "http://www.walmart.com/ip/Asus-Grey-14.1-S400CA-DH51T-Ultrabook-PC-with-Intel-Core-i5-3317U-Processor-and-Windows-8-Operating-System/22306737?ci_src=14110944&ci_sku=22306737&sourceid=1500000000000003142050"
walmart_doc = Nokogiri::HTML(open(url))

walmart_specs = {}

walmart_specs["Name"] = walmart_doc.css(".productTitle").first.text.strip
walmart_specs["Price"] = walmart_doc.css(".bigPriceText1").first.text.strip

walmart_doc.css(".SpecTable tr").each do |item|
	begin
		key = item.at_css("td:nth-child(1)").text.strip
		data = item.at_css("td:nth-child(2)").text.strip
		walmart_specs[key] = data
	rescue Exception
			
	end
end


file = File.open('LaptopDetails.csv', 'r')

specs = {}

first = true
topline = []

store_specs = [amazon_specs,newegg_specs,overstock_specs, buy_specs,walmart_specs]

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
		specs[line[0]][line[1]]["ParseType"] = line[2]
		
		for i in 3...(line.size) do
			if line[i] != "" then
				if !specs[line[0]][line[1]].has_key?(topline[i]) then
					specs[line[0]][line[1]][topline[i]] = {}
				end
				specs[line[0]][line[1]][topline[i]][line[i]] = store_specs[i-3][line[i]]
			end	
		end
	end
end




#=begin ParseType = [int;word]
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "[float;word]" then
			storeSet["Parse"] = []
			intData = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
						#puts detail
							intData << data.scan(/\d+\.?\d*/)
							data = data.scan(/\D+/)
							data.map! do |word|
								word = word.split
							end
							data.flatten!
							data.map! do |word|
								word = word.downcase
							end
							storeSet["Parse"] << data
						end
					end
				end
			end
			words = storeSet["Parse"].flatten.uniq
			wordCount = {}
			common = []
			storeSet["Parse"].each do |word|
				word.each do |w|
					if !wordCount.has_key?(w) then
						wordCount[w] = 0
					end
					wordCount[w] += 1
				end
			end
			max = wordCount.values.sort.last

			wordCount.each do |word, count|
				common << word if count >= max-1
			end

			storeSet["Parse"] = [intData.uniq, [words,common]]
			print "#{type} #{name}:\t"
			p storeSet["Parse"]
		end
	end
end
#=end



#=begin ParseType = int[2]
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "int[2]" then
			storeSet["Parse"] = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
							data = data.scan(/\d+/)
							storeSet["Parse"] << data
						end
					end
				end
			end
			print "#{type} #{name}:\t"
			storeSet["Parse"].uniq!
			p storeSet["Parse"]
		end
	end
end
#=end

#=begin ParseType = string
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "string" then
			storeSet["Parse"] = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
							storeSet["Parse"] << data
						end
					end
				end
			end
			print "#{type} #{name}:\t"
			storeSet["Parse"].uniq!
			p storeSet["Parse"]
		end
	end
end
#=end

#=begin ParseType = bool
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "bool" then
			storeSet["Parse"] = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
							data = data.scan(/\d+|\D+/)
							data.map! do |word|
								word = word.split
							end
							data.flatten!
							data.map! do |word|
								word = word.downcase
							end
							storeSet["Parse"] << data
						end
					end
				end
			end
			print "#{type} #{name}:\t"
			storeSet["Parse"] = storeSet["Parse"].flatten.include?("yes")
			p storeSet["Parse"]
		end
	end
end
#=end

#=begin ParseType = int
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "int" then
			storeSet["Parse"] = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
							data = data.scan(/\d+/)
							storeSet["Parse"] << data
						end
					end
				end
			end
			print "#{type} #{name}:\t"
			storeSet["Parse"] = storeSet["Parse"][0]
			p storeSet["Parse"]
		end
	end
end
#=end

#=begin ParseType = word
specs.each do |type, nameSet|
	nameSet.each do |name, storeSet|
		if storeSet["ParseType"] == "word" then
			storeSet["Parse"] = []
			storeSet.each do |store, detailSet|
				if !["ParseType","Parse"].include?(store) then
					detailSet.each do |detail, data|
						if !data.nil? then
						#puts detail
							data = data.scan(/\d+|\D+/)
							data.map! do |word|
								word = word.split
							end
							data.flatten!
							data.map! do |word|
								word = word.downcase
							end
							storeSet["Parse"] << data
						end
					end
				end
			end
			words = storeSet["Parse"].flatten.uniq
			wordCount = {}
			common = []
			storeSet["Parse"].each do |word|
				word.each do |w|
					if !wordCount.has_key?(w) then
						wordCount[w] = 0
					end
					wordCount[w] += 1
				end
			end
			max = wordCount.values.sort.last

			wordCount.each do |word, count|
				common << word if count >= max-1
			end

			storeSet["Parse"] = [words,common]
			print "#{type} #{name}:\t"
			p storeSet["Parse"][1]
			#p storeSet["Parse"]

		end
	end
end
#=end

=begin
specs.each do |type, nameSet|
	puts type
	nameSet.each do |name, storeSet|
		puts "   #{name}"
		storeSet.each do |store, detailSet|
			puts "      #{store}"
			if store == "ParseType" then
				puts "         #{detailSet}"
			else
				detailSet.each do |detail, data| 
					puts "         #{detail}: #{data}"
				end
			end
		end
	end
end

parsedSpecs = {}
#parsedSpecs["Physical"] = {}

parsedSpecs["Shipping Weight"] = []
specs["Physical"]["Shipping Weight"].each do |store, detailSet|
	detailSet.each do |detail, data|
		parsedSpecs["Shipping Weight"] << /\d\.\d/.match(data).to_s.to_f
	end
end
p parsedSpecs["Shipping Weight"]


parsedSpecs["Weight"] = []
specs["Physical"]["Weight"].each do |store, detailSet|
	detailSet.each do |detail, data|
		parsedSpecs["Weight"] << /\d\.*\d*/.match(data).to_s.to_f
	end
end
p parsedSpecs["Weight"]


parsedSpecs["GraphicsCard"] = []
specs["Graphics"]["Card"].each do |store, detailSet|
	if store != "ParseType" then
		detailSet.each do |detail, data|
			data = data.split
			data.map! do |word|
				word = word.downcase
			end
			parsedSpecs["GraphicsCard"] << data
		end
	end
end
words = parsedSpecs["GraphicsCard"].flatten.uniq
wordCount = {}
common = []
parsedSpecs["GraphicsCard"].each do |word|
	word.each do |w|
		if !wordCount.has_key?(w) then
			wordCount[w] = 0
		end
		wordCount[w] += 1
	end
end
max = wordCount.values.sort.last

wordCount.each do |word, count|
	common << word if count >= max-1
end

parsedSpecs["GraphicsCard"] = [words,common]
p parsedSpecs["GraphicsCard"]



parsedSpecs["Wireless"] = []
specs["Communications"]["Wireless"].each do |store, detailSet|
	if store != "ParseType" then
		detailSet.each do |detail, data|
			data = data.split
			data.map! do |word|
				word = word.downcase
			end
			parsedSpecs["Wireless"] << data
		end
	end
end
words = parsedSpecs["Wireless"].flatten.uniq
wordCount = {}
common = []
parsedSpecs["Wireless"].each do |word|
	word.each do |w|
		if !wordCount.has_key?(w) then
			wordCount[w] = 0
		end
		wordCount[w] += 1
	end
end
max = wordCount.values.sort.last

wordCount.each do |word, count|
	common << word if count >= max-1
end

parsedSpecs["Wireless"] = [words,common]
p parsedSpecs["Wireless"]



parsedSpecs["CPUType"] = []
specs["CPU"]["Type"].each do |store, detailSet|
	if store != "ParseType" then
		detailSet.each do |detail, data|
			data = data.split
			data.map! do |word|
				word = word.downcase
			end
			parsedSpecs["CPUType"] << data
		end
	end
end
words = parsedSpecs["CPUType"].flatten.uniq
wordCount = {}
common = []
parsedSpecs["CPUType"].each do |word|
	word.each do |w|
		if !wordCount.has_key?(w) then
			wordCount[w] = 0
		end
		wordCount[w] += 1
	end
end
max = wordCount.values.sort.last

wordCount.each do |word, count|
	common << word if count >= max-1
end

parsedSpecs["CPUType"] = [words,common]
p parsedSpecs["CPUType"]
=end
