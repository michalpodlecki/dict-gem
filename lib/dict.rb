#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

require_relative 'wiktionary'
require_relative 'dictpl'

module Dict
  class << self
    def get_all_dictionaries_translations(word)
      dictionaries = Hash.new
      
      available_services.each do |service|
        dictionaries[service] = get_single_dictionary_translations(word, service)
      end
      
      dictionaries
    end
    
    def get_single_dictionary_translations(word, service)
      case service
      when 'wiktionary'
        Wiktionary.new(word).translate
      when 'dictpl'
        Dictpl.new(word).translate
      else 'There\'s no such dictionary.'
      end
    end
    
    def available_services
      ['wiktionary', 'dictpl']
    end
  end
end
