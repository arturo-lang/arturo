#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: helpers/datasource.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import sequtils, strformat
import strutils, tables
import sugar

when defined(DOCGEN):
    import re

import helpers/sets
import helpers/terminal

import vm/values/[printable, value]


#=======================================
# Types
#=======================================

type
    ValueObj = tuple[name: string, val: Value]

#=======================================
# Constants
#=======================================

const
    lineChar       = '-'
    lineLength     = 80
    initialSep     = "|"
    initialPadding = "    "
    labelAlignment = 11

#=======================================
# Helpers
#=======================================

template printLine(charWith = lineChar) =
    
    stdout.write initialSep
    
    if charWith != lineChar: stdout.write fg(grayColor)
    for _ in 0..<lineLength: 
        stdout.write charWith
    stdout.write "\n"
    if charWith != lineChar: stdout.write resetColor()
    
    stdout.flushFile()


proc printEmptyLine() = 
    echo "|"


proc getAlias(objName: string, aliases: SymbolDict): (string, PrecedenceKind) = 
    ## Return the alias of an object into a tuple 
    ## with it's symbol as a string and its kind of precedence
    
    runnableExamples:
        import vm/globals   # Aliases
        import vm/values    # PrecedenceKind
        
        assert ("~", PrefixPrecedence) == "render".getAlias(Aliases)
        
    result = ("", PrefixPrecedence)
    
    # Updates only if the objName is into the aliases
    for key, alias in pairs(aliases):
        if alias.name.s == objName:
            return ($(newSymbol(key)), alias.precedence)


proc printOneData(
        label:  string, 
        data:   string, 
        color:  string = resetColor, 
        colorb: string = resetColor
    ) =
    let 
        init  = fmt"{initialSep}{initialPadding}"
        label = fmt"{color}{align(label, labelAlignment)}{resetColor}"
        data  = fmt"{colorb}{data}{resetColor}"
    echo fmt"{init}{label}  {data}"


proc printMultiData(
        label:  string, 
        data:   seq[string], 
        color:  string = resetColor, 
        colorb: string = resetColor
    ) =
    
    printOneData(label, data[0], color, colorb)
    for item in data[1..^1]:
        printOneData("", item, resetColor, colorb)


func getShortData(initial: string, cutoff=50): seq[string] =
    result = @[initial]
    if result[0].len > cutoff:
        let parts  = result[0].splitWhitespace()
        let middle = (parts.len div 2)
        result = @[
            parts[0..middle].join(" "),
            parts[(middle + 1)..^1].join(" ")
        ]


func getTypeString(valueSpec: ValueSpec): string =
    ## Returns the representation of a type into a string
    if valueSpec == {}: 
        return ":nothing"
    
    return collect(for spec in valueSpec: spec.stringify()).join(" ")


proc getUsageForFunction(obj: ValueObj): seq[string] =
    
    let 
        args = toSeq(obj.val.info.args.pairs)
        templateName = fmt"{bold()}{obj.name}{resetColor}"
        templateType = getShortData(getTypeString(args[0][1]))
        
    var 
        spaceBefore: string

    for _ in 0..obj.name.len:
        spaceBefore &= " "

    if args[0][0] != "":
        let templateArg = fmt"{args[0][0]}" 
        result.add fmt "{templateName} {templateArg} {fg(grayColor)}{templateType[0]}{resetColor}"
        if templateType.len > 1:
            var extraSpaceBefore: string
            for _ in 0..templateArg.len:
                extraSpaceBefore &= " "
            for tt in templateType[1..^1]:
                result.add fmt"{spaceBefore}{extraSpaceBefore}{fg(grayColor)}{tt}{resetColor}"
    else:   
        result.add fmt"{templateName} {templateType}"

    for arg in args[1..^1]:
        let
            templateArg  = fmt"{arg[0]}"
            templateType = getShortData(getTypeString(arg[1]))
        
        result.add fmt "{spaceBefore}{templateArg} {fg(grayColor)}{templateType[0]}{resetColor}"
        if templateType.len > 1:
            var extraSpaceBefore: string
            for _ in 0..templateArg.len:
                extraSpaceBefore &= " "
            for tt in templateType[1..^1]:
                result.add fmt"{spaceBefore}{extraSpaceBefore}{fg(grayColor)}{tt}{resetColor}"


proc getOptionsForFunction(value: Value): seq[string] =
    var attrs = toSeq(value.info.attrs.pairs)
    
    if attrs.len == 1 and attrs[0][0] == "": 
        return @[]

    var maxLen = 0
    for attr in attrs:
        let typeStr = getTypeString(attr[1][0])
        if typeStr != ":logical":
            let len = fmt".{attr[0]} {typeStr}".len
            if len > maxLen: 
                maxLen = len
        else:
            let len = fmt".{attr[0]}".len
            if len > maxLen: 
                maxLen = len

    for attr in attrs:
        let typeStr = getTypeString(attr[1][0])
        var 
            leftSide: string
            myLen = maxLen
        
        if typeStr != ":logical":
            leftSide = fmt"{fg(cyanColor)}.{attr[0]} {fg(grayColor)}{typeStr}"
            myLen += len(fmt"{fg(cyanColor)}{fg(grayColor)}")
        else:
            leftSide = fmt"{fg(cyanColor)}.{attr[0]}"
            myLen += len(fmt"{fg(cyanColor)}")
        
        result.add fmt"{alignLeft(leftSide, myLen)} {resetColor}-> {attr[1][1]}"


