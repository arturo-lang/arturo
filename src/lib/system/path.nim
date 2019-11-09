#[*****************************************************************
  * Arturo
  * 
  * Programming Language + Interpreter
  * (c) 2019 Yanis Zafirópulos (aka Dr.Kameleon)
  *
  * @file: lib/system/path.nim
  *****************************************************************]#

#[######################################################
    Functions
  ======================================================]#

proc Path_absolutePath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(absolutePath(S(0)))

proc Path_absolutePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = absolutePath(S(0))
    result = v[0]

proc Path_copyDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        copyDir(S(0),S(1))
        result = TRUE
    except:
        result = FALSE

proc Path_copyFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        copyFile(S(0),S(1))
        result = TRUE
    except:
        result = FALSE

proc Path_createDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        createDir(S(0))
        result = TRUE
    except:
        result = FALSE

proc Path_currentDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==NV:
        result = STR(getCurrentDir())
    else:
        setCurrentDir(S(0))
        result = v[0]

proc Path_deleteDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        removeDir(S(0))
        result = TRUE
    except:
        result = FALSE

proc Path_deleteFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(tryRemoveFile(S(0)))

proc Path_fileCreationTime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getCreationTime(S(0))))

proc Path_fileExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(existsFile(S(0)))

proc Path_fileLastAccess*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getLastAccessTime(S(0))))

proc Path_fileLastModification*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getLastModificationTime(S(0))))

proc Path_fileSize*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        result = INT(int(getFileSize(S(0))))
    except:
        result = INT(-1)

proc Path_dirExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(existsDir(S(0)))

proc Path_moveDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        moveDir(S(0),S(1))
        result = TRUE
    except:
        result = FALSE

proc Path_moveFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        moveFile(S(0),S(1))
        result = TRUE
    except:
        result = FALSE

proc Path_normalizePath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(normalizedPath(S(0)))

proc Path_normalizePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(0) = normalizedPath(S(0))
    result = v[0]

proc Path_pathDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(0))

    result = STR(dir)

proc Path_pathExtension*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(0))

    result = STR(ext)

proc Path_pathFilename*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(0))

    result = STR(name)

proc Path_symlinkExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(symlinkExists(S(0)))

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
