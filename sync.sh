#!/bin/bash

cd "$(dirname $BASH_SOURCE)"
chmod +x build.sh
if [ -d compiler ]; then
	rm -rf compiler
fi
git clone https://github.com/adazem009/PowerSlash compiler
