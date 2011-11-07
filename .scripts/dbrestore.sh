#/bin/sh

SCRIPTDIR=`dirname $(readlink -f $0)`
DEF=$SCRIPTDIR/def.sh
LOCALDEF=$SCRIPTDIR/localdef.sh

. $DEF

if [ -f $LOCALDEF ]; then
    . $LOCALDEF
fi

echo "Restoring state of database from dump..."
mysql -u $MYSQL_USER -p$MYSQL_PASS --default-character-set=utf8 $MYSQL_DB < $PROJDIR/.db/dump.sql
