require 'net/http'
require 'nokogiri'

class Wiktionary
  WIKI_URL = "http://en.wiktionary.org/wiki/"
  def initialize(word)
    if word.empty? then raise ArgumentError, "No word given." end
    @uri = URI(URI.escape(WIKI_URL + word.downcase))
  end
  
  def translate
    req = Net::HTTP::Get.new(@uri.path)
    response, translations, sentences = nil, [], []
    Net::HTTP.start(@uri.host, @uri.port) do |http|
      response = http.request(req).body
      
      doc = Nokogiri::HTML(response)
      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        translations.push link.content
      end
      
      translations.each do |item|
        sentence = Nokogiri::HTML(Net::HTTP.get(URI(WIKI_URL + item)))
        sentence.css('div#mw-content-text[lang=en] ol > li dl dd i').each do |s|
          sentences.push s.content
        end
      end
      
    end
    [translations, sentences]
  end
end
