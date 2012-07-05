require 'open-uri'
require 'nokogiri'
require_relative 'result'


class Dictpl

  DICT_URL = "http://dict.pl/dict?word=" 
  def initialize(word)
	raise ArgumentError, "No given word" if word.empty?
	@word = word
	@uri = URI(URI.escape(DICT_URL + @word + "&lang=EN"))	
	@result = Result.new(word)
	
	#puts 'word: ' + @word
	#puts 'uri: ' + @uri.to_s
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
	  #puts node.text
    end
    
	@mapped_words = {} # hash containing words with matched translations
	
    @context_words.each_slice(2) do |word|	     
      @mapped_words[word.first] = word.last
      @result.add_translation(word.first, word.last)
      puts word.first + ' : ' + word.last
    end
    
    @result
  end
	  
end


# example of usage

word = ARGV[0]
word ||= "" 

# comment lines below if You want to use rspec
translation = Dictpl.new word
puts translation.translate.translations
