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
end
