
require 'rubygems'
require 'nokogiri'
require 'open-uri'


#1 Première méthode : Déclaration de la page à scrapper
def get_page
	page = Nokogiri::HTML(open("https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600&lang=fr"))
	return page
end 

#2 Deuxième méthode : Collecte des emails des députés
def scrapp_emails
	page = get_page
	emails_array = []
	bureau = "bureau-m-orphelin@assemblee-nationale.fr" #/ on met à l'écart deux mails en doublons identifiés
	secretariat = "secretariat-blanchet@assemblee-nationale.fr"

	emails = page.xpath('//*[contains(text(), "@assemblee-nationale.fr")]') 
	
	emails.each do |email|
		emails_array << email.text.strip unless email.text.strip == bureau || email.text.strip == secretariat
	end
	return emails_array
end

#3 Troisième méthode : Collecte des noms et prénoms des députés
def scrapp_names
	page = get_page
	full_names_array = []

	page.xpath('//*[@class="titre_normal"]').each do |the_name| #/ on enlève le Madame, Monsieur en ne prenant que le deuxième et troisième bloc de la string
		full_names_array << { "first_name" => the_name.text.split(" ")[1], "last_name" => the_name.text.split(" ")[2]}
	end
	return full_names_array		
end

#4 Quatrième méthode : Synchronisation des noms et emails des députés
def join_name_and_email
	full_names_array = scrapp_names
	emails_array = scrapp_emails

    full_names_array.map.with_index { |hash, i| hash["email"] = emails_array[i]} 
    #/ pour chaque nom et prénom de députés, on associe une adresse mail.
    #/ rajout dans un hash de l'email associé.
	puts full_names_array
	return full_names_array  
end


join_name_and_email


