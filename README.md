octopress-postscript
====================

Octopress plugin for the tag of a postscript.

:warning: I tested only with Kramdown 0.14.2. With other parsers, such code
syntax (backtick/codeblock) could not work correctly.

# Installation at Octopress

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

# Usage

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

# Options

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



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/rcmdnk/octopress-postscript/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

