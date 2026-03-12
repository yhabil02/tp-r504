#!/bin/bash

# ===== Variables =====
queue_name="mafile"
threshold=30000
delay_process=4
wait_empty=2

# ===== Vérification connexion Redis =====
redis-cli DBSIZE >/dev/null
if ! [ $? = 0 ]
then
    echo "Erreur, pas de connection avec le serveur redis!"
    exit 1
fi

# ===== Boucle infinie =====
while :
do
    nb=$(redis-cli --raw LLEN $queue_name)

    if [ $nb -gt 0 ]
    then
        valeur=$(redis-cli --raw RPOP $queue_name)

        echo "Valeur lue : $valeur"

        if [ $valeur -gt $threshold ]
        then
            echo "ALARME ! valeur = $valeur"
            sleep $delay_process
        fi

    else
        echo "Liste vide, attente ${wait_empty}s."
        sleep $wait_empty
    fi
done
