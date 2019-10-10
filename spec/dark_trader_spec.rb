require_relative '../lib/dark_trader.rb'
require 'nokogiri'
require 'open-uri'



#Pour les tests, inspire-toi de la ressource plus haut. Il n'y a pas besoin de faire 36 000 tests, il faut juste arriver
#  à tester 1) le fonctionnement de base de ton programme (pas d'erreur ni de retour vide) et 2) que ton programme 
#  sort bien un array cohérent (vérifier la présence de 2-3 cryptomonnaies, vérifier que l’array est de taille cohérente, 
#  etc.).

#the program returns no error or nil value
describe "the program gives a valid return" do 
    it "doesn't return a nil" do 
        expect(dark_trader(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")))).not_to be_nil
    end 
    it "returns an array" do 
        expect(dark_trader(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))).class).to eq(Array)
    end 
end

#the program returns accurate data
describe "the program returns accurate results" do 
    it "has at least 100 elements (crypto currencies)" do 
        expect(dark_trader(Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))).include?('{"BTC"=>8525.47}')).to eq(true)
    end 
end 

