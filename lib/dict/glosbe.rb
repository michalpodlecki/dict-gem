# -*- coding: utf-8 -*-

require 'nokogiri'
require 'dict/dictionary'

GLOSBE_PL = 'http://glosbe.com/pl/en/' # polish - english
GLOSBE_EN = 'http://glosbe.com/en/pl/' # english - polish

module Dict
  class Glosbe < Dictionary
    # returns an Dict::Result object 
    def translate
        if is_polish?(doc = get_content(GLOSBE_PL, @word))
          add_translations(get_translations(doc))
          add_examples(get_examples(doc, 'en'))
        else
          doc = get_content(GLOSBE_EN, @word) 
          add_translations(get_translations(doc))
          add_examples(get_examples(doc, 'pl'))
        end

        @result
    end

    private

    # checks if given word is polish
    def is_polish?(doc)
      !doc.empty? && doc.at_css('.content_box_rounded p').nil?
    end

    # returns instance of Nokogiri::HTML module
    def get_content(url, word)
      begin
        Nokogiri::HTML(open(uri(url, word))).css('.wordDetails')
      rescue => e
        ""
      end
    end

    # returns array with structure as shown below from the given dictionary link
    # ['TRANSLATION1', 'TRANSLATION2', ...]
    def get_translations(doc)
      translations = []
      doc.css('.phrase-container > .translation').each { |translation| translations.push(translation.text.downcase) } if !doc.empty?
      translations
    end

    # add obtained translations to Dict::Result object
    def add_translations(translations)
      translations.each { |translation| @result.add_translation(@result.term, translation) }
    end

    # returns array with structure as shown below from the given dictionary link
    # ['EXAMPLE1', 'EXAMPLE2', ...]
    # the default length of given example is 60 characters
    def get_examples(doc, lang, length = 60)
      examples = []
      doc.css(".tranlastionMemory td[lang=#{lang}]").each { |example| examples.push(example.text.capitalize) if example.text.length < length } if !doc.empty?
      examples
    end

    # add obtained examples to Dict::Result object
    def add_examples(examples)
      examples.each { |example| @result.add_example(@result.term, example) }
    end
  end
end
