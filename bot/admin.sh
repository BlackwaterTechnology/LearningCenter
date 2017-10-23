#!/bin/bash
export ROCKETCHAT_URL=172.19.7.119:3001
export ROCKETCHAT_ROOM=''
export LISTEN_ON_ALL_PUBLIC=true
export ROCKETCHAT_USER=bot
export ROCKETCHAT_PASSWORD=321
export ROCKETCHAT_AUTH=password
./bin/hubot -a rocketchat
