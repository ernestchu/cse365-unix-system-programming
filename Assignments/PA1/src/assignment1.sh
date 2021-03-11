#!/bin/zsh
# tput color: https://blog.gtwang.org/linux/how-to-make-a-fancy-and-useful-bash-prompt-in-linux-2/

DIRS=ingredients/directories
SLKS=ingredients/symlinks
DESS=ingredients/descriptions
OBJS=ingredients/objects

if [ -f $DIRS ] && [ -f $SLKS ]; then
else
    echo "$(tput setaf 1)Missing some mandatory ingredients! Exiting$(tput sgr0)"
    exit 1
fi

if [ $# != 1 ]; then
    echo "\n$(tput setaf 1)Usage:$(tput sgr0)"
    echo "$0 run"
    echo "$0 clean\n"
    exit 1
fi

# Clean
rm -rf dunnet
rm -f ~/rooms

if [ $1 = "clean" ]; then
    echo "$(tput setaf 2)Cleaned!$(tput sgr0)"
    exit 0
fi

if [ $1 != "run" ]; then
    echo "\n$(tput setaf 1)Usage:$(tput sgr0)"
    echo "$0 run"
    echo "$0 clean\n"
    exit 1
fi

echo "$(tput setaf 2)Creating directories$(tput sgr0)"
cat $DIRS | xargs mkdir -p

echo "$(tput setaf 2)Creating '9' files$(tput sgr0)"
touch 9
find $(sed -n 2p $DIRS) -type d -exec cp 9 {} \;
rm -f 9
rm -f $(sed -n 2p $DIRS)/9

echo "$(tput setaf 2)Copying descriptions$(tput sgr0)"
while read line; do
    if [[ $line == *"==>"* ]]; then
        buf=$line
    else
        echo "$line" >> `echo "$buf" | sed 's/==> //1; s/./dunnet\/rooms/1; s/ <==//1'`
    fi
done < $DESS

echo "$(tput setaf 2)Copying objects$(tput sgr0)"
while read line; do
    if [[ $line == *"==>"* ]]; then
        buf=$line
    else
        echo "$line" >> `echo "$buf" | sed 's/==> //1; s/./dunnet\/rooms/1; s/ <==//1'`
    fi
done < $OBJS

echo "$(tput setaf 2)Creating symbolic links$(tput sgr0)"
while read line; do
    local reverse=
    for word in $(echo $line); do
        reverse="$word $reverse"
    done
    # Use double quotes because we want the variable to be expanded first
    # Use number signs instead of slashes because $HOME contains slashes
    echo `echo $reverse | sed "s#~#$HOME#1"` | xargs ln -s
done < $SLKS

# Lock Computing Center by taking away the execute permissions
# The path is hard-coded
echo "$(tput setaf 2)Locking Computing Centers$(tput sgr0)"
chmod 666 dunnet/rooms/mistyRoom/e/e/n/w

echo "$(tput setaf 2)Creating symbolic link to rooms in home directory$(tput sgr0)"
ln -s `pwd`/dunnet/rooms ~/rooms
