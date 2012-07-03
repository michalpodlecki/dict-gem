require 'uri'
require 'net/http'

module TranslationRequest
  class Translation
    def getWord
      if ARGV.empty?
        raise "Please enter the word."
      else
        ARGV[0]
      end
    end

    def status(adres)
      uri = URI(adres)
      res = Net::HTTP.get_response(uri)
      puts res.message  
    end

    def getResponse(word)
      uri = URI("http://dict-app-staging.shellyapp.com/")
      print Net::HTTP.new(uri)
    end

  end
end
