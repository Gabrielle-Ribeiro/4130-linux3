#!/bin/bash

LOG_DIR="monitoramento_servidor"
mkdir -p $LOG_DIR


function monitorar_logs() {
        grep -E "fail(ed)?|error|denied|unauthorized" /var/log/syslog | awk '{print $1, $2, $3, $5, $6, $7}' >  $LOG_DIR/monitoramento_logs_sistema.txt
        grep -E "fail(ed)?|error|denied|unauthorized" /var/log/auth.log | awk '{print $1, $2, $3, $5, $6, $7}' >  $LOG_DIR/monitoramento_logs_auth.txt
}


function monitorar_conectividade() {
        if ping -c 1 8.8.8.8 > /dev/null; then
                echo "$(date): Conectividade ativa" >> $LOG_DIR/monitoramento_rede.txt
        else
                echo "$(date): Sem conexão com a internet" >> $LOG_DIR/monitoramento_rede.txt
        fi


        if curl -s --head https://www.alura.com.br/ | grep "HTTP/2 200" > /dev/null; then
                echo "$(date): Conexão com a Alura bem-sucedida" >> $LOG_DIR/monitoramento_rede.txt
        else
                echo "$(date): Falha ao conectar com a Alura" >> $LOG_DIR/monitoramento_rede.txt
        fi
}

function executar_monitoramento() {
    monitorar_logs
    monitorar_conectividade
}

executar_monitoramento