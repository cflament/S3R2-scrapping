require 'rubygems'
require 'nokogiri'
require 'open-uri'


#gets the townhall email from the townhall url
def get_townhall_email(url)
    #gestion des cas où les urls ne seraient pas valides => on envoie N/A
    begin
        page = Nokogiri::HTML(open(url))
        email = page.xpath('//html[1]/body[1]/div[1]/main[1]/section[2]/div[1]/table[1]/tbody[1]/tr[4]/td[2]').text
        if email == ""
            email = "non renseigné"
        end 
      rescue => e
        email = "N/A"
      end 
    return email 
end 

#loop on all townhall_urls to have all emails
def get_townhall_urls
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
    town_url_list = []
    url_root = "https://annuaire-des-mairies.com"
    page.xpath('//*[@class="lientxt"]/@href').each do |node|
        townhall_url = url_root + node.value.to_s.delete_prefix(".")
        town_url_list << townhall_url
    end 
    town_url_list
end 

def get_town_names
    page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
    town_names_list = []
    page.xpath('//*[@class="lientxt"]').each do |node|
        townhall_name = node.text
        town_names_list << townhall_name
    end 
    town_names_list
end

def combine_town_names_and_urls (name_array,url_array)
    array_final = []
    name_array.each_with_index do |town_name,i|
        begin
        town_url = url_array[i]
        townhall_email = get_townhall_email(town_url)
        array_final << {town_name => townhall_email}
        rescue => e 
        array_final << "error for this townhall website"            
        end 
    end 
    array_final 

end 


def perform
    puts "liste des urls : \n"
    print townhall_urls = get_townhall_urls
    puts "\n liste des noms de ville : \n"
    print town_names_list = get_town_names
    puts "\n Combination : \n"
    puts result = combine_town_names_and_urls(town_names_list,townhall_urls)
    puts "nombre d'éléments dans la liste des mairies : #{townhall_urls.length}"
    puts "nombre d'éléments dans le hash : #{result.length}"
    
end 

#puts get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert")
perform 