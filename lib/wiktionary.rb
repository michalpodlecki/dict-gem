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
  WIKI_EN = "http://en.wiktionary.org/wiki/"
  WIKI_PL = "http://pl.wiktionary.org/wiki/"
  def initialize(word)
    check_arguments(word)
    initialize_instance_arguments(word)
  end
  
  def translate
    translations = []    
    @uri = URI.parse(URI.escape("#{WIKI_EN}#{@word}"))  
    doc = get_html(@uri)
    
    if is_polish?(doc)
      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        @result.add_translation(@result.term, link.content)
      end      
      
      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        translations.push(link.content)
      end

      get_examples_of_translations_en(@result, translations, WIKI_EN)
    
      @result
    else
      @uri = URI.parse(URI.escape("#{WIKI_PL}#{@word}"))  
      doc = get_html(@uri)
            
      doc.css('div#mw-content-text dfn a').each do |link|
        @result.add_translation(@result.term, link.content)
      end      
      
      doc.css('div#mw-content-text dfn a').each do |link|
        translations.push(link.content)
      end

      get_examples_of_translations_pl(@result, translations, WIKI_PL)
      @result
    end
  end
  
  private

  def get_html(uri)
    Nokogiri::HTML(Net::HTTP.get(uri))
  end

  def get_examples_of_translations_en(result, translations, adres)
    translations.each do |item|
      example = Nokogiri::HTML(Net::HTTP.get(URI(adres + item.tr(' ', '_'))))
      example.css('div#mw-content-text[lang=en] ol:first > li dl dd i').each do |s|
        result.add_example(result.term, s.content)
      end
    end
  end
  
  def get_examples_of_translations_pl(result, translations, adres)
    translations.each do |item|
      example = Nokogiri::HTML(Net::HTTP.get(adres + item))
      example.css('div#mw-content-text[lang=pl] dl dd').each do |s|
        result.add_example(result.term, s.content)
      end
    end
  end

  def initialize_instance_arguments(word)
    @result = Result.new(word.downcase.tr(' ', '_'))
    @word = word  
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
