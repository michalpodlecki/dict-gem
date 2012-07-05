require 'net/http'
require 'nokogiri'

class Wiktionary
  WIKI_URL = "http://en.wiktionary.org/wiki/"
  def initialize(word)
    if word.empty? then raise ArgumentError, "No word given." end
    escaped_word = word.downcase.tr(' ', '_')
    @uri = URI(URI.escape(WIKI_URL + escaped_word))
  end

  #
  # Method returns an array of translations and word usage examples
  # For instance to given word 'samochód' it returns:
  # [["car","automobile"],["She drove her car to the mall.", "The conductor linked the cars to the locomotive.", "The 11:10 to    London was operated by a 4-car diesel multiple unit"]
  #
  def translate
    req = Net::HTTP::Get.new(@uri.path)
    response, translations, sentences = nil, [], []
    Net::HTTP.start(@uri.host, @uri.port) do |http|
      response = http.request(req).body

      doc = Nokogiri::HTML(response)
      doc.css('div#mw-content-text h2:first .mw-headline').each do |lang|
        raise "Given word is not polish." if lang.content != 'Polish'
      end
      doc.css('div#mw-content-text[lang=en] ol > li a').each do |link|
        translations.push link.content
      end

      translations.each do |item|
        escaped_item = item.tr(' ', '_')
        sentence = Nokogiri::HTML(Net::HTTP.get(URI(WIKI_URL + escaped_item)))
        sentence.css('div#mw-content-text[lang=en] ol:first > li dl dd i').each do |s|
          sentences.push s.content
        end
      end

    end
    [translations, sentences]
  end
end
