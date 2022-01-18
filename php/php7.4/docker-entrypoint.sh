#!/bin/bash

printf "Starting FPM...\n\n"
set -e

/usr/local/php/sbin/php-fpm

exec "$@"