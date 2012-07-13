module Dict
  class Result
    attr_accessor :term, :translations, :examples
    def initialize(term)
      @term = term
      @translations = {}
      @examples = {}
    end
    
    def add_translation(term, translation)
      add_result(@translations, term, translation)
    end
    
    def add_example(term, example)
      add_result(@examples, term, example)
    end
    
    def each_translation
      @translations.each_pair do |term,translation|
        yield term, translation
      end
    end

    def to_s
      "#{@term}\n#{@dictionaries}\n#{@translations}\n#{@examples}\n"
    end
    
    private
    def add_result(hash, key, value)
      if hash.has_key?(key)
        hash[key].push(value)
      else
        hash.merge!({ key => [value] })
      end
      self
    end
  end
end
