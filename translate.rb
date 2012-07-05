#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'dict'
require 'slop'

if ARGV.empty? then puts "Please enter the word. (-h for help)" ; exit end

opts = Slop.parse do 
  banner "Usage: $translate -w word [Options]"
  on '-w', :word=, 'after this option is a word to translate'
  on '-h', :help=, 'help', :argument => :optional
  on '-t', :time=, 'time in seconds, default: 300 seconds', :as => :int
  on '-d', :dict=, 'dictionaries: all, wiki etc., default is all dictionaries'
  on '-s', :status=, 'status of API', :argument => :optional
end

# translation
puts Dict::Translation.get_response(opts[:word], opts[:time] || 300, opts[:dict] || "all") if opts.word?

# help
puts opts if opts.help?

# status
puts Dict::Translation.status if opts.status?
