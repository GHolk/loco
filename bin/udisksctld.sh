#!/bin/sh
command=$1
block_path=$2
udisksctl $command --block-device $block_path
