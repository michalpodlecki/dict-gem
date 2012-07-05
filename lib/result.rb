class Result
  attr_accessor :term, :dictionaries, :translations, :examples
  def initialize(term,dictionaries = nil)
    @term = term
    @dictionaries = dictionaries
    @translations, @examples = {}, {}
  end
  
  def add_translation(term, translation)
    if @translations[term]
      @translations[term].push(translation)
    else
      @translations[term] = [translation]
    end
    
    self
  end
  
  def add_example(term, example)
    if @examples[term]
      @examples[term].push(example)
    else
      @examples[term] = [example]
    end
    self
  end
  
  def each_translation
    @translations.each_pair do |term,translation|
      yield term,translation
    end
  end
end
