#!/bin/bash

LOG_DIR="monitoramento_servidor"
mkdir -p $LOG_DIR

grep -E "fail(ed)?|error|denied|unauthorized" /var/log/syslog | awk '{print $1, $2, $3, $5, $6, $7}' >  $LOG_DIR/monitoramento_logs_sistema.txt
