#!/bin/bash
gitdir="emaildeliveryresponse"
devdir="emaildelivery"
cd "/home/mailxpert/github/"+$gitdir

pwd
rsync -ravu --progress --exclude-from='rsync/rsync-exclude-file.txt' /var/www/$devdir/ .
