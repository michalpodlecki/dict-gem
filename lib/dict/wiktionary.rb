# -*- coding: utf-8 -*-

require 'nokogiri'
require 'dict/dictionary'

WIKI_URL = 'http://en.wiktionary.org/wiki/'

module Dict
  class Wiktionary < Dictionary
    # returns hash with structure as showed below
    # { 'TRANSLATION' => ['EXAMPLE', ...], ... }
    def translate
      context_words = []
      get_html(uri(WIKI_URL, @word)).css('p + ol li a').each do |node|
        get_html(uri(WIKI_URL, node.text)).css('p + ol > li dl dd').each do |example|
          context_words << node.text << example.text
        end
      end
      make_hash_results(context_words)
    end

    def get_html(url)
      Nokogiri::HTML(open(url))
    rescue OpenURI::HTTPError
      raise Dictionary::ConnectError
    end
  end
end
