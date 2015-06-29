octopress-postscript
====================

Octopress plugin for the tag of a postscript.

:warning: I tested only with Kramdown 0.14.2. With other parsers, such code
syntax (backtick/codeblock) could not work correctly.

## Installation at Octopress

1. Copy `plugins/postscript.rb`
   to your `plugins` directory.

1. Install SCSS.

   C copy `sass/plugins/_postscript.scss`
   to your `sass/plugins/` directory.

   If you have old octopress
   (if your `sass/screen.scss` doesn't have `@import "plugins/**/*";`),
   you may need to add

    `@import "postscript"`

   to `sass/plugins/_plugins.scss`.

Done!

## Usage

Use `ps` or `postscript` block for the postscript.

    This is an original content.
    {%ps%}
    This is a postscript.
    {%endps%}

This will be like:

    This is an original content.

    - - -
    P.S.
    This is a postscipt.
    - - -

If you want to add date, add an argument

    {%ps 2013/01/01%}...{%endps%}

then,

    This is an original content.

    - - -
    P.S.: 2013/01/01
    This is a postscipt.
    - - -

## Options

You can change the title "P.S." by setting `ps_title` variable in `_config.yml` like:

    ps_title: ps

This will change `P.S.` to `ps`.

Another option is closing comment.

    ps_close: end of postscript.

will show `end of postscripts.` at the end of your postscript.

Postscripts will be in div of class="postscript",
so that you can change the style for the postscript.

The original style just add `$img-border` before and after the postscript.
See `sass/plugins/_postscript.scss`.

## Automatic assign of "date_updated" value

In a YAML block of each post,
you can define `date_updated` (or `updated`) in addition to `date`.

Octopress provides [date-format](https://github.com/octopress/date-format)
with which you can use such `page.date_html` value, which is replaced date information like:

    <time class="entry-date" datetime="2015-06-19T12:00:00+00:00"><span class="date">19 Jun 2015</span></time>

There is also a tag `page.date_updated_html` for an updated date.
In addition, there are tag with time information like `page.date_time_updated_html`.

By using octopress-postscript, these `page.date_updated_html` and `page.date_time_updated_html`
are updated automatically when the tag is rendered.

To use automatic assignment, give a date to `ps` tag, like `{% ps 2015/06/19 %}`.

But such format like `{{page.date_updated_html}}` is rendered before tags.

Instead, octopress-postscript provides tags: `{% datehtml %}` and `{% updatedhtml %}`,
which are corresponding to `{{page.date_updated_html}}` and `{{page.date_updated_html}}`, respectively.

They give


    <span class="date"><time class="entry-date" datetime="2015-06-19T12:00:00+00:00"><span class="date">19 Jun 2015</span></time></span>

These tags are rendered in order in the page.

Therefore, `{% updatedhtml %}` after `{%ps%}` tag has newer date,
so that you can use it in a footer region, but can't use in a header region.

If the page has multi `ps` tags, the latest date is stored.

If you want to add anything before the date information, give words like:

    {% updatedhtml Updated: %}

Then, it gives:

    <span class="date">Updated: <time class="entry-date" datetime="2015-06-19T12:00:00+00:00"><span class="date">19 Jun 2015</span></time></span>
