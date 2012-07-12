$:.push File.expand_path("../lib", __FILE__)
require "dict/version"

Gem::Specification.new do |s|
  s.add_dependency 'slop', '~> 3.3.2'
  s.add_dependency 'nokogiri', '~>1.5.5'
  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "rake"
  s.add_development_dependency "vcr"
  s.add_development_dependency "activesupport"
  s.add_development_dependency "fakeweb"

  s.name = %q{dict}
  s.version = Dict::VERSION
  s.authors = ['Aleksander Gozdek', 'Mateusz Czerwinski', 'Michał Podlecki','Rafał Ośko']
  s.email = ['mtczerwinski@gmail.com']
  s.date = Time.now.strftime('%Y-%m-%d')
  s.summary = %q{Gem made for dictionary application}
  s.description = <<-END
    Dict is an open source dictionary aggregator.
  END
  s.homepage = 'https://github.com/Ragnarson/dict-gem'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
