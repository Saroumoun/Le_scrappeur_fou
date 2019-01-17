require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_page
	page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr"))
	return page
end 

def scrapp_emails
	page = get_page
	emails_array = []
	bureau = "bureau-m-orphelin@assemblee-nationale.fr"
	secretariat = "secretariat-blanchet@assemblee-nationale.fr"

	emails = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]')
	
	emails.each do |email|
		emails_array << email.text.strip unless email.text.strip == bureau || email.text.strip == secretariat
	end
	return emails_array
end

def scrapp_names
	page = get_page
	full_names_array = []

	page.xpath('//*[@class="titre_normal"]').each do |the_name|
		full_names_array << { "first_name" => the_name.text.split(" ")[1], "last_name" => the_name.text.split(" ")[2]}
	end
	return full_names_array		
end

def join_name_and_email
	full_names_array = scrapp_names
	emails_array = scrapp_emails

	full_names_array.map { |v| v["email"] = ""; v }
    full_names_array.map.with_index { |hash, i| hash["email"] = emails_array[i]; hash }
	puts full_names_array
	return full_names_array       
end

join_name_and_email


