# Title: Jekyll Solidity Exercise Adapter
# Authors: Thibault Meunier : @thibmeu
#
# Description: Convert Solidity contracts into live exercises
#
# Syntax:  {% exercise %} {% endexercise %}
#
# See the documentation for usage instructions.

module Jekyll
  class RenderTimeTagBlock < Liquid::Block

    def render(context)
      text = super
      "<p>#{text}</p>"
    end

  end
end

Liquid::Template.register_tag('exercise', Jekyll::RenderTimeTagBlock)
Liquid::Template.register_tag('initial', Liquid::Tag)
Liquid::Template.register_tag('solution', Liquid::Tag)
Liquid::Template.register_tag('validation', Liquid::Tag)
Liquid::Template.register_tag('hints', Liquid::Tag)
