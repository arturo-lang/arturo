#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/path.nim
  * @description: File management & path manipulation
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Path_absolutePath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(absolutePath(S(v0)))

proc Path_absolutePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        S(DEST) = absolutePath(S(DEST))
        return DEST
    # let v0 = VALID(0,SV)

    # S(v0) = absolutePath(S(v0))
    # result = v0

proc Path_copyDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    try:    
        copyDir(S(v0),S(v1))
        result = TRUE
    except:
        result = FALSE

proc Path_copyFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    try:    
        copyFile(S(v0),S(v1))
        result = TRUE
    except:
        result = FALSE

proc Path_createDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    try:    
        createDir(S(v0))
        result = TRUE
    except:
        result = FALSE

proc Path_currentDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,NV|SV)

    if v0.kind==NV:
        result = STR(getCurrentDir())
    else:
        setCurrentDir(S(v0))
        result = v0

proc Path_deleteDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    try:    
        removeDir(S(v0))
        result = TRUE
    except:
        result = FALSE

proc Path_deleteFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = BOOL(tryRemoveFile(S(v0)))

proc Path_dirContent*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    if xl.list.len==2:
        let v1 = VALID(1,SV)
        result = ARR(@[])
        let pattern = re(prepareRegex(S(v1)))
        for kind,file in walkDir S(v0):
            if file.match pattern:
                A(result).add(STR(file))
    else:
        result = ARR(@[])
        for kind,file in walkDir S(v0):
            A(result).add(STR(file))

proc Path_dirContents*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    if xl.list.len==2:
        let v1 = VALID(1,SV)
        result = ARR(@[])
        let pattern = re(prepareRegex(S(v1)))
        for file in walkDirRec S(v0):
            if file.match pattern:
                A(result).add(STR(file))
    else:
        result = ARR(@[])
        for file in walkDirRec S(v0):
            A(result).add(STR(file))

proc Path_fileCreationTime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR($(getCreationTime(S(v0))))

proc Path_fileExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = BOOL(existsFile(S(v0)))

proc Path_fileLastAccess*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR($(getLastAccessTime(S(v0))))

proc Path_fileLastModification*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR($(getLastModificationTime(S(v0))))

proc Path_fileSize*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    try:    
        result = SINT(int(getFileSize(S(v0))))
    except:
        result = SINT(-1)

proc Path_dirExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = BOOL(existsDir(S(v0)))

proc Path_moveDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    try:    
        moveDir(S(v0),S(v1))
        result = TRUE
    except:
        result = FALSE

proc Path_moveFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)
    let v1 = VALID(1,SV)

    try:    
        moveFile(S(v0),S(v1))
        result = TRUE
    except:
        result = FALSE

proc Path_normalizePath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = STR(normalizedPath(S(v0)))

proc Path_normalizePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    IN_PLACE:
        S(DEST) = normalizedPath(S(DEST))
        return DEST
    # let v0 = VALID(0,SV)

    # S(v0) = normalizedPath(S(v0))
    # result = v0

proc Path_pathDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var (dir, _, _) = splitFile(S(v0))

    result = STR(dir)

proc Path_pathExtension*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var (_, _, ext) = splitFile(S(v0))

    result = STR(ext)

proc Path_pathFilename*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    var (_, name, _) = splitFile(S(v0))

    result = STR(name)

proc Path_symlinkExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v0 = VALID(0,SV)

    result = BOOL(symlinkExists(S(v0)))

#[******************************************************
  ******************************************************
    UnitTests
  ******************************************************
  ******************************************************]#

# when defined(unittest):

#     suite "Library: system/dictionary":

#         test "shuffle":
#             check(not eq( callFunction("shuffle",@[ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)])]), ARR(@[INT(1),INT(2),INT(3),INT(4),INT(5),INT(6),INT(7),INT(8),INT(9)]) ))

#         test "swap":
#             check(eq( callFunction("swap",@[ARR(@[INT(1),INT(2),INT(3)]),INT(0),INT(2)]), ARR(@[INT(3),INT(2),INT(1)]) ))
