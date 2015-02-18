class TagCollection
  attr_accessor :rags
  
  def initialize(tags)
    @tags = tags
  end
  
  def length
    return @tags.length
  end
  
  def presentation
    pres = []
    @tags.each do |tag|
      pres << tag.presentation
    end
    return pres
  end
  
end