# -*- encoding: utf-8 -*

require_relative './vcr_setup'
require 'dict/dictpl'

describe Dict::Dictpl do

  it "should raise no given word exception" do
    expect { Dict::Dictpl.new }.to raise_error ArgumentError
  end
  
  it "should return array with translations for 'krowa'" do
    VCR.use_cassette('translations_krowa_cassette') do
	  d = Dict::Dictpl.new("krowa")
	  d.translate
	  d.translations.should be_a(Array)
	  d.translations.should == ["krowa", "krowa bliska wycielenia", "krowa mleczna", "krowa morska; Hydrodamalis gigas", "krowa morska; krowa morska Stellera; Hydrodamalis gigas (wymarły ssak morski)", "krowa nie zapłodniona", "krowa po pierwszym ocieleniu się", "krowa wysokomleczna", "cielna krowa", "dojna krowa", "mleczna krowa", "wata cukrowa", "mąka cukrowa", "święta krowa", "trzcina cukrowa", "lukier; polewa lukrowa", "święta krowa [przen]"]
    end    
  end
  
  it "should return array with examples for 'krowa'" do
    VCR.use_cassette('examples_krowa_cassette') do
	  d = Dict::Dictpl.new("krowa")
	  d.translate
      d.examples.should be_a(Array)
      d.examples.should == [["cow"], ["freshen of cow"], ["milker", "milcher", "milk cow", "dairy cow", "milch cow"], ["Steller's sea cow"], ["Steller's sea cow"], ["barren cow"], ["cow heifer"], ["deep milking cow"], ["springer"], ["milch-cow"], ["milk cow"], ["candyfloss", "candy floss", "candy-floss", "cotton candy"], ["false grain"], ["sacred moose"], ["sugarcane"], ["icing"], ["sacred cow"]]    
    end    
  end
    
  it "should return array with translations for 'samochód'" do
    VCR.use_cassette('translations_samochod_cassette') do
      d = Dict::Dictpl.new('samochód')
      d.translate
      d.translations.should be_a(Array)
      d.translations.should == ["samochód", "samochód ciężarowy", "samochód ciężarowy; samochód skrzyniowy", "samochód cysterna (rodzaj pojazdu)", "samochód do przewozu wojska [wojsk]", "samochód dostawczy", "samochód dwudrzwiowy", "docierać samochód", "kasować samochód", "pojazd; samochód", "duży i tani samochód", "wypożyczony samochód", "uruchomić samochód", "krążownik szos; duży amerykański samochód", "zapalać samochód (zwłaszcza na pych)", "kabriolet; samochód bez dachu", "uruchomić samochód bez uzycia kluczyków (zwłaszcza, aby go ukraść)", "ciężarówka; samochód ciężarowy"]
    end
  end
  
  it "should return array with examples for 'samochód'" do
    VCR.use_cassette('examples_samochod_cassette') do
      d = Dict::Dictpl.new('samochód')
      d.translate
      d.examples.should be_a(Array)
      d.examples.should ==  [["car", "autocar", "automobile"], ["lorry"], ["truck"], ["gas tanker", "petrol tanker", "gasoline tanker"], ["troop-carrying vehicle"], ["van", "cargo plane"], ["two-door car"], ["break in"], ["write off"], ["automobile"], ["flivver"], ["u-drive"], ["put the car in gear"], ["yank-tank"], ["bump-start", "push-start"], ["no-top"], ["hot-wire"], ["lorry"]]
    end
  end

  it "should return a hash from array of paired values" do
    VCR.use_cassette('paired_value_samochod_cassette') do
      d = Dict::Dictpl.new('samochód')
      d.make_hash_results(d.translate).should be_a(Hash)
    end
  end
  
end
