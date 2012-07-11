# -*- coding: utf-8 -*-

require_relative 'wiktionary'
require_relative 'dictpl'
require 'json'

module Dict
  class << self
    def get_all_dictionaries_translations(word)
      dictionaries = Hash.new

      available_services.each do |service|
        dictionaries[service] = get_single_dictionary_translations(word, service)
      end
      dictionaries
    end

    def print_all_dictionaries_translations(word)
    end

    def get_single_dictionary_translations(word, service)
      case service
      when 'wiktionary'
        Wiktionary.new(word, WIKI_URL).translate
      when 'dictpl'
        Dictpl.new(word, DICT_URL).translate
      else Dictionary.message
      end
    rescue Dictionary::ConnectError
      "Couldn't connect to the service."
    end

    def print_single_dictionary_translations(word, service)
      obj = get_single_dictionary_translations(word, service)
      hash = obj.translate
      hash.each do |k, v|
        puts "#{k} - #{v}"
      end
    end

    def to_json(hash)
      hash.to_json
    end

    def available_services
      ['wiktionary', 'dictpl']
    end
  end
end
