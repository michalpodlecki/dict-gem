# -*- coding: utf-8 -*-

require 'dict/dict'
require 'slop'
require 'timeout'

module Dict
  module CLI
    class Runner
      def parameters_valid?
        not ARGV.empty?
      end

      def parse_parameters
        available_dictionaries = Dict.available_services.join(', ')

        opts = Slop.parse! do
          banner <<-END
    Usage: dict WORD [OPTIONS]
    Search WORD in dict, an open source dictionary aggregator.
          END

          on '-h', :help, 'Display this help message'
          on '-t', :time=, 'Set timeout in seconds. Default: 300', :as => :int
          on '-d', :dict=, "Select desired dictionary. Available options: #{available_dictionaries}"
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

      def run(opts)
        begin
          opts = parse_parameters
        rescue Slop::MissingArgumentError
          abort("Missing argument")
        end

        abort(opts.to_s) if opts.help?
        abort("Please enter a word. (-h for help)") unless parameters_valid?

        puts get_translations(opts, ARGV[0])
      end
    end
  end
end

