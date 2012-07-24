# -*- coding: utf-8 -*-

# Class, which provides using application in Command Line Interface.

require 'dict/dict'
require 'dict/version'
require 'slop'
require 'timeout'

module Dict
  module CLI
    class Runner

      def parameters_valid?
        not ARGV.empty?
      end

      def parse_parameters
        opts = Slop.parse! do
          banner <<-END
Usage: dict WORD [OPTIONS]
Search WORD in dict, an open source dictionary aggregator.
          END

          on '-h', :help=, 'Display this help message', :argument => :optional
          on '-t', :time=, 'Set timeout in seconds. Default: 300', :as => :int
          on '-d', :dict=, "Select desired dictionary. Available options: #{Dict.available_dictionaries.join(', ')}"
          on '-v', :version=, "Information about gem, authors, license", :argument => :optional
          on '-c', :clean=, "Remove examples from translation", :argument => :optional
          
        end
      end

      def get_translations(opts, word)
         Timeout::timeout(opts[:time].to_i || 300) do
          if opts.dict?
            Dict.get_single_dictionary_translations(word, opts[:dict])
          else
            Dict.get_all_dictionaries_translations(word)
          end
        end
      rescue Timeout::Error
        "Timeout for the query."
      end

      def expected_argument_description(option)
        case option
        when "dict"
          Dict.available_dictionaries.join(', ')
        when "time"
          "number of seconds"
        else
          "?"
        end
      end

      MSG = "Usage: dict WORD [OPTIONS]\nTry `dict --help for more information.\n"
      VERSION = "dict version #{Dict::VERSION}\nSearch WORD in dict, an open source dictionary aggregator.\nCopyright (C) 2012 by\nTrainees:\n  Jan Borwin\n  Mateusz Czerwiński\n  Kosma Dunikowski\n  Aleksander Gozdek\n  Rafał Ośko\n  Michał Podlecki\nMentors:\n  Grzegorz Kołodziejski\n  Michał Kwiatkowski\nLicense: MIT\nMade during intership at Ragnarson : http://ragnarson.com/\nHosted by Shelly Cloud : http://shellycloud.com/\nHomepage: http://github.com/Ragnarson/dict-gem/\nSources of dictionaries: http://wiktionary.org/\n                         http://glosbe.com/\n" 

      # Returns only translations of the given word, without example sentences.
      def clean_translation(opts, word)
        translation = get_translations(opts, word)
        string = String.new
        string += word + " : "
        if opts.dict?
          translation[word].each { |x| string << x << ", " }
        else
          begin
            Dict.available_dictionaries.each do |x|
              translation[x][word].each { |y| string << y << ", " }
            end
          rescue NoMethodError
            return "No translation found."
          end
          
        end
        2.times { string.chop! }
        string
      end
      
      # Prints translations from all dictionaries
      def print_all_dictionaries_translations(results)
        results.each do |dictionary, translations_hash|
          puts "Dictionary name - #{dictionary.upcase}"
          print_single_dictionary_translations(translations_hash)
        end
      end

      # Prints single dictionary translations
      def print_single_dictionary_translations(translations_hash)
        if translations_hash.empty? || translations_hash.class == String
          puts "We are sorry but given dictionary couldn't find any translations."
        else
          translations_hash.each { |word, translations| puts "Translations for given word: #{word.upcase}\n#{translations.join(', ')}" }
        end
      end
     
      def run
        begin
          opts = parse_parameters
        rescue Slop::MissingArgumentError => e
          incomplete_option = /(.*?) expects an argument/.match(e.to_s)[1]
          description = expected_argument_description(incomplete_option)
          abort("Missing argument. Expected: #{description}")
        end
            
        if opts.help?
          abort(opts.to_s)
        elsif opts.version?
          abort(VERSION)
        elsif opts.time?
          if (opts[:time].to_i) == 0
            abort("Wrong time value.")
          else
            print_all_dictionaries_translations(get_translations(opts, ARGV[0]))
          end
        else
          if !parameters_valid?
            abort(MSG)
          else
            if opts.clean?
              puts clean_translation(opts, ARGV[0])
            else
              if opts.dict?
                print_single_dictionary_translations(get_translations(opts, ARGV[0]))
              else 
                print_all_dictionaries_translations(get_translations(opts, ARGV[0]))
              end
            end
          end
        end
      end
    end
  end
end
