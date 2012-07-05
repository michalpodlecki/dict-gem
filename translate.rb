#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'dict'
require 'slop'

if ARGV.empty? then puts "Please enter the word. (-h for help)" ; exit end

opts = Slop.parse do 
  banner "Usage: $translate -w word [Options]"
  on '-w', '--word', 'after this option is a word to translate'
  on '-h', '--help', 'help'
  on '-t', '--time', 'time in seconds', :as => :int
  on '-d', '--dict', 'dictonaries: all, wiki etc.'
  on '-s', '--status', 'status of API'
end

puts opts.to_hash



puts opts if opts[:help]
puts "Status API: " << Dict::Translation.status unless opts[:status].nil?
