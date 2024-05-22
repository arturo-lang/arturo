{.compile: "md4c/md4c.c".}
{.compile: "md4c/md4c-html.c".}
{.compile: "md4c/entity.c".}

type 
    memBuffer* {.importc: "struct membuffer", bycopy.} = object
        data*: cstring
        asize*: csize_t
        size*: csize_t

    mdCallback* = proc (str: cstring, i: cint, p:pointer): pointer

func toMarkdown*(
    input: cstring, 
    input_size: cint, 
    userdata: ptr memBuffer, 
    parser_flags: cint, 
    renderer_flags: cint): cint {.importc: "toMarkdown",header: "<md4c/md4c-html.h>".}

func freeMarkdownBuffer*(
    userdata: ptr memBuffer,
) {.importc: "membuf_fini",header: "<md4c/md4c-html.h>".}