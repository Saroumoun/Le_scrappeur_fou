
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#1 Première méthode : Déclaration de la page à scrapper
def get_page
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	return page
end 

#2 Deuxième méthode : Collecte des abbréviations des noms des monnaies
def scrapp_symbols
	page = get_page
	symbols = page.xpath('//*[@class="text-left col-symbol"]')
	symbols_array = [] #/ initialisation d'un array pour les stocker
	symbols.each do |symbol| #/ on met .text pour les avoir en string après each car each que sur integer
		symbols_array << symbol.text 
	end
	return symbols_array
end

#3 Troisième méthode : Collecte des cours des monnaies
def scrapp_prices
	page = get_page
	prices = page.xpath('//*[@class="price"]')
	prices_array = []
	prices.each do |price|
		prices_array << price.text[1..-1].to_f
	end
	return prices_array
end 

#4 Quatrième méthode : Synchronisation des noms et des cours des monnaies
def crypto_master
	symbols_array = scrapp_symbols #/ on rappelle nos méthodes
	prices_array = scrapp_prices 
	a = [] #/ on initialise un array pour les stocker

	symbols_array.each_with_index do |k, v|	#/ on associe pour chaque item de symbols_array un item de prices_array
		a << {k => (prices_array)[v]} #/ on sauvegarde sous forme d'hash dans le tableau
	end
	print a
	return a
end


crypto_master
	