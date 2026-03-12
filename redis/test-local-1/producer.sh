#!/bin/bash

# ===== Variables =====
queue_name="mafile"
burst_size=1000
pause_time=3

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
    echo "Envoi d'un burst de $burst_size valeurs..."

    for ((i=0;i<burst_size;i++))
    do
        redis-cli LPUSH $queue_name $RANDOM >/dev/null
    done

    # Affichage taille de la file
    taille=$(redis-cli --raw LLEN $queue_name)
    echo "Taille actuelle de la file : $taille"

    echo "Pause de $pause_time secondes..."
    sleep $pause_time
done
