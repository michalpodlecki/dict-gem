#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'dict'
require 'slop'
require 'timeout'

if ARGV.empty?
  puts "Please enter the word. (-h for help)"
  exit
end

begin
  opts = Slop.parse do 
    banner "Usage: $translate -w word [Options]"
    on '-w', :word=, 'after this option is a word to translate'
    on '-h', :help=, 'help', :argument => :optional
    on '-t', :time=, 'time in seconds, default: 300', :as => :int
    on '-d', :dict=, 'wiktionary, dictpl', :argument => :optional
  end
  
rescue 
  puts "Missing argument"
  exit
end


if opts.word?
  begin
    Timeout::timeout(opts[:time].to_i || 300) do
      if opts.dict? && opts[:dict] != nil
        puts Dict.get_single_dictionary_translations(opts[:word],opts[:dict])
      else
        puts Dict.get_all_dictionaries_translations(opts[:word])
      end
    end
    
    rescue 
      puts "Timeout for the query."
  end
end

# help
puts opts if opts.help?

# available dictionaries
puts Dict.available_services if opts.dict?

