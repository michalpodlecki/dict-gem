# -*- coding: utf-8 -*-

require 'dict'
require 'slop'
require 'timeout'

module Main
  def self.check_parameters?
    ARGV.empty?
  end

  def self.parse_parameters
    opts = Slop.parse do 
      banner "Usage: $translate -w word [Options]"
      on '-w', :word=, 'after this option is a word to translate'
      on '-h', :help=, 'help', :argument => :optional
      on '-t', :time=, 'time in seconds, default: 300', :as => :int
      on '-d', :dict=, 'wiktionary, dictpl', :argument => :optional
    end
  end
  
  def self.get_translations(opts)

      if opts.word?
        begin
          Timeout::timeout(opts[:time].to_i || 300) do
            if opts.dict? && opts[:dict] != nil
              Dict.get_single_dictionary_translations(opts[:word],opts[:dict])
            else
              Dict.get_all_dictionaries_translations(opts[:word])
            end
          end
          
        rescue 
          "Timeout for the query."
        end
      end

  end
  
  def self.main(opts)

    if check_parameters? == true
      puts "Please enter the word. (-h for help)"
      exit
    end
    
    begin
      opts = parse_parameters
    rescue Slop::MissingArgumentError
      puts "Missing argument"
      exit
    end

    puts get_translations(opts)
    
    begin
      puts opts if opts.help?
      puts Dict.available_services if opts.dict?
    rescue
      nil
    end
  end
  
end

