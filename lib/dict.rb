require 'uri'
require 'net/http'

module Dict
  class Translation
    def initialize(word)
        @word = ARGV[0]
    end
    
    def self.status(adres = "http://dict-app-staging.shellyapp.com/")
      uri = URI(adres)
      res = Net::HTTP.get_response(uri)
      puts res.message
    end

    def self.getResponse(word)
      uri = URI("http://dict-app-staging.shellyapp.com/#{word}")
      puts Net::HTTP.get(uri)
    end
  end
end

