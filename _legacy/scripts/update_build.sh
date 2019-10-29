#!/usr/bin/env bash

if test -f "scripts/update_build_number.awk"; then

	# Build number
	awk -f scripts/update_build_number.awk < source/resources/build.txt > source/resources/build_new.txt
	yes | rm -rf source/resources/build.txt
	mv source/resources/build_new.txt source/resources/build.txt

	# Build date
	date +%d-%b-%Y > "source/resources/build_date.txt"

	git add source/resources/build.txt
	git commit -m "updated build number"
fi