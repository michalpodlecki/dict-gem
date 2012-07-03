#!/usr/bin/env ruby

require 'dict'

if ARGV.empty?
  puts "Please, enter the word to translate."
  exit
end

temp = ARGV[0].dup

print temp << " translated: " << "\n"
puts Dict::Translation.getResponse(ARGV[0])
print "Status API: "
print Dict::Translation.status
