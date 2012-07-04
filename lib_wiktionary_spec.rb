# -*- encoding: utf-8 -*
require_relative '../lib/wiktionary'

describe Wiktionary do
	it "should return an empty array" do
  	word = "dziwneslowo"
		wiki = Wiktionary.new(word)
		wiki.translate.should be_a(Array)
		wiki.translate.size.should == 0
	end
	
	it "should return an one element array, containing =war= string" do
  	word = "wojna"
		wiki = Wiktionary.new(word)
		
		wiki.translate.should be_a(Array)

		wiki.translate[0].should eq("war")
	end
	
	it "should return an two element array, containing [\"car\",\"automobile\"]" do
		word = "samochód"
		wiki = Wiktionary.new word
		wiki.translate.size.should == 2
		wiki.translate.should eq(["car","automobile"])
	end
end
