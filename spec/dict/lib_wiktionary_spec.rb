# -*- encoding: utf-8 -*

require_relative './vcr_setup'
require 'dict/wiktionary'

describe Dict::Wiktionary do

  it "should raise no given word exception" do
    expect { Dict::Wiktionary.new }.to raise_error ArgumentError    
  end

  it "should return an two element array of translations of word samochód containing [\"car\",\"automobile\"]" do
    VCR.use_cassette('wiktionary_translations_samochod_cassette') do
	  w = Dict::Wiktionary.new("samochód").translate
	  w.translations.should ==  {"samochód"=>["car", "automobile"]}	  
    end 
  end

  it "should return a hash with translations" do
    VCR.use_cassette('wiktionary_translations_samochod_cassette') do
	  w = Dict::Wiktionary.new("samochód").translate
	  w.translations.should be_a(Hash)
    end 
  end

  it "should return a Result object" do
    VCR.use_cassette('wiktionary_translations_samochod_cassette') do
	  w = Dict::Wiktionary.new("samochód").translate
	  w.should be_a(Dict::Result)
    end 
  end
  
  it "should return translation from english to polish for word 'field'" do
    VCR.use_cassette('wiktionary_translations_field_cassette') do
	  w = Dict::Wiktionary.new("field").translate.translations
	  w.should eq({"field"=>["pole", "pole (magnetyczne, elektryczne, sił, itp.)", "pole (skalarne, wektorowe, itp.)", "ciało (liczb rzeczywistych, zespolonych, itp.)", "wystawić (drużynę)", "odpowiadać (na pytania)", "polowy", "polny"]})
    end 
  end
  
  it "should remove html tags from translations of 'dragon' word" do
    VCR.use_cassette('translations_dragon_cassette') do
      Dict::Wiktionary.new("dragon").translate.translations.should eq({'dragon' => ['smok']})
    end
  end
  
  it "should return translations for word written with uppercase letters" do
    result = Dict::Wiktionary.new('SaMoCHÓd').translate.translations
    result.should eq({"samochód"=>["car", "automobile"]})
  end
  
  describe "#examples" do
    it "should return a empty hash of usage examples to 'assdd' word" do
      result = Dict::Wiktionary.new('field').translate.examples
      result.should eq({})
    end
    
    it "should return a hash containing usage examples to 'kot' word" do
      result = Dict::Wiktionary.new('kot').translate.examples
      result.should eq({"cat" => ["No room to swing a cat."]})
    end
  end
end
