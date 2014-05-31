#!/bin/bash
DEAMON=/var/www/heron.wechat/app.js
LOG=/var/log/forever/heron.wechat.log
PID=/root/.forever/pids/forever.pid

export PATH=$PATH:/usr/bin/node/bin
export NODE_PATH=$NODE_PATH:/usr/bin/node/lib/node_modules

node=node
forever=forever

case "$1" in
    start)
        $forever start -l $LOG --pidFile $PID -a $DEAMON
        ;;
    stop)
        $forever stop --pidFile $PID $DEAMON
        ;;
    stopall)
        $forever stopall --pidFile $PID
        ;;
    restartall)
        $forever restartall --pidFile $PID
        ;;
    reload|restart)
        $forever restart -l $LOG --pidFile $PID -a $DEAMON
        ;;
    list)
        $forever list
        ;;
    *)
        echo "Usage: /etc.init.d/node {start|stop|restart|reload|stopall|restartall|list}"
        exit 1
        ;;
esac