# -*- encoding: utf-8 -*
require_relative '../dictpl'

describe Dictpl do
  
  it "should raise 'No given word' exception" do
    expect { Dictpl.new }.to raise_error ArgumentError
  end
  
  it "should return string 'cow'" do
    word = "krowa"
    dict = Dictpl.new(word)
    dict.translate.should be_a(String)
    dict.translate.should eq("cow")
  end
  
  it "should return string 'hi'" do
    word = "cześć"
    dict = Dictpl.new(word)
    dict.translate.should be_a(String)
    dict.translate.should eq("hi")
  end  
  
end
