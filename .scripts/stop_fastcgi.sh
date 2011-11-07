#!/bin/sh

SCRIPTDIR=`dirname $(readlink -f $0)`
DEF=$SCRIPTDIR/def.sh
LOCALDEF=$SCRIPTDIR/localdef.sh

. $DEF

if [ -f $LOCALDEF ]; then
    . $LOCALDEF
fi

PYTHON="/usr/bin/env python -W ignore::DeprecationWarning"

kill -9 `cat $PIDFILE`
rm $PIDFILE
