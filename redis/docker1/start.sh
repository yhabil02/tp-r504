#!/bin/bash

# ===== Stopper tous les conteneurs en cours =====
echo "Arrêt des conteneurs en cours..."
docker stop $(docker ps -q) 2>/dev/null

# ===== Supprimer tous les conteneurs =====
echo "Suppression des conteneurs..."
docker rm $(docker ps -aq) 2>/dev/null

# ===== Créer un réseau Docker =====
echo "Création du réseau myredis..."
docker network create myredis 2>/dev/null || echo "Le réseau existe déjà."

# ===== Construire les images =====
echo "Construction de l'image du consumer..."
docker build -t img_cons -f Dockerfile_c .

echo "Construction de l'image du producer..."
docker build -t img_prod -f Dockerfile_p .

# ===== Lancer le serveur Redis =====
echo "Démarrage du serveur Redis..."
docker run -d \
  --network myredis \
  --name s_redis \
  redis:latest

# ===== Lancer le consumer =====
echo "Démarrage du consumer..."
docker run -d \
  --network myredis \
  --name s_cons \
  img_cons

# ===== Lancer le producteur =====
echo "Démarrage du producteur..."
docker run -d \
  --network myredis \
  --name s_prod \
  img_prod

echo "Tous les conteneurs sont lancés et connectés au réseau myredis."