when defined(DOCGEN):
    
    proc splitExamples*(example: string): seq[string] =
        var currentExample: string
        
        for line in splitLines(example):
            
            if line.strip().findAll(re"\.{4,}").len > 0:
                result.add(currentExample)
                currentExample = ""
            else:
                if currentExample != "":
                    currentExample &= "\n"
                currentExample &= line

        result.add(currentExample)


    proc syntaxHighlight(code: string) =
        # token colors
        let
            commentColor  = fg   grayColor
            literalColor  = fg   rgb("129")
            functionColor = fg   rgb("87" )
            labelColor    = fg   rgb("148")
            sugarColor    = bold rgb("208")
            symbolColor   = fg   rgb("124")
            stringColor   = fg   rgb("221")

        proc colorizeToken(color, pattern: string): 
            tuple[pattern: Regex, repl: string] =
             
            (re(pattern), "{color}$1{resetColor}".fmt)

        let highlighted = code.splitLines().map((line)=>
            line.multiReplace(@[
                colorizeToken(commentColor,  """(;.+)$"""),
                colorizeToken(stringColor,   """(\"[^\"]+\")"""),
                colorizeToken(stringColor,   """(`[^\`]+`)"""),
                colorizeToken(literalColor,  """('[\w]+\b\??:?)"""),
                colorizeToken(labelColor,    """([\w]+\b\??:)"""),
                colorizeToken(sugarColor,    """(->|=>|\||\:\:|[\-]{3,})"""),
                colorizeToken(functionColor, """((?<!')\b(all|and|any|ascii|attr|attribute|attributeLabel|binary|block|char|contains|database|date|dictionary|empty|equal|even|every|exists|false|floating|function|greater|greaterOrEqual|if|in|inline|integer|is|key|label|leap|less|lessOrEqual|literal|logical|lower|nand|negative|nor|not|notEqual|null|numeric|odd|or|path|pathLabel|positive|prefix|prime|set|some|sorted|standalone|string|subset|suffix|superset|symbol|true|type|unless|upper|when|whitespace|word|xnor|xor|zero)\?(?!:))"""),
                colorizeToken(symbolColor,   """(<\:|\-\:|ø|∞|@|#|\+|<=>|=>>|<->|-->|<-->|==>|<==>|<\||\|\-|\|=|\||\*|\$|\-|\%|\/|[\.]{2,}|&|_|!|!!|<:|>:|\./|\^|~|=|<|>|\\|(?<!\\w)\?)"""),
                colorizeToken(functionColor, """((?<!')\b(abs|acos|acosh|acsec|acsech|actan|actanh|add|after|and|angle|append|arg|args|arity|array|as|asec|asech|asin|asinh|atan|atan2|atanh|attr|attrs|average|before|benchmark|blend|break|builtins1|builtins2|call|capitalize|case|ceil|chop|clear|close|color|combine|conj|continue|copy|cos|cosh|csec|csech|ctan|ctanh|cursor|darken|dec|decode|define|delete|desaturate|deviation|dictionary|difference|digest|digits|div|do|download|drop|dup|e|else|empty|encode|ensure|env|escape|execute|exit|exp|extend|extract|factors|false|fdiv|filter|first|flatten|floor|fold|from|function|gamma|gcd|get|goto|hash|help|hypot|if|inc|indent|index|infinity|info|input|insert|inspect|intersection|invert|join|keys|kurtosis|last|let|levenshtein|lighten|list|ln|log|loop|lower|mail|map|match|max|maybe|median|min|mod|module|mul|nand|neg|new|nor|normalize|not|now|null|open|or|outdent|pad|panic|path|pause|permissions|permutate|pi|pop|pow|powerset|powmod|prefix|print|prints|process|product|query|random|range|read|relative|remove|rename|render|repeat|replace|request|return|reverse|round|sample|saturate|script|sec|sech|select|serve|set|shl|shr|shuffle|sin|sinh|size|skewness|slice|sort|split|sqrt|squeeze|stack|strip|sub|suffix|sum|switch|symbols|symlink|sys|take|tan|tanh|terminal|to|true|truncate|try|type|union|unique|unless|until|unzip|upper|values|var|variance|volume|webview|while|with|wordwrap|write|xnor|xor|zip)\b(?!:))""")
            ])
        )

        for line in highlighted:
            echo fmt"{initialSep}{initialPadding}{line}"
            
            
