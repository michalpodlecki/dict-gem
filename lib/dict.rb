#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

require 'uri'
require 'net/http'

module Dict
  class Translation
    def initialize(word)
        @word = ARGV[0]
    end
    
    def self.status(adres = "http://dict-app-staging.shellyapp.com/")
      uri = URI(adres)
      res = Net::HTTP.get_response(uri)
      puts res.message
    end

    def self.getResponse(word, time = 3600)
      uri = URI.escape("http://dict-app-staging.shellyapp.com/#{word}")
      time_start = Time.now
      puts Net::HTTP.get(uri)
      time_end = Time.now
      puts time_end - time_start
    end
  end
end

