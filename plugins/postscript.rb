# Author: rcmdnk
# rcmdnk (https://github.com/rcmdnk/octopress-ps)

module Jekyll
  class Postscript < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @date = markup == ""? "" : ": #{markup}"
      super
    end

    def render(context)
      output = super
      config = context.registers[:site].config
      title = (config['ps_title'] ? config['ps_title']:"P.S.") + "#{@date}"
      close = config['ps_close'] ? config['ps_close'] : ""
      %(\n<div class="postscript" markdown="block"><strong>#{title}</strong>\n\n#{output}\n\n<strong>#{close}</strong>\n</div>\n)
    end
  end
end

Liquid::Template.register_tag('ps', Jekyll::Postscript)
Liquid::Template.register_tag('postscript', Jekyll::Postscript)
