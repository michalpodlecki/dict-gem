# -*- coding: utf-8 -*-

require 'nokogiri'
require_relative 'dictionary'

DICT_URL = 'http://dict.pl/dict?word='

class Dictpl < Dictionary
  # Method returns hash with translations as keys and examples of using words as values
  def translate
    context_words = []
    Nokogiri::HTML(open(@uri)).xpath('//td[@class="resWordCol"]/a').each do |node|
      context_words << node.text
    end
    make_hash_results(context_words)
  rescue OpenURI::HTTPError
    raise Dictionary::ConnectError
  end
end
