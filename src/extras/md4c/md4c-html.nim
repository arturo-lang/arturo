##
##  MD4C: Markdown parser for C
##  (http://github.com/mity/md4c)
##
##  Copyright (c) 2016-2017 Martin Mitas
##
##  Permission is hereby granted, free of charge, to any person obtaining a
##  copy of this software and associated documentation files (the "Software"),
##  to deal in the Software without restriction, including without limitation
##  the rights to use, copy, modify, merge, publish, distribute, sublicense,
##  and/or sell copies of the Software, and to permit persons to whom the
##  Software is furnished to do so, subject to the following conditions:
##
##  The above copyright notice and this permission notice shall be included in
##  all copies or substantial portions of the Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
##  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
##  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
##  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
##  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
##  IN THE SOFTWARE.
##

import
  md4c

##  If set, debug output from md_parse() is sent to stderr.

const
  MD_HTML_FLAG_DEBUG* = 0x00000001
  MD_HTML_FLAG_VERBATIM_ENTITIES* = 0x00000002
  MD_HTML_FLAG_SKIP_UTF8_BOM* = 0x00000004
  MD_HTML_FLAG_XHTML* = 0x00000008

##  Render Markdown into HTML.
##
##  Note only contents of <body> tag is generated. Caller must generate
##  HTML header/footer manually before/after calling md_html().
##
##  Params input and input_size specify the Markdown input.
##  Callback process_output() gets called with chunks of HTML output.
##  (Typical implementation may just output the bytes to a file or append to
##  some buffer).
##  Param userdata is just propgated back to process_output() callback.
##  Param parser_flags are flags from md4c.h propagated to md_parse().
##  Param render_flags is bitmask of MD_HTML_FLAG_xxxx.
##
##  Returns -1 on error (if md_parse() fails.)
##  Returns 0 on success.
##

proc md_html*(input: ptr MD_CHAR; input_size: MD_SIZE;
             process_output: proc (a1: ptr MD_CHAR; a2: MD_SIZE; a3: pointer);
             userdata: pointer; parser_flags: cuint; renderer_flags: cuint): cint {.
    importc: "md_html", header: "md4c-html.h".}
proc md_simple*(input: ptr MD_CHAR; input_size: MD_SIZE; userdata: pointer;
               parser_flags: cuint; renderer_flags: cuint): cint {.
    importc: "md_simple", header: "md4c-html.h".}