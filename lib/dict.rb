#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

require 'uri'
require 'net/http'
require 'timeout'

module Dict
  class Translation
    def initialize
        @word = ARGV[0]
    end
    
    def self.status(adres = "http://dict-app-staging.shellyapp.com/")
      uri = URI(adres)
      res = Net::HTTP.get_response(uri)
      res.message
    end

    def self.get_response(word, time, dict)
      uri = URI.parse(URI.escape("http://dict-app-staging.shellyapp.com/#{dict}/#{word}"))
      begin
        Timeout::timeout(time.to_i) do
          res = Net::HTTP.get(uri)
          "Success" unless res.empty?
        end
        
        rescue => ex
          puts "Timeout for the query."
          {:code => 408, :describe => "Request Timeout"}
        end
      end
  end
end

