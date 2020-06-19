#!/bin/sh
sudo chown -R daemon:daemon /app /tmp
exec $*
