class StoryCollection
  attr_accessor :stories
  
  def initialize(stories)
    @stories = stories
  end
  
  def get_length
    return @stories.length
  end
  
  def get_presentation
    pres = []
    @stories.each do |story|
      pres << story.get_presentation
    end
    return pres
  end
  
end