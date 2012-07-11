# -*- encoding: utf-8 -*

require 'dict/wiktionary'

describe Dict::Wiktionary do

  it "should raise no given word exception" do
    expect { Dict::Wiktionary.new }.to raise_error ArgumentError
  end

  it "should return an two element array of translations of word samochód containing [\"car\",\"automobile\"]" do
    w = Dict::Wiktionary.new('samochód')
    w.translate
    w.translations.should == ["car", "automobile"]
  end

  it "should return array with translations" do
    w = Dict::Wiktionary.new('samochód')
    w.translate
    w.translations.should be_a(Array)
  end

  it "should return array with examples of translated words" do
    w = Dict::Wiktionary.new('samochód')
    w.translate
    w.examples.should be_a(Array)
  end

  it "should return a hash from array of paired values" do
    w = Dict::Wiktionary.new('samochód')
    w.make_hash_results(w.translate).should be_a(Hash)
  end

end
