# -*- coding: utf-8 -*-

require 'open-uri'

module Dict
  class Dictionary
    attr_accessor :translations, :examples
    def initialize(word)
      check_arguments(word)
      @translations = []
      @examples = []
      @word = word
    end

    # returns hash with translations as keys and examples as values
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
    
    # returns uri of the dictionary
    def get_uri(url, word = nil)
      word == nil ? URI(URI.escape(url)) : URI(URI.escape(url + word.downcase.tr(' ', '_')))
    end

    # checks if word was given correctly
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
end
