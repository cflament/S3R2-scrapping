require_relative '../lib/mairie_christmas.rb'

#test de la méthode Get Townhall Email
describe "the method get_townhall_email should return the email scrapped on the townhall website" do
    it "should return a not value which is not nil" do 
        expect(get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert")).not_to be_nil
    end 
    it "should never return an empty string" do #remplacement des vides par un message d'erreur prévu dans le code
        expect(get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert")).not_to be_empty 
    end
    it "should return a string" do 
        expect(get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert").class).to eq(String)
    end 
    it "should include an @" do 
        expect(get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert").include?("@")).to eq(true)
    end 
    it "should send the mail : mairie-de-st-lambert-des-bois@orange.fr for St Lambert townhall" do 
        expect(get_townhall_email("http://annuaire-des-mairies.com/78/saint-lambert")).to eq("mairie-de-st-lambert-des-bois@orange.fr")
    end
end 

#test de la méthode get townhall_ulrs
describe "the method should return an array of valid urls" do 
    it "shouldn't return a nil" do 
        expect(get_townhall_urls).not_to be_nil 
    end 
    it "should return an array" do 
        expect(get_townhall_urls.class).to eq(Array)
    end
end 



