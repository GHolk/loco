#!/bin/sh
user=gholk
cd /home/$user
rsync --rsh 'ssh -i .ssh/ccca-wiki-backup' \
      --update --archive --delete --verbose \
      --exclude '/data/cache/*' \
      $user@ccca.tw: data/ccca-wiki