proc insertFunctionInfo(
        info: var ValueDict, 
        obj: ValueObj, 
        aliases: SymbolDict
    ) {. inline .} =
    
    var funArgs  = initOrderedTable[string,Value]()
    var funAttrs = initOrderedTable[string,Value]()
    
    # Internal helpers
    
    template validSpec(value: Value, spec: untyped): bool =
        ## Checks if the function value has arguments or attributes
        ## * spec: can be 'args or 'attrs
        value.info.spec.len > 0 and (toSeq(value.info.spec.keys))[0] != ""
        
    template listTypes(values: untyped): Value =
        ## Converts each value of values to Type 
        ## and returns it into a new Block
        newBlock collect(for val in values: newType val)
        
    
    if obj.val.validSpec(args):        
        for key, spec in obj.val.args: 
            funArgs[key] = spec.listTypes()

    if obj.val.validSpec(attrs):            
        for key, objAttr in obj.val.info.attrs:
            var attribute = initOrderedTable[string,Value]()
            
            let spec      = objAttr[0]
            let descr     = objAttr[1]

            attribute["types"]       = spec.listTypes()
            attribute["description"] = newString(descr)
            funAttrs[key]            = newDictionary(attribute)
            
    info["args"]    = newDictionary(funArgs)
    info["attrs"]   = newDictionary(funAttrs)
    info["returns"] = if obj.val.info.returns.len == 0: 
        newBlock(@[newType(Nothing)]) else: obj.val.info.returns.listTypes()

    let alias = getAlias(obj.name, aliases)
    if alias[0] != "":
        info["alias"]  = newString(alias[0])
        info["infix?"] = newLogical(alias[1] == InfixPrecedence)
        

when defined(DOCGEN):
    
    proc insertDocumentationInfo(
            info: var ValueDict, 
            obj: ValueObj
    ) {. inline .} =
    
        ## Inserts documentation's information into the ValueDict 
        const 
            repo = "https://github.com/arturo-lang/arturo/blob/v0.9.83/src/library/"
        
        info["example"] = newStringBlock(splitExamples(obj.val.info.example))
        
        if obj.val.info.line == 0:
            return
        
        info["line"] = newInteger(obj.val.info.line)
        info["source"] = newString(
                repo & 
                info["module"].s & 
                ".nim#L" & 
                $(info["line"].i))
                
                
proc printHeader(obj: ValueObj) {. inline .} =
    
    let 
        typeStr = valueKind(obj.val).alignLeft(30)
        address = fmt"{cast[uint](obj.val):#X}".align(32)
    
    let data = if (not obj.val.info.isNil) and obj.val.info.module != "":
        fmt"{typeStr}{fg(grayColor)}{align(obj.val.info.module, 32)}"
    else:
        fmt"{typeStr}{fg(grayColor)}{address}"
       
    printLine() 
    printOneData(
        obj.name,
        data,
        bold(magentaColor),
        resetColor
    )


proc printAlias(obj: ValueObj, aliases: SymbolDict) {. inline .} =
    let alias = getAlias(obj.name, aliases)[0]
    if alias != "":
        printOneData("alias", alias)


proc printDescription(obj: ValueObj) {. inline .} =
    for decription in getShortData(obj.val.info.descr):
        printOneData("", decription)
        
        
proc printFunction(obj: ValueObj) {. inline .} =
    let opts = getOptionsForFunction(obj.val)
    
    printMultiData("usage", obj.getUsageForFunction(), 
                   bold(greenColor))
    
    if opts.len>0:
        printEmptyLine()
        printMultiData("options", opts, bold(greenColor))
        
    printEmptyLine()
    printOneData("returns", getTypeString(obj.val.info.returns), 
                 bold(greenColor), fg(grayColor))
    printLine()


#=======================================
# Methods
#=======================================


proc getInfo*(objName: string, objValue: Value, aliases: SymbolDict): ValueDict =
    ## Returns a Dictionary containing information about a object

    result = initOrderedTable[string,Value]()
    
    let obj:    ValueObj  = (name: objName, val: objValue)

    result["name"]    = newString(obj.name)
    result["address"] = newString(fmt"{cast[uint](obj.val):#X}")
    result["type"]    = newType(obj.val.kind)
    
    if obj.val.info.isNil:
        return
    
    # ====> In case 'info attribute is present: 
    
    if obj.val.info.descr  != "":  result["description"] = newString(obj.val.info.descr) 
    if obj.val.info.module != "": result["module"]       = newString(obj.val.info.module)

    if obj.val.info.kind == Function:
        result.insertFunctionInfo(obj, aliases)
        
    when defined(DOCGEN):
       result.insertDocumentationInfo(obj) 


# TODO(Helpers/helper) embed "see also" functions in info screens
#  related: https://github.com/arturo-lang/arturo/issues/466#issuecomment-1065274429
#  labels: helpers, library, repl, enhancement

proc printInfo*(objName: string, objValue: Value, aliases: SymbolDict) =

    let obj: ValueObj = (name: objName, val: objValue)

    obj.printHeader()
    obj.printAlias(aliases)
    
    printLine()

    # If it's a function or builtin constant,
    # print its description/info
    if obj.val.info.isNil:
        return
    
    obj.printDescription()
    
    printLine()

    # If it's a function,
    # print more details
    if obj.val.info.kind == Function:
        obj.printFunction()