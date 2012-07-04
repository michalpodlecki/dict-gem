# -*- coding: utf-8 -*-
require_relative '../lib/dict'
require 'rspec'

describe Dict do
  
  it "should return OK if server connection is successful" do
    Dict::Translation.status.should == "OK"
  end

end
