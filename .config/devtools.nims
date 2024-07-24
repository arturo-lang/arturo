
{. push used .}

proc debugConfig() =
    --define:DEBUG
    --debugger:on
    --debuginfo
    --linedir:on

proc profileConfig() =
    --define:PROFILE 
    --profiler:on 
    --stackTrace:on
    
proc nativeProfileConfig() =
    --debugger:native

proc profilerConfig() =
    --define:PROFILER 
    --profiler:on 
    --stackTrace:on
    
proc memProfileConfig() =
    --define:PROFILE 
    --profiler:off
    --stackTrace:on
    --d:memProfiler
    
{. pop .}