#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

# Method returns an Result Object containing given word,
# translations, word usage examples.
# Usage example:
# result = Wiktionary.new("samochód").translate
# result.term         # => "samochód"
# result.translations # => {"samochód"=> 
# ["car", "automobile"]}
# result.examples     # => {"samochód"=>["She drove her
# car to the mall.", "The conductor linked the cars to 
# the locomotive.", "The 11:10 to London was operated by
#  a 4-car diesel multiple unit", "From the front-most 
# car of the subway, he filmed the progress
# through the tunnel.", "We ordered five hundred cars of gypsum.", ...]}

require 'net/http'
require 'nokogiri'
require_relative 'result'

class Wiktionary
  WIKI_URL = "http://en.wiktionary.org/wiki/"
  def initialize(word)
    check_arguments(word)
    initialize_instance_arguments(word)
  end
  
  def translate
    req = Net::HTTP::Get.new(@uri.path)
    response, translations = nil, []
    Net::HTTP.start(@uri.host, @uri.port) do |http|
      response = http.request(req).body
      
      doc = Nokogiri::HTML(response)

      return @result unless is_polish?(doc)

      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        @result.add_translation(@result.term,link.content)
      end
      
      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        translations.push(link.content)
      end

      translations.each do |item|
        escaped_item = item.tr(' ', '_')
        example = Nokogiri::HTML(Net::HTTP.get(URI(WIKI_URL + escaped_item)))
        example.css('div#mw-content-text[lang=en] ol:first > li dl dd i').each do |s|
          @result.add_example(@result.term,s.content)
        end
      end
    end
    
    @result
  end
  
  def initialize_instance_arguments(word)
    escaped_word = word.downcase.tr(' ', '_')
    @result = Result.new(escaped_word)
    @uri = URI(URI.escape(WIKI_URL + escaped_word))    
  end
  
  def check_arguments(word)
    if word.empty? then raise ArgumentError.new("No word given.") end
  end

  def is_polish?(doc)
    polish = doc.css('div#mw-content-text h2 .mw-headline').any? do |lang|
      lang.content == 'Polish'
    end
  end
  
end
