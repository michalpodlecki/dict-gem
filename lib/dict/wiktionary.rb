# -*- coding: utf-8 -*-

require 'nokogiri'
require_relative 'dictionary'

WIKI_URL = 'http://en.wiktionary.org/wiki/'

module Dict
  class Wiktionary < Dictionary
    # Return a Dict::Result object
	  def translate
      url_pl = "http://en.wiktionary.org/w/index.php?title=#{@word}&action=edit"
      url_en = "http://pl.wiktionary.org/w/index.php?title=#{@word}&action=edit"
      
      if polish?(get_html(url_pl).css('textarea#wpTextbox1').first)
        get_translations(get_html(url_pl).css('textarea#wpTextbox1').first)
      else
        get_translations(get_html(url_en).css('textarea#wpTextbox1').first.content, false)
      end
      
      @result
    end 
    
    def get_html(url)
      Nokogiri::HTML(open(URI.encode(url)))
    rescue OpenURI::HTTPError
      raise Dictionary::ConnectError
    end
    
    private
    def polish?(content)
       return true if /==Polish==/i.match(content)
       false
    end

    def get_translations(content, polish = true)
      if polish
        translations = /Noun[^\{]+\{\{(?:head\|pl|pl\-noun)[^#]+#\s*\[\[([^\n]+)/.match(content)
        translations = (translations && translations[1].gsub(/\[|\]/,'').split(', ')) || []
        translations.each { |item| @result.add_translation(@result.term, item) }
      else
        translations_block = /angielski(?:.|\n)+\{\{znaczenia\}\}(.|\n)+(?:\{\{odmiana){1,}/.match(content)
        translations_block = translations_block[0].gsub(/odmiana(.|\n)+$/,'')
        translations = translations_block.scan(/:\s*\(\d\.?\d?\)\s*([^\n]+)/)
        translations.map! do |translation|
          translation[0].gsub(/\[|\]|\{\{[^\}]+\}\}|'/,'').strip
        end
        translations.delete_if do |item|
          item.empty?
        end
        translations ||= []
        translations.each { |item| @result.add_translation(@result.term, item) }
      end
    end
    
    def get_examples(content, polish = true)
      # todo
    end
  end
end
