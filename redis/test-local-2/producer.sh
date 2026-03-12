#!/bin/bash

# ===== Variables =====
queue_name="mafile"
burst_size=1000
pause_time=3

redis-cli DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connection avec le serveur redis!"
    exit 1
fi

while :
do
    for ((i=0;i<burst_size;i++))
    do
        redis-cli LPUSH $queue_name $RANDOM >/dev/null
    done

    taille=$(redis-cli --raw LLEN $queue_name)
    echo "Taille actuelle de la file : $taille"

    sleep $pause_time
done
