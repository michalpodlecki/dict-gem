# -*- encoding: utf-8 -*

require 'dict/dictpl'

describe Dict::Dictpl do

  it "should raise no given word exception" do
    expect { Dict::Dictpl.new }.to raise_error ArgumentError
  end

  it "should return hash for given word: 'samochód'" do
    result = Dict::Dictpl.new('samochód', DICT_URL).translate
    result.should be_a(Hash)
  end

  it "should return array with translations" do
    d = Dict::Dictpl.new('samochód', DICT_URL)
    d.translate
    d.translations.should be_a(Array)
  end

  it "should return array with examples of translated words" do
    d = Dict::Dictpl.new('samochód', DICT_URL)
    d.translate
    d.examples.should be_a(Array)
  end

  it "should return a hash from array of paired values" do
    d = Dict::Dictpl.new('samochód', DICT_URL)
    d.make_hash_results(d.translate).should be_a(Hash)
  end

end
