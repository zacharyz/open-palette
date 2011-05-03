module ApplicationHelper
  def title
    base_title = 'Open Palette'
    unless @title
      base_title
    else
      "#{base_title} | #{@title}" 
    end   
  end
end
