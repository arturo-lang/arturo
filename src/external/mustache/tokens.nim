import strformat, strutils

type
  Delimiter* = ref object
    open*: string
    close*: string

  Token* = ref object of RootObj
    src*: string
    pos*: int
    size*: int

  Text* = ref object of Token
    doc*: string

  Comment* = ref object of Token

  EscapedTag* = ref object of Token
    key*: string

  UnescapedTag* = ref object of Token
    key*: string

  SectionOpen* = ref object of Token
    key*: string
    inverted*: bool

  SectionClose* = ref object of Token
    key*: string

  Section* = ref object of Token
    key*: string
    inverted*: bool
    children*: seq[Token]

  Partial* = ref object of Token
    key*: string
    indent*: int

  SetDelimiter* = ref object of Token
    delimiter*: Delimiter

method `$`*(token: Token): string {.base.} = "<token>"

method `$`*(token: Text): string = fmt"<text ""{token.doc}"">"

method `$`*(token: EscapedTag): string = fmt"<variable {token.key.strip}>"

method `$`*(token: SectionOpen): string =
  fmt"<section_open {token.key.strip} inverted={token.inverted}>"
method `$`*(token: SectionClose): string = fmt"<section_close {token.key.strip}>"

method `$`*(token: Partial): string =
  fmt"<partial key={token.key} indent={token.indent}>"

method `$`*(token: SetDelimiter): string =
  fmt"<set_delimiter {token.delimiter.open} {token.delimiter.close}>"
