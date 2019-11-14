#!/usr/bin/env bash

cloc --exclude-dir=_cache,_extras,_legacy,benchmarks,examples \
	 --not-match-f=experimental \
	  --force-lang=YAML,sublime-syntax \
   --read-lang-def=scripts/arturo.cloc .