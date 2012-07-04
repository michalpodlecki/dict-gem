# -*- coding: utf-8 -*-
require_relative '../lib/dict'

describe Dict do
  
  it "should return OK if server connection is successful" do
    Dict::Translation.status.should == "OK"
  end

  it "should return SUCCESS if server makes response" do
    Dict::Translation.getResponse("Słoń",3698) == "Success"
  end

  it "should stop after the expiry of time" do
    Net::HTTP.should_receive(:get).and_return { sleep 5 }
    Dict::Translation.getResponse("słoń",1) == {:code => 408, :describe => "Request Timeout"} 
  end

end
