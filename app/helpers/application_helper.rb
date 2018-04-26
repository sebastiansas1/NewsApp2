module ApplicationHelper
  def glyph(icon_name_postfix, hash = {})
    content_tag :i, nil, hash.merge(class: "glyphicon glyphicon-#{icon_name_postfix.to_s.tr('_', '-')}")
  end

  def cp(path)
    if params[:category].blank? && params[:topic].blank?
    'active' if current_page?(path) 
    elsif params[:category] == "Top Trending"  
      'active' if current_page?(path)
    end
  end
end
