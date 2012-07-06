# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'
require_relative 'result'


class Dictpl

  DICT_URL = "http://dict.pl/dict?word=" 
  def initialize(word)    
		check_arguments(word)
		initialize_instance_arguments(word)
  end
  
  #
  # Method returns hash with translations in many context for a word. 
  # Example: for the word 'krowa' it returns translations in such a form:
  # {"krowa"=>["cow"], "krowa bliska wycielenia"=>["freshen of cow"], ... }
  #
  def translate
    @context_words = [] 
    
    doc = Nokogiri::HTML(open(@uri))
    doc.xpath('//td[@class="resWordCol"]/a').each do |node|
      @context_words << node.text
    end
    
    @mapped_words = {} # hash containing words with matched translations
	
    @context_words.each_slice(2) do |word|	     
      @mapped_words[word.first] = word.last
      @result.add_translation(word.first, word.last)
    end    
    @result
  end

	def check_arguments(word)												
    if word.empty? then raise ArgumentError.new("No word given.") end
  end
	
	def initialize_instance_arguments(word)
		@word = word
    @uri = URI(URI.escape(DICT_URL + @word + "&lang=EN"))	
    @result = Result.new(word)
  end
end

a = Dictpl.new "samochód"
a.translate.translations.each_pair do |key, value|
  puts key + value.to_s
end
