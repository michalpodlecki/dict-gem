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

=begin
# problem with situation where first word after
# translate is --help or -h ...
unless ARGV[0].nil?
  puts Dict::Translation.get_response(ARGV[0])
end

unless opts[:time].nil?
  puts Dict::Translation.get_response(ARGV[0],opts[:time])
end

unless opts[:dict].nil?
  # todo: refactor get_response because it has not a dict
  # parameter
end
=end
puts opts if opts[:help]
puts Dict::Translation.status unless opts[:status].nil?
