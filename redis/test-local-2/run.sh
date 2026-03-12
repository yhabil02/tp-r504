#!/bin/bash

# ===== Variables =====
max_consumers=5
iter=0
oldnb=0         
TERM="gnome-terminal"

# ===== Lancer le producteur dans un nouveau terminal =====
$TERM --title PRODUCER -- ./producer.sh &

# ===== Boucle infinie de monitoring =====
while :
do
    # ===== Affichage du nombre de jobs consommateurs en cours =====
    nbjobs=$(jobs | grep Running | wc -l)
    echo "Nb jobs en cours: $nbjobs"

    # ===== Taille actuelle de la file =====
    nb=$(redis-cli LLEN mafile)
    iter=$((iter+1))
    echo "-iter $iter, taille liste=$nb"

    # ===== Auto-adaptation : lancer un consumer si la file a grossi =====
    if [ $nb -gt $oldnb ] && [ $nbjobs -lt $max_consumers ]
    then
        ./consumer.sh &  
    fi

    oldnb=$nb
    sleep 3
done

"La stratégie actuelle lance un consumer à chaque petite augmentation de la file, ce qui peut créer trop de processus et saturer le système. Une meilleure approche consiste à lancer un consumer uniquement si la file dépasse un seuil critique et que le nombre de consumers actifs reste inférieur à un maximum, assurant une adaptation stable et efficace.
