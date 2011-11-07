#!/bin/sh

SCRIPTDIR=`dirname $(readlink -f $0)`
DEF=$SCRIPTDIR/def.sh
LOCALDEF=$SCRIPTDIR/localdef.sh

. $DEF

if [ -f $LOCALDEF ]; then
    . $LOCALDEF
fi

PYTHON="/usr/bin/env python -W ignore::DeprecationWarning"

if [ -e $PIDFILE ]; then
    if kill -0 `cat $PIDFILE` > /dev/null 2>&1 ; then
    echo "django: $PROJECT already started"
    exit 0
    fi
    rm $PIDFILE
fi

cd $PROJDIR
$PYTHON ./manage.py runfcgi method=prefork maxrequests=1000 maxspare=3 minspare=2 maxchildren=3 daemonize=true socket=$SOCKET pidfile=$PIDFILE umask=002
sleep 3

if [ -e $PIDFILE ]; then
    if kill -0 `cat $PIDFILE` > /dev/null 2>&1 ; then
    echo "django: $PROJECT started"
    exit 0
    fi
fi

echo "django: $PROJECT NOT started"
