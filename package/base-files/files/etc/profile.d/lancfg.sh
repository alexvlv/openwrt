#!/bin/sh

# $Id$
echo -n "LAN proto:["; uci get network.lan.proto  2>/dev/null | tr -d '\n'
echo -n "] IP:["; uci get network.lan.ipaddr 2>/dev/null | tr -d '\n'
echo "]"

