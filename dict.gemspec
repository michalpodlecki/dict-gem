Gem::Specification.new do |s|
  s.add_runtime_dependency 'slop', '~> 3.3.2'
  s.add_dependency 'nokogiri', '~>1.5.5'
  s.name = %q{dict}
  s.version = "0.1.0"
  s.authors = ['Aleksander Gozdek', 'Mateusz Czerwinski', 'Michał Podlecki','Rafał Ośko']
  s.email = ['mtczerwinski@gmail.com']
  s.date = %q{2012-07-06}
  s.summary = %q{Gem made for dictionary application}
  s.files = [
    "lib/dict.rb",
    "lib/result.rb",
    "lib/wiktionary.rb",
    "lib/dictpl.rb",
  ]
  s.require_paths = ["lib"]
  s.executable = 'translate'
  s.description = <<-END
    Dict is a client of API which you lets you use multiple dictionaries.
    Dict is an open source project.
  END
  s.homepage = 'https://github.com/Ragnarson/dict-gem'

end
