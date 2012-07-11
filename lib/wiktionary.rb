# -*- coding: utf-8 -*-

require 'nokogiri'
require_relative 'dictionary'

WIKI_URL = 'http://en.wiktionary.org/wiki/'

class Wiktionary < Dictionary
  # Method returns hash with translations as keys and examples of using words as values
  def translate
    context_words = []
    url = 'http://en.wiktionary.org/wiki/'
    get_html(@uri).css('p + ol li a').each do |node|
      get_html(url + node.text.tr(' ', '_')).css('p + ol > li dl dd').each do |example|
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
