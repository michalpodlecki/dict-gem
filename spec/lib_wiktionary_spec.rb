# -*- encoding: utf-8 -*
require_relative '../lib/wiktionary'

describe Wiktionary do
  it "should be an argument given" do
    expect { Wiktionary.new }.to raise_error ArgumentError
  end

  it "should return an empty array" do
    word = "dziwneslowo"
    wiki = Wiktionary.new(word)
    wiki.translate.should be_a(Array)
    wiki.translate[0].size.should == 0
  end
	
  it "should return an one element array, containing =war= string" do
    word = "wojna"
    wiki = Wiktionary.new(word)
		
    wiki.translate.should be_a(Array)
    wiki.translate[0][0].should eq("war")
  end
	
  it "should return an two element array of translations containing [\"car\",\"automobile\"]" do
    word = "samochód"
    wiki = Wiktionary.new word
    wiki.translate[0].size.should == 2
    wiki.translate[0].should eq(["car","automobile"])
  end
  
  it "should return a proper translations for 'car' word" do
    word = "samochód"
    wiki = Wiktionary.new(word)
    wiki.translate[1][0].should eq("She drove her car to the mall.")
    wiki.translate[1][1].should eq("The conductor linked the cars to the locomotive.")
  end
  
  it "should raise an error because of not polish word" do
    wiki = Wiktionary.new("field")
    expect { wiki.translate }.to raise_error("Given word is not polish.")
  end
end
