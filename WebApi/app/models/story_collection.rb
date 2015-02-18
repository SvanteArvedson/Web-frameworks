class StoryCollection
  attr_accessor :stories
  
  def initialize(stories)
    @stories = stories
  end
  
  def length
    return @stories.length
  end
  
  def presentation
    pres = []
    @stories.each do |story|
      pres << story.presentation
    end
    return pres
  end
  
end