require 'rubygems'
require 'nokogiri'
require 'open-uri'
   
page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   


symbols = page.xpath('//*[@class="text-left col-symbol"]')
symbols_array = []
symbols.each do |symbol|
	symbols_array << symbol.text
end
# print symbols_array
puts '-' * 10
puts symbols_array.size

prices = page.xpath('//*[@class="price"]')
prices_array = []
prices.each do |price|
	prices_array << price.text
end

# print prices_array
puts '-' * 10
puts prices_array.size


a = symbols_array.zip(prices_array).to_h
a.transform_values! { |v| v.delete'$'}
print a