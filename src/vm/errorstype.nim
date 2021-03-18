const
    RuntimeError*   = "Runtime"
    AssertionError* = "Assertion"
    SyntaxError*    = "Syntax"
    ProgramError*   = "Program"
    CompilerError*  = "Compiler"

    Alternative*  = "perhaps you meant"

type 
    ReturnTriggered* = ref object of Defect
    BreakTriggered* = ref object of Defect
    ContinueTriggered* = ref object of Defect
    VMError* = ref object of Defect

proc panic*(context: string, error: string) =
    var errorMsg = error
    #if $(context) notin [errorstype.AssertionError, SyntaxError, CompilerError]:
    #    errorMsg &= getOpStack()
    raise VMError(name: context, msg:move errorMsg)