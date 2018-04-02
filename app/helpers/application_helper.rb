module ApplicationHelper
    def glyph(icon_name_postfix, hash={})
        content_tag :i, nil, hash.merge(class: "glyphicon glyphicon-#{icon_name_postfix.to_s.gsub('_','-')}")
    end
end
