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
    translations = []
    
    doc = get_html(@uri)

    return @result unless is_polish?(doc)
    
    doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
      @result.add_translation(@result.term, link.content)
    end
      
    
    doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
      translations.push(link.content)
    end

    examples_of_translations(@result, translations)
    
    @result
  end
  
  private

  def get_html(uri)
    Nokogiri::HTML(Net::HTTP.get(uri))
  end

  def examples_of_translations(result, translations)
    translations.each do |item|
      example = Nokogiri::HTML(Net::HTTP.get(URI(WIKI_URL + item.tr(' ', '_'))))
      example.css('div#mw-content-text[lang=en] ol:first > li dl dd i').each do |s|
        result.add_example(result.term, s.content)
      end
    end
  end

  def initialize_instance_arguments(word)
    @result = Result.new(word.downcase.tr(' ', '_'))
    @uri = URI(URI.escape(WIKI_URL + word.downcase.tr(' ', '_')))    
  end
  
  def check_arguments(word)
    if word.empty? then raise ArgumentError.new("No word given.") end
  end

  def is_polish?(doc)
    doc.css('div#mw-content-text h2 .mw-headline').any? do |lang|
      lang.content == 'Polish'
    end
  end
 
end
