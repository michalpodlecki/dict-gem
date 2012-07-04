require 'open-uri'
require 'nokogiri'

class Dictpl

  DICT_URL = "http://dict.pl/dict?word=" 
  def initialize(word)
	raise ArgumentError, "No given word" if word.empty?
	@word = word
	@uri = URI(URI.escape(DICT_URL + @word + "&lang=EN"))
	
	#puts 'word: ' + @word
	#puts 'uri: ' + @uri.to_s
  end

  def translate
    res = []
    doc = Nokogiri::HTML(open(@uri))
    doc.xpath('//td[@class="resWordCol"]/a')[0..1].each do |node|
	  res = node.text
      #puts res
    end
    res
  end
  
end


# example of usage
word = ARGV[0]
word ||= ""

translation = Dictpl.new word
puts translation.translate
