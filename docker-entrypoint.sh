#!/bin/sh
chown -R daemon:daemon /app /tmp
exec sudo -u daemon -g daemon $*
