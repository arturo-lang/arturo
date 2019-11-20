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
    let v = xl.validate(f)

    result = STR(absolutePath(S(v[0])))

proc Path_absolutePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(v[0]) = absolutePath(S(v[0]))
    result = v[0]

proc Path_copyDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        copyDir(S(v[0]),S(v[1]))
        result = TRUE
    except:
        result = FALSE

proc Path_copyFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        copyFile(S(v[0]),S(v[1]))
        result = TRUE
    except:
        result = FALSE

proc Path_createDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        createDir(S(v[0]))
        result = TRUE
    except:
        result = FALSE

proc Path_currentDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v[0].kind==NV:
        result = STR(getCurrentDir())
    else:
        setCurrentDir(S(v[0]))
        result = v[0]

proc Path_deleteDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        removeDir(S(v[0]))
        result = TRUE
    except:
        result = FALSE

proc Path_deleteFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(tryRemoveFile(S(v[0])))

proc Path_dirContent*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v.len==2:
        result = ARR(@[])
        let pattern = re(prepareRegex(S(v[1])))
        for kind,file in walkDir S(v[0]):
            if file.match pattern:
                result.a.add(STR(file))
    else:
        result = ARR(@[])
        for kind,file in walkDir S(v[0]):
            result.a.add(STR(file))

proc Path_dirContents*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    if v.len==2:
        result = ARR(@[])
        let pattern = re(prepareRegex(S(v[1])))
        for file in walkDirRec S(v[0]):
            if file.match pattern:
                result.a.add(STR(file))
    else:
        result = ARR(@[])
        for file in walkDirRec S(v[0]):
            result.a.add(STR(file))

proc Path_fileCreationTime*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getCreationTime(S(v[0]))))

proc Path_fileExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(existsFile(S(v[0])))

proc Path_fileLastAccess*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getLastAccessTime(S(v[0]))))

proc Path_fileLastModification*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR($(getLastModificationTime(S(v[0]))))

proc Path_fileSize*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        result = INT(int(getFileSize(S(v[0]))))
    except:
        result = INT(-1)

proc Path_dirExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(existsDir(S(v[0])))

proc Path_moveDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        moveDir(S(v[0]),S(v[1]))
        result = TRUE
    except:
        result = FALSE

proc Path_moveFile*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    try:    
        moveFile(S(v[0]),S(v[1]))
        result = TRUE
    except:
        result = FALSE

proc Path_normalizePath*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = STR(normalizedPath(S(v[0])))

proc Path_normalizePathI*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    S(v[0]) = normalizedPath(S(v[0]))
    result = v[0]

proc Path_pathDir*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(v[0]))

    result = STR(dir)

proc Path_pathExtension*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(v[0]))

    result = STR(ext)

proc Path_pathFilename*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    var (dir, name, ext) = splitFile(S(v[0]))

    result = STR(name)

proc Path_symlinkExists*[F,X,V](f: F, xl: X): V {.inline.} =
    let v = xl.validate(f)

    result = BOOL(symlinkExists(S(v[0])))

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
