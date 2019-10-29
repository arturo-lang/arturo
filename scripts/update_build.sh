#!/usr/bin/env bash

if test -f "scripts/update_build_number.awk"; then

	# Build number
	awk -f scripts/update_build_number.awk < src/rsrc/build.txt > src/rsrc/build_new.txt
	yes | rm -rf src/rsrc/build.txt
	mv src/rsrc/build_new.txt src/rsrc/build.txt

	# Build date
	date +%d-%b-%Y > "src/rsrc/build_date.txt"

	git add source/resources/build.txt
	git commit -m "updated build number"
fi