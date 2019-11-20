type
  Parser* = ref object of RootObj

  MarkdownConfig* = ref object ## Options for configuring parsing or rendering behavior.
    escape*: bool ## escape ``<``, ``>``, and ``&`` characters to be HTML-safe
    keepHtml*: bool ## deprecated: preserve HTML tags rather than escape it
    blockParsers*: seq[Parser]
    inlineParsers*: seq[Parser]
