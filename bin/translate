#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'dict'
require 'slop'

if ARGV.empty? then puts "Please enter the word. (-h for help)" ; exit end

opts = Slop.parse do 
  banner "Usage: $translate -w word [Options]"
  on '-w', :word=, 'after this option is a word to translate'
  on '-h', :help=, 'help', :argument => :optional
  on '-s', :services=, 'available services', :argument => :optional
  #on '-t', :time=, 'time in seconds, default: 300 seconds', :as => :int
  on '-d', :dict=, 'dictionaries: wiktionary, dictpl; default is all dictionaries'
end

# translation
if opts.word?
  if opts.dict?
    puts Dict.get_single_dictionary_translations(opts[:word],opts[:dict])
  else
    puts Dict.get_all_dictionaries_translations(opts[:word])
  end
end

# help
puts opts if opts.help?

# services
puts Dict.available_services if opts.services?


