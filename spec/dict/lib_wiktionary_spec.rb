# -*- encoding: utf-8 -*

require 'dict/wiktionary'

describe Dict::Wiktionary do

  it "should raise no given word exception" do
    expect { Dict::Wiktionary.new }.to raise_error ArgumentError
  end

  it "should return an two element array of translations of word samochód containing [\"car\",\"automobile\"]" do
    w = Dict::Wiktionary.new('samochód').translate
    w.translations.should == {"samochód"=>["car", "automobile"]}
  end

  it "should return a hash with translations" do
    w = Dict::Wiktionary.new('samochód').translate
    w.translations.should be_a(Hash)
  end

  it "should return a Resut object" do
    w = Dict::Wiktionary.new('samochód').translate
    w.should be_a(Dict::Result)
  end
  
  it "should return translation from english to polish for word 'field'" do
    result = Dict::Wiktionary.new('field').translate.translations
    result.should eq({"field"=>["pole", "pole (magnetyczne, elektryczne, sił, itp.)", "pole (skalarne, wektorowe, itp.)", "ciało (liczb rzeczywistych, zespolonych, itp.)", "wystawić (drużynę)", "odpowiadać (na pytania)", "polowy", "polny"]})
  end
end
