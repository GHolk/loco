#!/bin/sh
xhost +si:localuser:neckfree
sudo -u neckfree "$@"
xhost -si:localuser:neckfree
