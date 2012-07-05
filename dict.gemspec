Gem::Specification.new do |s|
  s.add_runtime_dependency 'slop'
  s.name = %q{dict}
  s.version = "0.0.6"
  s.authors = ['Aleksander Gozdek', 'Mateusz Czerwinski']
  s.email = ['mtczerwinski@gmail.com']
  s.date = %q{2012-07-05}
  s.summary = %q{Gem made for dictionary application}
  s.files = [
    "lib/dict.rb",
    "lib/google.rb",
    "lib/wiktionary.rb",
    "lib/dictpl.rb"
  ]
  s.require_paths = ["lib"]
  s.executable = 'translate'
  s.description = <<-END
    Dict is a client of API which you lets you use multiple dictionaries.
    Dict is an open source project.
  END
  s.homepage = 'https://github.com/Ragnarson/dict-gem'
  s.add_dependency 'nokogiri'
end
