require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_page
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	return page
end 

def get_townhall_email(townhall_url)
	a = []
	page = Nokogiri::HTML(open(townhall_url))

	email = page.xpath('//*[contains(text(), "@")]').text
	town = page.xpath('//*[contains(text(), "Adresse mairie de")]').text.split

	a << {town[3] => email}
	puts a
	return a
end

def get_townhall_urls
	url_array = []
	page = get_page

	urls = page.xpath('//*[@class="lientxt"]/@href')

	urls.each do |url|
		url = "http://annuaire-des-mairies.com" + url.text[1..-1]
		url_array << url		
	end
	return url_array 
end

def scrapp
	url_array = get_townhall_urls
	url_array.each do |townhall_url|
		get_townhall_email(townhall_url)
	end
end 

scrapp
