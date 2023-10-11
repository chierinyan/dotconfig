#!/bin/bash

# CS/EEE account, *NOT* Portal account
user=
pass=

# `UNIX / Linux Print Queue` field in
# https://intranet.cs.hku.hk/csintranet/contents/technical/info/hardware.jsp#printer
printer=hw312a

# Display name for your own reference, optional
name=HW312A-BW
location=HW


###########################
### DO NOT MODIFY BELOW ###
###########################

lpadmin -E \
    -p "$name" -L "$location" \
    -m drv:///sample.drv/generic.ppd \
    -o printer-is-shared=false -o PageSize=A4 -o Option1=True \
    -v "ipps://${user}:${pass}@print-server.cs.hku.hk:631/printers/${printer}" \
    -E
