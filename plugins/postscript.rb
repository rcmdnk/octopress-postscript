# Author: rcmdnk
# rcmdnk (https://github.com/rcmdnk/octopress-ps)

module Jekyll
  class Postscript < Liquid::Block
    def initialize(tag_name, markup, tokens)
      @date = markup == ""? "" : ": #{markup}"
      super
    end

    def datetime(input)
      case input
      when Time
        input
      when Date, DateTime
        input.to_date
      when String
        Time.parse(input) rescue nil
      when Numeric
        Time.at(input)
      else
        nil
      end
    end

    def render(context)
      output = super
      config = context.registers[:site].config
      title = (config['ps_title'] ? config['ps_title']:"P.S.") + "#{@date}"
      close = config['ps_close'] ? config['ps_close'] : ""

      if defined?(Octopress::PageDate)
        updated = datetime(context['page']['updated'])
        psupdated = datetime(@date)
        if psupdated != nil
          if updated == nil or psupdated > updated
            context['page']['updated'] = psupdated.strftime("%Y-%m-%d %H:%M")
            context['page']['date_updated_html'] = Octopress::PageDate.date_updated_html(psupdated, false)
            context['page']['date_time_updated_html'] = Octopress::PageDate.date_updated_html(psupdated)
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

  class DateHTML < Liquid::Tag
    def initialize(name, markup, tokens)
      @html_name = 'date_html'
      @prewords = markup
      super
    end
    def render(context)
      html = context['page'][@html_name]
      if html == nil
        ""
      else
        "<span class=\"date-wrapper\">#{@prewords}#{html}</span>"
      end
    end
  end

  class DateTimeHTML < DateHTML
    def initialize(name, markup, tokens)
      super
      @html_name = 'date_html'
    end
  end

  class DateUpdatedHTML < DateHTML
    def initialize(name, markup, tokens)
      super
      @html_name = 'date_updated_html'
    end
  end

  class DateTimeUpdatedHTML < DateHTML
    def initialize(name, markup, tokens)
      super
      @html_name = 'date_time_updated_html'
    end
  end
end

Liquid::Template.register_tag('ps', Jekyll::Postscript)
Liquid::Template.register_tag('postscript', Jekyll::Postscript)
Liquid::Template.register_tag('date_html', Jekyll::DateHTML)
Liquid::Template.register_tag('date_time_html', Jekyll::DateHTML)
Liquid::Template.register_tag('date_updated_html', Jekyll::DateUpdatedHTML)
Liquid::Template.register_tag('date_time_updated_html', Jekyll::DateTimeUpdatedHTML)
