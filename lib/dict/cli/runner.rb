# -*- coding: utf-8 -*-

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
        end
        opts
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
      VERSION = "dict version #{Dict::VERSION} \nCopyright (C) 2012 by Mateusz Czerwiński, Michał Podlecki,\nAleksander Gozdek, Rafał Ośko, Jan Borwin, Kosma Dunikowski\nLicense: MIT\nHomepage: https://github.com/Ragnarson/dict-gem\nSearch WORD in dict, an open source dictionary aggregator.\n" 

      
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
        else
          if !parameters_valid?
            abort(MSG)
          else
            if opts.time?
              if (opts[:time].to_i) == 0
                abort("Wrong time value.")
              else
                puts get_translations(opts, ARGV[0])
              end
            else
              puts get_translations(opts, ARGV[0])
            end
          end
        end

      end
    end
  end
end
