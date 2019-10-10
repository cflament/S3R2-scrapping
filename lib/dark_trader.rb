require 'rubygems'
require 'nokogiri'
require 'open-uri'


page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def currencies(page)
    begin
        currencies_array = []
        page.xpath('//*[@class="text-left col-symbol"]').each do |node|
            #page.xpath('//h1[@class="primary"]/a[@id="email"]')
            currencies_array << node.text 
        end 
        currencies_array
        
    rescue => e
        puts "Oups petite erreur, sur l'array des currencies mais c'est pas grave" 
    end
end

def prices(page)
    begin
        prices_array = []
        page.xpath('//*[@class="price"]').each do |node|
            #page.xpath('//h1[@class="primary"]/a[@id="email"]')
            prices_array << node.text.delete_prefix("$").to_f 
        end 
        prices_array
        
    rescue => e
        puts "Oups petite erreur, sur l'array des currencies mais c'est pas grave" 
    end
end

def combine_arrays_to_hash(array_1,array_2)
    if array_1.length != array_2.length 
        puts "combination not possible, arrays are of different size"
    else
        array_final = []
        array_2.size.times do |i|
            array_final << {array_1[i] => array_2[i]}
        end 
    end
    array_final 
end

def dark_trader(page)
    currencies_array = currencies(page)
    puts "currency_array : "
    print currencies_array
    prices_array = prices(page)
    result = combine_arrays_to_hash(currencies_array,prices_array)
    puts "prices array : "
    print prices_array
    puts "combination : "
    print result
    return result 
end 

dark_trader(page)

  