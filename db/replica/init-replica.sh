#!/bin/bash
set -e

echo "[init-replica] Waiting for db-master to be reachable..."
until mysqladmin ping -h db-master -uroot -p"$MYSQL_ROOT_PASSWORD" --silent; do
  sleep 2
done
echo "[init-replica] db-master is ready."

MASTER_STATUS=$(mysql -h db-master -uroot -p"$MYSQL_ROOT_PASSWORD" -e "SHOW MASTER STATUS\G")
LOG_FILE=$(echo "$MASTER_STATUS" | awk '/File:/{print $2}')
LOG_POS=$(echo  "$MASTER_STATUS" | awk '/Position:/{print $2}')
echo "[init-replica] Master log position: ${LOG_FILE} @ ${LOG_POS}"

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOF
STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='db-master',
  MASTER_USER='${MYSQL_REPLICATION_USER}',
  MASTER_PASSWORD='${MYSQL_REPLICATION_PASSWORD}',
  MASTER_LOG_FILE='${LOG_FILE}',
  MASTER_LOG_POS=${LOG_POS},
  GET_MASTER_PUBLIC_KEY=1;
START SLAVE;
EOF

echo "[init-replica] Replication configured and started."