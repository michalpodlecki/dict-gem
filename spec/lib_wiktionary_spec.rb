# -*- encoding: utf-8 -*
require_relative '../lib/wiktionary'

describe Wiktionary do
  it "should be an argument given" do
    expect { Wiktionary.new }.to raise_error ArgumentError
  end
  
  it "should return an empty translations array" do
    word = "dziwneslowo"
    wiki = Wiktionary.new(word)
    result = wiki.translate
    result.translations.should be_a(Hash)
    result.translations.size.should == 0
  end
  
  it "should return an one element array, containing =war= string" do
    word = "wojna"
    wiki = Wiktionary.new(word)
    
    wiki.translate.translations[word].should be_a(Array)
    wiki.translate.translations[word].first.should eq("war")
  end
  
  it "should return an two element array of translations containing [\"car\",\"automobile\"]" do
    word = "samochód"
    wiki = Wiktionary.new(word).translate
    result = wiki.translations
    result[word].size.should == 2
    result[word].should eq(["car","automobile"])
  end
  
  it "should return a proper translations for 'car' word" do
    word = "samochód"
    wiki = Wiktionary.new(word)
    result = wiki.translate
    result.examples[word][0].should eq("She drove her car to the mall.")
    result.examples[word][1].should eq("The conductor linked the cars to the locomotive.")
  end

  it "should explode when i ask about english word" do
    word = "field"
    wiki = Wiktionary.new(word)
    wiki.translate == "pole"
  end
end
