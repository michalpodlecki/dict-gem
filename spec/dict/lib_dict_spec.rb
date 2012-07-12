# -*- coding: utf-8 -*-

require 'dict/dict'

describe Dict do

  it "should get single translation from dictionary with two arguments given" do
    expect{
      Dict.get_single_dictionary_translations('samochód', 'dictpl')
    }.to_not raise_error
  end

  it "should return hash with translations from all dictionaries" do
    Dict.get_all_dictionaries_translations('samochód').should be_a(Hash)
  end

  it "should return array of available services which is not empty" do
    arr = Dict.available_dictionaries
		arr.should be_a(Array)
		arr.size.should_not == 0
  end

	it "should return array of available services which contains wiktionary and dictpl" do
		Dict.available_dictionaries.should == ['wiktionary', 'dictpl']
	end

end
