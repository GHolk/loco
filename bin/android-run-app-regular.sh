#!/bin/sh
activity_name="$1"
while sleep 5h
do
    am start -n "$activity_name"
done

