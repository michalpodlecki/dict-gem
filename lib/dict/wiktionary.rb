# -*- coding: utf-8 -*-

# Class fetching translations of given word from wiktionary.org.

require 'nokogiri'
require 'dict/dictionary'

module Dict
  class Wiktionary < Dictionary

    # Returns an Dict::Result object.
	  def translate
      translations.each { |item| @result.add_translation(@result.term, item) }

      @result
    end

    def get_html(url)
      Nokogiri::HTML(open(URI.encode(url)))
    rescue OpenURI::HTTPError
      raise Dictionary::ConnectError
    end

    private
    def polish?(content)
      ! /==Polish==/i.match(content).nil?
    end

    # Returns an array containing translations.
    def translations
      url_pl = "http://en.wiktionary.org/w/index.php?title=#{@word}&action=edit"
      url_en = "http://pl.wiktionary.org/w/index.php?title=#{@word}&action=edit"

      content_pl = get_html(url_pl).css('textarea#wpTextbox1').first
      if polish?(content_pl)
        extract_polish_translations(content_pl)
      else
        extract_english_translations(get_html(url_en).css('textarea#wpTextbox1').first.content)
      end
    end

    # Returns an array containing polish translations.
    def extract_polish_translations(content)
      translations = /Noun[^\{]+\{\{(?:head\|pl|pl\-noun)[^#]+#\s*\[\[([^\n]+)/.match(content)
      translations = (translations && translations[1].gsub(/\[|\]/,'').split(', ')) || []
    end

    # Returns an array containing english translations.
    def extract_english_translations(content)
      translations_block = /język\s+angielski(?:.|\n)+\{\{znaczenia\}\}(.|\n)+(?:\{\{odmiana){1,}/.match(content)
      return [] unless translations_block.instance_of?(MatchData)
      translations_block = translations_block[0].gsub(/odmiana(.|\n)+$/,'')
      translations = translations_block.scan(/:\s*\(\d\.?\d?\)\s*([^\n]+)/)
      translations.map! do |translation|
        translation[0].gsub(/\[|\]|\{\{[^\}]+\}\}|'|<.*/,'').strip
      end
      translations.delete_if(&:empty?)
      translations ||= []
    end

    def get_examples(content, polish = true)
      # todo
    end
  end
end
