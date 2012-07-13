# -*- coding: utf-8 -*

require_relative './vcr_setup'
require 'dict/cli/runner'

describe "parameters_valid?" do
  it "should return false if ARGV is empty" do
    stub_const("ARGV", [])
    runner = Dict::CLI::Runner.new
    runner.parameters_valid?.should == false
  end

  it "should return true if ARGV is not empty" do
    stub_const("ARGV", ["słowik", "-t", "36", "-d"])
    runner = Dict::CLI::Runner.new
    runner.parameters_valid?.should == true
  end
end

describe "parse_parameters" do
  it "should return Hash for parameters słowik -t 36" do
    stub_const("ARGV", ["słowik", "-t", "36"])
    runner = Dict::CLI::Runner.new
    opts = runner.parse_parameters
    {:help=>nil, :time=>"36", :dict=>nil}.should == opts.to_hash
  end

  it "should return Hash for parameters słowik" do
    stub_const("ARGV", ["słowik"])
    runner = Dict::CLI::Runner.new
    opts = runner.parse_parameters
    {:help=>nil, :time=>nil, :dict=>nil}.should == opts.to_hash
  end
end


describe "get_translations" do
  it "should return results from wiktionary and dictpl for word 'słowik'" do
    VCR.use_cassette('translations_slownik_cassette') do      
      stub_const("ARGV", ["słowik"])
      runner = Dict::CLI::Runner.new
      opts = runner.parse_parameters
      runner.get_translations(opts, "słowik").should == {"wiktionary"=>{"słowik"=>["nightingale"]}, "dictpl"=>{"słowik"=>["nightingale"], "słowik białobrewy; Luscinia indicus; Tarsiger indicus (gatunek ptaka)"=>["white-browed bush-robin"], "słowik białosterny; Luscinia pectoralis (gatunek ptaka)"=>["Himalayan rubythroat", "white-tailed rubythroat"], "słowik chiński; pekińczyk żółty; Leiothrix lutea"=>["Pekin robin", "red-billed leiothrix"], "słowik chiński; pekińczyk żółty; pekińczyk koralodzioby; Leiothrix lutea"=>["Peking robin"], "słowik czarnogardły; Luscinia obscura"=>["black-throated blue robin"], "słowik himalajski; Luscinia brunnea (gatunek ptaka)"=>["Indian blue chat", "Indian blue robin"], "słowik modry; Luscinia cyane"=>["Siberian blue robin"], "słowik obrożny; Luscinia johnstoniae; Tarsiger johnstoniae (gatunek ptaka)"=>["collared bush-robin"]}}
    end 
  end

  it "should return results from selected dictionary for word 'słowik'" do
    VCR.use_cassette('translations_slownik_cassette') do      
      stub_const("ARGV", ["słowik", "-d", "dictpl"])
      runner = Dict::CLI::Runner.new
      opts = runner.parse_parameters
      runner.get_translations(opts, "słowik").should == {"słowik"=>["nightingale"], "słowik białobrewy; Luscinia indicus; Tarsiger indicus (gatunek ptaka)"=>["white-browed bush-robin"], "słowik białosterny; Luscinia pectoralis (gatunek ptaka)"=>["Himalayan rubythroat", "white-tailed rubythroat"], "słowik chiński; pekińczyk żółty; Leiothrix lutea"=>["Pekin robin", "red-billed leiothrix"], "słowik chiński; pekińczyk żółty; pekińczyk koralodzioby; Leiothrix lutea"=>["Peking robin"], "słowik czarnogardły; Luscinia obscura"=>["black-throated blue robin"], "słowik himalajski; Luscinia brunnea (gatunek ptaka)"=>["Indian blue chat", "Indian blue robin"], "słowik modry; Luscinia cyane"=>["Siberian blue robin"], "słowik obrożny; Luscinia johnstoniae; Tarsiger johnstoniae (gatunek ptaka)"=>["collared bush-robin"]}
    end 
  end

  it "should return timeout message for word słowik and -t 5" do
    stub_const("ARGV", ["słowik","-t","5"])
    runner = Dict::CLI::Runner.new
    opts = runner.parse_parameters
    Dict.should_receive(:get_all_dictionaries_translations).
      and_return { sleep 20 }
    runner.get_translations(opts, "słowik").should == "Timeout for the query."
  end
end

describe "CLI::Runner" do
  HELP_MSG = "Usage: dict WORD [OPTIONS]\nSearch WORD in dict, an open source dictionary aggregator.\n\n    -h, --help      Display this help message\n    -t, --time      Set timeout in seconds. Default: 300\n    -d, --dict      Select desired dictionary. Available options: wiktionary, dictpl"
  DICT_MSG = "Missing argument. Expected: wiktionary, dictpl"
  TIME_MSG = "Missing argument. Expected: number of seconds"

  it "should call abort when program is called with -h" do
    stub_const("ARGV",["-h"])
    opts = Slop.new
    runner = Dict::CLI::Runner.new
    runner.should_receive(:abort).with(HELP_MSG).and_raise(SystemExit)
    expect {
      runner.run
    }.to raise_error(SystemExit)
  end

  it "should try to display meaningful information when -d option arguments are missing" do
    stub_const("ARGV",["-d"])
    runner = Dict::CLI::Runner.new
    runner.should_receive(:abort).with(DICT_MSG).and_raise(SystemExit)
    expect {
      runner.run
    }.to raise_error(SystemExit)
  end

  it "should try to display meaningful information when -t option arguments are missing" do
    stub_const("ARGV",["-t"])
    runner = Dict::CLI::Runner.new
    runner.should_receive(:abort).with(TIME_MSG).and_raise(SystemExit)
    expect {
      runner.run
    }.to raise_error(SystemExit)
  end
end
