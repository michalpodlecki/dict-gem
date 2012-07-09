#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'dict'
require 'slop'
require 'timeout'

def check_parameters
  if ARGV.empty?
    puts "Please enter the word. (-h for help)"
    exit
  end
end

def parse_parameters
  begin
    opts = Slop.parse do 
      banner "Usage: $translate -w word [Options]"
      on '-w', :word=, 'after this option is a word to translate'
      on '-h', :help=, 'help', :argument => :optional
      on '-t', :time=, 'time in seconds, default: 300', :as => :int
      on '-d', :dict=, 'wiktionary, dictpl', :argument => :optional
    end
    
  rescue Slop::MissingArgumentError
    puts "Missing argument"
    exit
  end
  opts
end

def get_translations(opts)
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
  else
    nil
  end
end

check_parameters
opts = parse_parameters
puts get_translations(opts)

begin
  puts opts if opts.help?
  puts Dict.available_services if opts.dict?
rescue
  nil
end
