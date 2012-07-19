# -*- encoding: utf-8 -*

require_relative './vcr_setup'
require 'dict/glosbe'

describe Dict::Glosbe do

  it "should raise no given word exception" do
    expect { Dict::Glosbe.new }.to raise_error ArgumentError
  end

  it "should return a Result object" do
    VCR.use_cassette('glosbe_translations_woda_cassette') do
      g = Dict::Glosbe.new('woda').translate
      g.should be_a(Dict::Result)
    end
  end

  it "should return translations of polish word 'woda' to english with its examples" do
    VCR.use_cassette('glosbe_translations_woda_cassette') do
      g = Dict::Glosbe.new('woda').translate
      g.translations.should == {"woda"=>["water", "aqua"]}
      g.examples.should == {"woda"=>["Details of food and water quality", "Mineral waters, soft drinks and juices (nd", "Fishing for herring in area iia (ec waters", "Bind him, cast him into the slop- pool at low tide!"]}
    end
  end

  it "should return translations of english word 'atomic' to polish with its examples" do
    VCR.use_cassette('glosbe_translations_atomic_cassette') do
      g = Dict::Glosbe.new('atomic').translate
      g.translations.should == {"atomic"=>["atomowy", "niepodzielny", "atomistyczny", "jednolity"]}
      g.examples.should == {"atomic"=>["Spektrofotometr absorpcji atomowej", "Atom w lewo", "Pomiary metodą absorpcji atomowej"]}
    end
  end
 end
