ace.define("ace/mode/arturo_highlight_rules",["require","exports","module","ace/lib/oop","ace/mode/text_highlight_rules"], function(require, exports, module) {
    "use strict";
    
    var oop = require("../lib/oop");
    var TextHighlightRules = require("./text_highlight_rules").TextHighlightRules;
    
    var ArturoHighlightRules = function() {
    
        var compoundKeywords = "";        
    
        this.$rules = {
            "start" : [
                {token : "variable.parameter", 
                    regex: "(?:->|=>|\\||\\:\\:|[\\-]{3,})"},
                {token : "keyword.operator", 
                    regex: "<\\:|\\-\\:|ø|@|#|\\+|\\||\\*|\\$|\\-|\\%|\\/|\\.\\.|\\^|~|=|<|>|\\\\|(?<!\\w)\\?"},
                {token : "string", regex : /"/, next  : "string"},
                {token : "string.other", regex : "{", next  : "string.other"},
                {token : "comment",  regex : /;.+$/},
                {token : "paren.map-start", regex : "#\\("},
                {token : "paren.block-start", regex : "[\\[]"},
                {token : "paren.block-end", regex : "[\\]]"},
                {token : "paren.parens-start", regex : "[(]"},
                {token : "paren.parens-end", regex : "\\)"},
                {token : "support.constant", regex : 
                    "\\b(?:all|and|any|ascii|attr|attribute|attributeLabel|binary|block|char|contains|database|date|dictionary|empty|equal|even|every|exists|false|floating|function|greater|greaterOrEqual|if|in|inline|integer|is|key|label|leap|less|lessOrEqual|literal|logical|lower|nand|negative|nor|not|notEqual|null|numeric|odd|or|path|pathLabel|positive|prefix|prime|regex|same|set|some|sorted|standalone|string|subset|suffix|superset|symbol|symbolLiteral|true|try|type|unless|upper|when|whitespace|word|xnor|xor|zero)\\?(?!:)"
                },
                {token : "support.constant", regex : 
                    "\\b(abs|acos|acosh|acsec|acsech|actan|actanh|add|after|alert|alias|and|angle|append|arg|args|arity|array|as|asec|asech|asin|asinh|atan|atan2|atanh|attr|attrs|average|before|benchmark|blend|break|builtins1|builtins2|call|capitalize|case|ceil|chop|clear|clip|close|color|combine|conj|continue|copy|cos|cosh|crc|csec|csech|ctan|ctanh|cursor|darken|dec|decode|define|delete|desaturate|deviation|dialog|dictionary|difference|digest|digits|div|do|download|drop|dup|e|else|empty|encode|ensure|env|escape|execute|exit|exp|extend|extract|factors|false|fdiv|filter|first|flatten|floor|fold|from|function|gamma|gcd|get|goto|hash|hypot|if|inc|indent|index|infinity|info|input|insert|inspect|intersection|invert|jaro|join|keys|kurtosis|last|let|levenshtein|lighten|list|ln|log|loop|lower|mail|map|match|max|maybe|median|min|mod|module|mul|nand|neg|new|nor|normalize|not|now|null|open|or|outdent|pad|palette|panic|path|pause|permissions|permutate|pi|pop|popup|pow|powerset|powmod|prefix|print|prints|process|product|query|random|range|read|relative|remove|rename|render|repeat|replace|request|return|reverse|round|sample|saturate|script|sec|sech|select|serve|set|shl|shr|shuffle|sin|sinh|size|skewness|slice|sort|spin|split|sqrt|squeeze|stack|strip|sub|suffix|sum|switch|symbols|symlink|sys|take|tan|tanh|terminal|terminate|to|true|truncate|try|type|unclip|union|unique|unless|until|unzip|upper|values|var|variance|volume|webview|while|with|wordwrap|write|xnor|xor|zip)\\b(?!:)"
                },
                {token : "constant.other", regex : /\:\w[-\w'*.?!]*/}, 
                {token : "variable", regex : /\w[-\w'*.?!]*\:/}, 
                {token : "constant.other", regex : /'\w[-\w'*.?!]*/},
                {caseInsensitive: false}
            ],
            "string" : [
                {token : "string", regex : /"/, next : "start"},
                {defaultToken : "string"}
            ],
            "string.other" : [
                {token : "string.other", regex : /}/, next : "start"},
                {defaultToken : "string.other"}
            ],
            "tag" : [
                {token : "string.tag", regex : />/, next : "start"},
                {defaultToken : "string.tag"}
            ],
            "comment" : [
                {token : "comment", regex : /}/, next : "start"},
                {defaultToken : "comment"}
            ]
        };
    };
    oop.inherits(ArturoHighlightRules, TextHighlightRules);
    
    exports.ArturoHighlightRules = ArturoHighlightRules;
    });
    
    ace.define("ace/mode/folding/cstyle",["require","exports","module","ace/lib/oop","ace/range","ace/mode/folding/fold_mode"], function(require, exports, module) {
    "use strict";
    
    var oop = require("../../lib/oop");
    var Range = require("../../range").Range;
    var BaseFoldMode = require("./fold_mode").FoldMode;
    
    var FoldMode = exports.FoldMode = function(commentRegex) {
        if (commentRegex) {
            this.foldingStartMarker = new RegExp(
                this.foldingStartMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.start)
            );
            this.foldingStopMarker = new RegExp(
                this.foldingStopMarker.source.replace(/\|[^|]*?$/, "|" + commentRegex.end)
            );
        }
    };
    oop.inherits(FoldMode, BaseFoldMode);
    
    (function() {
        
        this.foldingStartMarker = /([\{\[\(])[^\}\]\)]*$|^\s*(\/\*)/;
        this.foldingStopMarker = /^[^\[\{\(]*([\}\]\)])|^[\s\*]*(\*\/)/;
        this.singleLineBlockCommentRe= /^\s*(\/\*).*\*\/\s*$/;
        this.tripleStarBlockCommentRe = /^\s*(\/\*\*\*).*\*\/\s*$/;
        this.startRegionRe = /^\s*(\/\*|\/\/)#?region\b/;
        this._getFoldWidgetBase = this.getFoldWidget;
        this.getFoldWidget = function(session, foldStyle, row) {
            var line = session.getLine(row);
        
            if (this.singleLineBlockCommentRe.test(line)) {
                if (!this.startRegionRe.test(line) && !this.tripleStarBlockCommentRe.test(line))
                    return "";
            }
        
            var fw = this._getFoldWidgetBase(session, foldStyle, row);
        
            if (!fw && this.startRegionRe.test(line))
                return "start"; // lineCommentRegionStart
        
            return fw;
        };
    
        this.getFoldWidgetRange = function(session, foldStyle, row, forceMultiline) {
            var line = session.getLine(row);
            
            if (this.startRegionRe.test(line))
                return this.getCommentRegionBlock(session, line, row);
            
            var match = line.match(this.foldingStartMarker);
            if (match) {
                var i = match.index;
    
                if (match[1])
                    return this.openingBracketBlock(session, match[1], row, i);
                    
                var range = session.getCommentFoldRange(row, i + match[0].length, 1);
                
                if (range && !range.isMultiLine()) {
                    if (forceMultiline) {
                        range = this.getSectionRange(session, row);
                    } else if (foldStyle != "all")
                        range = null;
                }
                
                return range;
            }
    
            if (foldStyle === "markbegin")
                return;
    
            var match = line.match(this.foldingStopMarker);
            if (match) {
                var i = match.index + match[0].length;
    
                if (match[1])
                    return this.closingBracketBlock(session, match[1], row, i);
    
                return session.getCommentFoldRange(row, i, -1);
            }
        };
        
        this.getSectionRange = function(session, row) {
            var line = session.getLine(row);
            var startIndent = line.search(/\S/);
            var startRow = row;
            var startColumn = line.length;
            row = row + 1;
            var endRow = row;
            var maxRow = session.getLength();
            while (++row < maxRow) {
                line = session.getLine(row);
                var indent = line.search(/\S/);
                if (indent === -1)
                    continue;
                if  (startIndent > indent)
                    break;
                var subRange = this.getFoldWidgetRange(session, "all", row);
                
                if (subRange) {
                    if (subRange.start.row <= startRow) {
                        break;
                    } else if (subRange.isMultiLine()) {
                        row = subRange.end.row;
                    } else if (startIndent == indent) {
                        break;
                    }
                }
                endRow = row;
            }
            
            return new Range(startRow, startColumn, endRow, session.getLine(endRow).length);
        };
        this.getCommentRegionBlock = function(session, line, row) {
            var startColumn = line.search(/\s*$/);
            var maxRow = session.getLength();
            var startRow = row;
            
            var re = /^\s*(?:\/\*|\/\/|--)#?(end)?region\b/;
            var depth = 1;
            while (++row < maxRow) {
                line = session.getLine(row);
                var m = re.exec(line);
                if (!m) continue;
                if (m[1]) depth--;
                else depth++;
    
                if (!depth) break;
            }
    
            var endRow = row;
            if (endRow > startRow) {
                return new Range(startRow, startColumn, endRow, line.length);
            }
        };
    
    }).call(FoldMode.prototype);
    
    });
    
    ace.define("ace/mode/matching_brace_outdent",["require","exports","module","ace/range"], function(require, exports, module) {
    "use strict";
    
    var Range = require("../range").Range;
    
    var MatchingBraceOutdent = function() {};
    
    (function() {
    
        this.checkOutdent = function(line, input) {
            if (! /^\s+$/.test(line))
                return false;
    
            return /^\s*\}/.test(input);
        };
    
        this.autoOutdent = function(doc, row) {
            var line = doc.getLine(row);
            var match = line.match(/^(\s*\})/);
    
            if (!match) return 0;
    
            var column = match[1].length;
            var openBracePos = doc.findMatchingBracket({row: row, column: column});
    
            if (!openBracePos || openBracePos.row == row) return 0;
    
            var indent = this.$getIndent(doc.getLine(openBracePos.row));
            doc.replace(new Range(row, 0, row, column-1), indent);
        };
    
        this.$getIndent = function(line) {
            return line.match(/^\s*/)[0];
        };
    
    }).call(MatchingBraceOutdent.prototype);
    
    exports.MatchingBraceOutdent = MatchingBraceOutdent;
    });
    
    ace.define("ace/mode/arturo",["require","exports","module","ace/lib/oop","ace/mode/text","ace/mode/arturo_highlight_rules","ace/mode/folding/cstyle","ace/mode/matching_brace_outdent","ace/range"], function(require, exports, module) {
    "use strict";
    
    var oop = require("../lib/oop");
    var TextMode = require("./text").Mode;
    var ArturoHighlightRules = require("./arturo_highlight_rules").ArturoHighlightRules;
    var ArturoFoldMode = require("./folding/cstyle").FoldMode;
    var MatchingBraceOutdent = require("./matching_brace_outdent").MatchingBraceOutdent;
    var Range = require("../range").Range;
    
    var Mode = function() {
        this.HighlightRules = ArturoHighlightRules;
        this.foldingRules = new ArturoFoldMode();
        this.$outdent = new MatchingBraceOutdent();
        this.$behaviour = this.$defaultBehaviour;
    };
    oop.inherits(Mode, TextMode);
    
    (function() {
    
        this.lineCommentStart = ";";
        this.blockComment = { start: "comment {", end: "}" };
    
        this.getNextLineIndent = function(state, line, tab) {
            var indent = this.$getIndent(line);
    
            var tokenizedLine = this.getTokenizer().getLineTokens(line, state);
            var tokens = tokenizedLine.tokens;
            var endState = tokenizedLine.state;
    
            if (tokens.length && tokens[tokens.length-1].type == "comment") {
                return indent;
            }
    
            if (state == "start") {
                var match = line.match(/^.*[\{\[\(]\s*$/);
                if (match) {
                    indent += tab;
                }
            } else if (state == "doc-start") {
                if (endState == "start") {
                    return "";
                }
                var match = line.match(/^\s*(\/?)\*/);
                if (match) {
                    if (match[1]) {
                        indent += " ";
                    }
                    indent += "* ";
                }
            }
    
            return indent;
        };
    
        this.checkOutdent = function(state, line, input) {
            return this.$outdent.checkOutdent(line, input);
        };
    
        this.autoOutdent = function(state, doc, row) {
            this.$outdent.autoOutdent(doc, row);
        };
    
        this.$id = "ace/mode/arturo";
    }).call(Mode.prototype);
    
    exports.Mode = Mode;
    });                (function() {
                        ace.require(["ace/mode/arturo"], function(m) {
                            if (typeof module == "object" && typeof exports == "object" && module) {
                                module.exports = m;
                            }
                        });
                    })();