#!/bin/sh

tar --file ~gholk/web/places.sqlite.tar \
    --append ~gholk/.mozilla/firefox/*.default/places.sqlite

