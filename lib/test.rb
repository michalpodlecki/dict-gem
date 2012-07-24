# -*- coding: utf-8 -*-
require 'dict/wiktionary'

word = ARGV[0] || "samochód"

wiki = Dict::Wiktionary.new(word).translate

puts wiki.term
puts wiki.inspect
