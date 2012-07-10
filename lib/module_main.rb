# -*- coding: utf-8 -*-

require 'dict'
require 'slop'
require 'timeout'

module Main
  def self.check_parameters?
    ARGV.empty?
  end

  def self.parse_parameters
    opts = Slop.parse! do 
      banner <<-END
Usage: dict WORD [OPTIONS]
Search WORD in dict, an open source dictionary aggregator.
      END
  
      on '-h', :help, 'display this help message', :argument => :optional
      on '-t', :time=, 'timeout in seconds, default: 300', :as => :int
      on '-d', :dict=, 'wiktionary|dictpl', :argument => :optional
    end
    opts
  end
  
  def self.get_translations(opts, word)
    Timeout::timeout(opts[:time].to_i || 300) do
      if opts.dict? && opts[:dict] != nil
        Dict.get_single_dictionary_translations(word, opts[:dict])
      else
        Dict.get_all_dictionaries_translations(word)
      end
    end
  rescue 
    "Timeout for the query."
  end
  
  def self.main(opts)
    begin
      opts = parse_parameters
    rescue Slop::MissingArgumentError
      puts "Missing argument"
      exit
    end

    if opts.help?
      puts opts
    elsif opts.dict? && !opts[:dict]
      puts Dict.available_services
    else
      if check_parameters? == true
        puts "Please enter a word. (-h for help)"
        exit
      end
      puts get_translations(opts, ARGV[0])
    end
  end
  
end

