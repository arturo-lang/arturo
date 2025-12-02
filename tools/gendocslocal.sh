#!/usr/bin/env bash

## comment-out for faster testing (e.g. just style/script changes)
arturo-docg tools/sitegen.art
arturo-docg tools/indexgen.art

echo "version: \"$(cat version/version)\"" > docs/website/pages/_index.art 
echo "buildDate: \"$(date -u)\"" >> docs/website/pages/_index.art 
echo "#[release?: false]" > docs/website/data/setup.art

## comment-out for faster testing (see: above)
rm -rf tmpdocs
mkdir tmpdocs

cd docs/website

arturo-docg ../../tools/miniwebize/webize.art --build --at: ../../tmpdocs
cd ../..

rm -rf /Applications/XAMPP/xamppfiles/htdocs/arturodocs
mkdir /Applications/XAMPP/xamppfiles/htdocs/arturodocs
cp -r tmpdocs/* /Applications/XAMPP/xamppfiles/htdocs/arturodocs
