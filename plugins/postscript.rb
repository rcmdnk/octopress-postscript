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

      if defined?(Octopress::DateFormat)
        updated = Octopress::DateFormat.datetime(context['page']['updated']) rescue nil
        psupdated = Octopress::DateFormat.datetime(@date)
        if psupdated != nil
          if updated == nil or psupdated > updated
            context['page']['updated'] = psupdated.strftime("%Y-%m-%d %H:%M")
            context['page']['date_updated_html'] = Octopress::DateFormat.date_updated_html(psupdated, false)
            context['page']['date_time_updated_html'] = Octopress::DateFormat.date_updated_html(psupdated)
            if context['page']['date_html']
              context['page']['date_html'].sub!(" updated", "")
              context['page']['date_html'].sub!(" dateModified", "")
            end
            if context['page']['date_time_html']
              context['page']['date_time_html'].sub!(" updated", "")
              context['page']['date_time_html'].sub!(" dateModified", "")
            end
          end
        end
      end
      %(\n<div class="postscript" markdown="block"><strong>#{title}</strong>\n\n#{output}\n\n<strong>#{close}</strong>\n</div>\n)
    end
  end
end

Liquid::Template.register_tag('ps', Jekyll::Postscript)
Liquid::Template.register_tag('postscript', Jekyll::Postscript)
