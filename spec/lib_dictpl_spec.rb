# -*- encoding: utf-8 -*
require_relative '../lib/dictpl'

describe Dictpl do
  
  it "should raise 'No given word' exception" do
    expect { Dictpl.new }.to raise_error ArgumentError
  end
  
  it "should return hash for 'krowa'" do
    word = "krowa"    
    dict = Dictpl.new(word)
    result = dict.translate
    result.translations.should be_a(Hash)
    result.translations.should == {"krowa"=>["cow"], "krowa bliska wycielenia"=>["freshen of cow"], "krowa mleczna"=>["milker", "milcher", "milk cow", "dairy cow", "milch cow"], "krowa morska; Hydrodamalis gigas"=>["Steller's sea cow"], "krowa morska; krowa morska Stellera; Hydrodamalis gigas (wymarły ssak morski)"=>["Steller's sea cow"], "krowa nie zapłodniona"=>["barren cow"], "krowa po pierwszym ocieleniu się"=>["cow heifer"], "krowa wysokomleczna"=>["deep milking cow"], "cielna krowa"=>["springer"], "dojna krowa"=>["milch-cow"], "mleczna krowa"=>["milk cow"], "wata cukrowa"=>["candyfloss", "candy floss", "candy-floss", "cotton candy"], "mąka cukrowa"=>["false grain"], "święta krowa"=>["sacred moose"], "trzcina cukrowa"=>["sugarcane"], "lukier; polewa lukrowa"=>["icing"], "święta krowa [przen]"=>["sacred cow"]} 
  end
  
  it "should return hash for 'car'" do
    word = "car"    
    dict = Dictpl.new(word)
    result = dict.translate
    result.translations.should be_a(Hash)
    result.translations.should == {"car"=>["tsar", "tzar"], "Caracas"=>["Caracas"], "Caranx bartholomaei (gatunek ryby)"=>["yellow jack"], "Caranx caballus (gatunek ryby)"=>["green jack"], "Caranx caninus (gatunek ryby)"=>["Pacific crevalle jack"], "Caranx crysos (gatunek ryby)"=>["blue runner"], "Caranx heberi (gatunek ryby)"=>["blacktip trevally"], "Caranx hippos (gatunek ryby)"=>["cavalla", "Crevalle jack"], "Caranx ignobilis (gatunek ryby)"=>["giant trevally"], "Caranx kleinii (gatunek ryby)"=>["razorbelly scad"], "samochód"=>["car"], "wagon tramwajowy (rodzaj pojazdu transportu publicznego)"=>["car"], "antena samochodowa (do radia samochodowego)"=>["car aerial", "car antenna"], "samochód-pułapka"=>["car bomb"], "drobna, okazyjna sprzedaż (często prosto z bagażnika samochodu)"=>["car boot sale"], "samochodziarz (osoba pasjonująca się naprawianiem lub odnawianiem samochodów)"=>["car buff"], "zegar samochodowy (czasowy)"=>["car clock"], "włamanie do samochodu"=>["car clout"], "prochowiec"=>["car coat"], "kraksa samochodowa"=>["car crash"], "dealer samochodowy; salon samochodowy"=>["car dealer"]}
  end  
  
end
