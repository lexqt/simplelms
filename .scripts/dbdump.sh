#/bin/sh

SCRIPTDIR=`dirname $(readlink -f $0)`
DEF=$SCRIPTDIR/def.sh
LOCALDEF=$SCRIPTDIR/localdef.sh

. $DEF

if [ -f $LOCALDEF ]; then
    . $LOCALDEF
fi

mkdir -p $PROJDIR/.db
echo "Dumping current state of database..."
mysqldump -u $MYSQL_USER -p$MYSQL_PASS --default-character-set=utf8 $MYSQL_DB > $PROJDIR/.db/dump.sql
chmod 644 $PROJDIR/.db/dump.sql
