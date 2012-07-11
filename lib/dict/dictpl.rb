# -*- coding: utf-8 -*-

require 'nokogiri'
require 'dict/dictionary'

DICT_URL = 'http://dict.pl/dict?word='

module Dict
  class Dictpl < Dictionary
    # returns hash with translations as keys and examples as values
    def translate
      context_words = []
      Nokogiri::HTML(open(get_uri(DICT_URL, @word))).xpath('//td[@class="resWordCol"]/a').each do |node|
        context_words << node.text
      end
      make_hash_results(context_words)
    rescue OpenURI::HTTPError
      raise Dictionary::ConnectError
    end
  end
end
