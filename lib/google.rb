require 'net/https'
require 'uri'
require 'json'

API_KEY = 'AIzaSyB2EQUnNtZycF_xyoyOSm0QJU0dfMGEr44'

class GoogleTranslator
  def initialize(uri)
    @uri = URI(uri)
    @req = Net::HTTP::Get.new(@uri.path << "?" << @uri.query)
    Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
      p JSON.parse(http.request(@req).body)
    end
  end
end

word = ARGV[0]

GoogleTranslator.new("https://www.googleapis.com/language/translate/v2?key=#{API_KEY}&q=#{word}&source=pl&target=en")
