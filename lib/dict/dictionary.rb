# -*- coding: utf-8 -*-

# It is a base class for classes fetching results from Web dictionaries.

require 'open-uri'
require 'dict/result'

module Dict
  class Dictionary

    def initialize(word)
      check_arguments(word)
      @word = downcase_word(word)
      @result = Dict::Result.new(@word)
    end
    
    # Returns an instance of URI::HTTP class.
    def uri(url, word = nil)
      word == nil ? URI(URI.escape(url)) : URI(URI.escape(url + word.downcase.tr(' ', '_')))
    end

    # Checks if word was given correctly.
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
    
    private
    # Returns a word with all downcased letters, including polish
    def downcase_word(word)
      word.downcase.gsub(/[ĄĆĘŁŃÓŚŹŻ]/, 'Ą' => 'ą', 'Ć' => 'ć', 'Ę' => 'ę', 'Ł' => 'ł', 'Ń' => 'ń', 'Ó' => 'ó', 'Ś' => 'ś', 'Ź' => 'ź', 'Ż' => 'ż')
    end
  end
end
