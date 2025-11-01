#!/bin/bash
gitdir="emaildeliveryresponse"
devdir="emaildelivery"
cd "/home/mailxpert/github/"+$gitdir

rsync -ravu --progress --exclude-from='rsync/rsync-exclude-toprod.txt' /home/mailxpert/github/$gitdir/ /var/www/$devdir/
