# -*- coding: utf-8 -*-

require 'dict/wiktionary'
require "yaml"

module Dict
  class << self
    # Returns hash with structure as showed below
    # { 'DICTIONARY_NAME' => { 'TRANSLATION' => ['EXAMPLE', ...], ... }, ... }
    def get_all_dictionaries_translations(word)
      dictionaries = Hash.new

      available_dictionaries.each do |dictionary|
        dictionaries[dictionary] = get_single_dictionary_translations(word, dictionary)
      end
      dictionaries
    end

    # Prints translations from all dictionaries.
    def print_all_dictionaries_translations(word)
      available_dictionaries.each do |dictionary|
        print_single_dictionary_translations(word, dictionary)
      end
    end

    # Returns hash with structure as showed below
    # { 'TRANSLATION' => ['EXAMPLE', ...], ... }
    def get_single_dictionary_translations(word, dictionary)
      case dictionary
      when 'wiktionary'
        Wiktionary.new(word).translate.translations
      else Dictionary.message
      end
    rescue Dictionary::ConnectError
      "Couldn't connect to the dictionary."
    end

    # Prints translations from single dictionary.
    def print_single_dictionary_translations(word, dictionary)
      puts "Word '#{word.upcase}' translations from #{dictionary.upcase} dictionary."
      puts get_single_dictionary_translations(word, dictionary).to_yaml
    end

    # Returns array of currently available dictionaries.
    def available_dictionaries
      ['wiktionary']
    end
  end
end
