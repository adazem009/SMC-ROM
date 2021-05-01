#!/bin/bash

if [[ "$2" == '' ]]; then
	compiler="./compiler"
else
	compiler="$2"
fi
cd "$(dirname $BASH_SOURCE)"
if ! [ -d "$compiler" ]; then
	echo "Error: PowerSlash compiler not found. Did you run sync.sh?"
	exit 1
fi
cd "$compiler"
if ! [ -f "compile.sh" ]; then
	echo "Error: Couldn't find compiler script."
	exit 2
fi
if [ -d include ]; then
	rm -rf include
elif [ -f include ]; then
	echo "Error: 'include' must be a directory."
	exit 2
fi
ln -s ../include include
chmod +x compile.sh
if [[ "$1" == '' ]]; then
	name=main
	ext=pwsl
else
	n="$1"
	name1=""
	name2=""
	i=0
	while (( i < ${#n} )); do
		i=$((i+1))
		if [[ "${n:$((i-1)):1}" == "." ]]; then
			name1="$name2"
			name2=""
		else
			name2="${name2}${n:$((i-1)):1}"
		fi
	done
	if [[ "$name1" == "" ]]; then
		name1="$name2"
		name2=""
	fi
	name="$name1"
	ext="$name2"
fi
if ! [ -f "../${name}.$ext" ]; then
	echo "Error: ${name}.${ext}: No such file."
	exit 3
fi
echo "Compiling ${name}.$ext"
./compile.sh "../${name}.$ext"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'smc=($(cat ./output/${name}.smc))'
echo "Creating BIOS image..."
image=""
i=0
while (( i < ${#smc[@]} )); do
	i=$((i+1))
	echo -e "\e[1A\e[KCreating BIOS image... line $i of ${#smc[@]}..."
	line="${smc[$((i-1))]}"
	len=${#line}
	image="${image}${len};${line}"
done
echo "$image" > ../image
