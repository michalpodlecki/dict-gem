require 'net/http' # requires 'uri'

class Wiktionary
	WIKI_URL = "http://en.wiktionary.org/wiki/" # #{word}
	def initialize(word)
		if word.empty? then puts "No word given."; exit end
		@word = word
		@uri = URI(URI.escape(WIKI_URL << @word))
	end
	
	def translate
		req = Net::HTTP::Get.new(@uri.path)
		response, array = nil, []
		Net::HTTP.start(@uri.host, @uri.port) do |http|
			response = http.request(req).body
			regexp = Regexp.new('<li>[^<]*<a href="/wiki/([^"]+)"\s+title="\1">\1<\/a>', Regexp::IGNORECASE)
			results = regexp.match(response)
			
			return array if !results # no translation found
			
			array.push results[1]
		end
	end
	
	def uri_debug
		puts "--- DEBUG start ---"
		puts "uri:\t\t" << @uri.to_s
		puts "scheme:\t\t" << @uri.scheme
		puts "host:\t\t" << @uri.host
		puts "query:\t\t" << @uri.query if @uri.query
		puts "path:\t\t" << @uri.path if @uri.path
		puts "fragment:\t" << @uri.fragment if @uri.fragment
		puts "--- DEBUG end ---"
	end
end

word = ARGV[0]
word ||= ''
translation = Wiktionary.new word
puts translation.translate.to_s
