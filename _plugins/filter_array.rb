module Jekyll
  module ArrayFilter
    def pages_only(input)
      input.select{|i| i.url[/^\/pages/]}
    end
  end
end

Liquid::Template.register_filter(Jekyll::ArrayFilter)
