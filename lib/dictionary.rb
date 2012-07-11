# -*- coding: utf-8 -*-

require 'open-uri'

class Dictionary
  attr_accessor :translations, :examples
  def initialize(word, url)
    check_arguments(word)
    @translations = []
    @examples = []
    @uri = URI(URI.escape(url + word.downcase.tr(' ', '_')))
  end

  def make_hash_results(arr)
    hash = arr.each_slice(2).inject({}) do |h, (key, value)|
      if h.has_key?(key)
        h[key].push(value) ; h
      else
        h[key] = [value] ; h
      end
    end
    @translations, @examples = hash.keys, hash.values
    hash
  end

  def check_arguments(word)
    raise ArgumentError.new("No given word") if word.empty?
  end

  def self.message
    'There\'s no such dictionary in database.'
  end

  class ConnectError < Exception
    attr_reader :original
    def initialize(original = $!)
      @original = original
    end
  end
end
