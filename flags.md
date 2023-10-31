```nim

## From build.nims

# Arch:

--cpu:arm                             # tags: arm32
--cpu:arm64                           # tags: arm64
--cpu:i386                            # tags: x86

--define:bit32                        # tags: arm32
--define:bit32                        # tags: x86

--gcc.path:/usr/bin                   # tags: arm64
--gcc.exe:aarch64-linux-gnu-gcc       # tags: arm64
--gcc.linkerexe:aarch64-linux-gnu-gcc # tags: arm64

--passC:'-m32'                        # tags: x86, gcc
--passL:'-m32'                        # tags: x86, gcc

# Developer

--embedsrc:on                         # tags: dev
--define:DEV                          # tags: dev
--listCmd                             # tags: dev

--define:DEBUG                        # tags: debug
--debugger:on                         # tags: debug
--debuginfo                           # tags: debug
--linedir:on                          # tags: debug

--define:PROFILE                      # tags: memprofile
--profiler:off                        # tags: memprofile
--stackTrace:on                       # tags: memprofile
--define:memProfiler                  # tags: memprofile

--define:PROFILE                      # tags: profiler
--profiler:on                         # tags: profiler
--stackTrace:on                       # tags: profiler

--debugger:native                     # tags: profilenative

# Compilation

--define:OPTIMIZED                    # tags: optimized

--define:strip                        # tags: release
--passC:-flto                         # tags: release, unix
--passL:-flto                         # tags: release, unix

# Compilation: full

--define:ssl                          # tags: full

# Compilation: mini/web

--define:SAFE                         # tags: safe
--define:MINI                         # tags: mini
--define:WEB                          # tags: web

--verbosity: 3                        # tags: web

--define:NOASCIIDECODE                # tags: noasciidecode
--define:NOCLIPBOARD                  # tags: noclipboard
--define:NODIALOGS                    # tags: nodialogs
--define:NOERRORLINES                 # tags: noerrorlines
--define:NOGMP                        # tags: nogmp
--define:NOPARSERS                    # tags: noparsers
--define:NOSQLITE                     # tags: nosqlite
--define:NOWEBVIEW                    # tags: nowebview

# Compilation: defaults
--verbosity:1                         # tags: default
--hints:on                            # tags: default
--hint:ProcessingStmt:off             # tags: default
--hint:XCannotRaiseY:off              # tags: default
--warning:GcUnsafe:off                # tags: default
--warning:CastSizes:off               # tags: default
--warning:ProveInit:off               # tags: default
--warning:ProveField:off              # tags: default
--warning:Uninit:off                  # tags: default
--warning:BareExcept:off              # tags: default
--threads:off                         # tags: default
--skipUserCfg:on                      # tags: default
--colors:off                          # tags: default
--define:danger                       # tags: default
--panics:off                          # tags: default
--mm:orc                              # tags: default
--define:useMalloc                    # tags: default            
--checks:off                          # tags: default
--cincludes:extras                    # tags: default
--opt:speed                           # tags: default
--nimcache:.cache                     # tags: default
--passL:-pthread                      # tags: default, windows-host
--path:src                            # tags: default
                                      # tags: default, windows
--passL:"-static-libstdc++ -static-libgcc -Wl,-Bstatic -lstdc++ -Wl,-Bdynamic" -- gcc.linkerexe='g++'
--passL:-lm                           # tags: default, unix

# Docs

--define:DOCGEN                       # tags: docs
--project                             # tags: docs
--index:on                            # tags: docs
--outdir:dev-docs                     # tags: docs

# Package

--forceBuild:on                       # tags: package
--opt:size                            # tags: package
--define:NOERRORLINES                 # tags: package
--define:PORTABLE                     # tags: package

## From config.nims

--cincludes:extras                    # tags: default
--path:src                            # tags: default
--hints:off                           # tags: default

                                      # tags: default, windows-host
--gcc.path:staticExec("pkg-config --libs-only-L gmp")
      .strip()
      .replace("-L","")
      .replace("/lib","/bin")
      .normalizedPath
      
--define:$mimallocStatic              # tags: default
--define:$mimallocIncludePath         # tags: default
                                      # tags: default, (gcc | clang | icc | icl)
--passC:"-ftls-model=initial-exec -fno-builtin-malloc"

--dynlibOverride:pcre64               # tags: default, windows
--define:noOpenSSLHacks               # tags: default, windows, ssl
--define:'sslVersion:('               # tags: default, windows, ssl
--dynlibOverride:'ssl-'               # tags: default, windows, ssl
--dynlibOverride:'crypto-'            # tags: default, windows, ssl

--dynlibOverride:pcre                 # tags: default, macosx
--dynlibOverride:ssl                  # tags: default, unix, ssl
--dynlibOverride:crypto               # tags: default, unix, ssl
```