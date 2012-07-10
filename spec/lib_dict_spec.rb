# -*- coding: utf-8 -*-
require_relative '../lib/dict'

describe Dict do
  
  it "shoud return Hash with translations of word 'samochód' for all available services" do
    get_all_dictionaries_translations("samochód") == {}

  end



end
