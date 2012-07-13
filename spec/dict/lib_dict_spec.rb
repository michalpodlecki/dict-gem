# -*- coding: utf-8 -*-

require 'dict/dict'

describe Dict do

  it "should return array of available services which is not empty" do
    arr = Dict.available_dictionaries
    arr.should be_a(Array)
    arr.size.should_not == 0
  end

  it "should return array of available services, which contains wiktionary and dictpl" do        
    Dict.available_dictionaries.should == ['wiktionary', 'dictpl']
  end
  
 
  
  it "should return whatever Dictpl returns embedded in a hash" do
    dictpl = stub(:translate => 'DICTPL_RESULTS')
    Dict::Dictpl.should_receive(:new).with('WORD').and_return(dictpl)
    Dict.get_single_dictionary_translations('WORD', 'dictpl').should == 'DICTPL_RESULTS'
  end
end
