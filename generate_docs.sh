#!/bin/sh

# Running this as-is gives this cryptic error: 
# --macro:1: character 0 : Invalid package : src.haxesharp.text should be haxesharp.text

# Not sure why. Work-around: copy everything into a flat directory structure.

# Step 1: generate docgen/bin/neko.xml
rm -rf docgen
mkdir docgen

cp -r src/haxesharp docgen
cp docs.hxml docgen
cd docgen
haxe docs.hxml

# Step 2: convert it into HTML

haxelib run dox -i bin -o ../docs --include "^haxesharp" --title HaxeSharp
cd ..
rm -rf docgen