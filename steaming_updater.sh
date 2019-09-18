#!/bin/bash
# Author: inactive-virus <gigagerm@hotmail.com>
# Source: https://github.com/inactive-virus/steaming-updater

function error()
{
  echo 错误: "$@" >&2
  exit 1
}

function check()
{
  [ -n `which $1 2> /dev/null` ] && return 0
  [ -e "$1" ] || error "丢失文件 $1"
  [ -r "$1" ] || error "无法读取 $1"
}

function dump()
{
  [ -n "$1" ] && echo "$1" > $ROT/err_`date +"%Y-%m-%d %T"`.log
  [ -n "$2" ] && error "$2"
}

function load_plugin()
{
  check "$ROT/plugins/$1"
  source "$ROT/plugins/$1" && echo "载入 $1 插件"
}

ROT=$(dirname "$0")

source $ROT/updater.conf
[ -z "$LOGIN" ] && LOGIN=anonymous
[ -z "$STEAMCMD_BIN" ] && STEAMCMD_BIN=steamcmd
load_plugin "$1"
load_plugin "$2"

#main
  date +"%Y-%m-%d %T"
  check $STEAMCMD_BIN
  plugin_check
  # Update trials
  for i in {1..10}; do
    LOG=$($STEAMCMD_BIN +force_install_dir "$INSTALL_DIR" \
    +login "$LOGIN" \
    +app_update "$APP_ID" \
    +quit)
    echo "$LOG" | grep 'Success!' && break
    [ $i = "10" ] && dump "$LOG" '10次更新失败，取消操作'
  done
  # Restart when needed.
echo "$LOG" | grep 'fully installed' --silent && restart || echo '无需重启'
