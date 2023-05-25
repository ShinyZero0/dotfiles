#!/usr/bin/env bash

discache=~/.cache/discord_cache/
mkdir -p $discache
cd $discache
curr_image=$(echo "$1" | sed "p;s/\//-/g" | sed "N;s/\n/ -O /")
echo "$curr_image" | xargs wget -nc -q 
echo "$curr_image" | sed "s/.*-O //" | xargs imv -
