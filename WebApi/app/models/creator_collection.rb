class CreatorCollection
  attr_accessor :creators
  
  def initialize(creators)
    @creators = creators
  end
  
  def length
    return @creators.length
  end
  
  def presentation
    pres = []
    @creators.each do |creator|
      pres << creator.presentation
    end
    return pres
  end
  
end