#!/bin/bash
# For RedHat and cousins:
# chkconfig: 2345 85 85
# description: Red5 flash streaming server
# processname: red5
# Created By: Sohail Riaz (sohaileo@gmail.com)

PROG=red5
RED5_HOME=/usr/local/red5
DAEMON=$RED5_HOME/$PROG.sh
PIDFILE=/var/run/$PROG.pid

# Source function library
. /etc/rc.d/init.d/functions

[ -r /etc/sysconfig/red5 ] && . /etc/sysconfig/red5

RETVAL=0

case "$1" in
start)
echo -n $"Starting $PROG: "
cd $RED5_HOME
$DAEMON >/dev/null 2>/dev/null &
RETVAL=$?
if [ $RETVAL -eq 0 ]; then
echo $! > $PIDFILE
touch /var/lock/subsys/$PROG
fi
[ $RETVAL -eq 0 ] && success $"$PROG startup" || failure $"$PROG startup"
echo
;;
stop)
echo -n $"Shutting down $PROG: "
killproc -p $PIDFILE
RETVAL=$?
echo
[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$PROG
;;
restart)
$0 stop
$0 start
;;
status)
status $PROG -p $PIDFILE
RETVAL=$?
;;
*)
echo $"Usage: $0 {start|stop|restart|status}"
RETVAL=1
esac

exit $RETVAL

red5.txt

9 of 10
