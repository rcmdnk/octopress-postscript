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
      if config['ps_title']
        title = config['ps_title'] + "#{@date}"
      else
        title = "P.S.#{@date}"
      end
      %(<div class="postscript" markdown="block"><strong>#{title}</strong>\n\n#{output}\n</div>)
    end
  end
end

Liquid::Template.register_tag('ps', Jekyll::Postscript)
Liquid::Template.register_tag('postscript', Jekyll::Postscript)
