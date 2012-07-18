# -*- coding: utf-8 -*-

require 'dict/dict'

describe Dict do

  it "should return array of available services which is not empty" do
    arr = Dict.available_dictionaries
    arr.should be_a(Array)
    arr.size.should_not == 0
  end

  it "should return array of available services, which contains wiktionary and dictpl" do
    Dict.available_dictionaries.should == ['wiktionary']
  end

  it "should return hash with translations from all dictionaries" do
    wiktionary = stub(:translate => stub(:translations => {'WORD' => 'WIKTIONARY_RESULTS'}))
    Dict::Wiktionary.should_receive(:new).with('WORD').and_return(wiktionary)

    results = Dict::get_all_dictionaries_translations('WORD')
    results.should == {'wiktionary' => {'WORD' => 'WIKTIONARY_RESULTS'}}
  end

  it "should return whatever Wiktionary returns embedded in a hash" do
    wiktionary = stub(:translate => stub( :translations => 'WIKTIONARY_RESULTS'))
    Dict::Wiktionary.should_receive(:new).with('WORD').and_return(wiktionary)
    Dict.get_single_dictionary_translations('WORD', 'wiktionary').should == 'WIKTIONARY_RESULTS'
  end
end
