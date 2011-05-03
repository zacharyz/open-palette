module ApplicationHelper
  def title
    base_title = 'Open Palette'
    unless @title
      base_title
    else
      @title
    end   
  end
end
