# -*- coding: utf-8 -*-

require 'dict/wiktionary'
require 'dict/dictpl'
require "yaml"

module Dict
  class << self
    # returns hash of every dictionary as keys and a hash of translations and examples as values
    def get_all_dictionaries_translations(word)
      dictionaries = Hash.new

      available_services.each do |service|
        dictionaries[service] = get_single_dictionary_translations(word, service)
      end
      dictionaries
    end

    # prints translations from all dictionaries
    def print_all_dictionaries_translations(word)
      available_services.each do |service|
        print_single_dictionary_translations(word, service)
      end
    end

    # returns hash with translations as keys and examples as values
    def get_single_dictionary_translations(word, service)
      case service
      when 'wiktionary'
        Wiktionary.new(word).translate
      when 'dictpl'
        Dictpl.new(word).translate
      else Dictionary.message
      end
    rescue Dictionary::ConnectError
      "Couldn't connect to the service."
    end

    # prints translations from single dictionary
    def print_single_dictionary_translations(word, service)
      puts "Word '#{word.upcase}' translations from #{service.upcase} dictionary."
      puts get_single_dictionary_translations(word, service).to_yaml
    end

    # returns array of currently avaiable dictionaries
    def available_services
      ['wiktionary', 'dictpl']
    end
  end
end
