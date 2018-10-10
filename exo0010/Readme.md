
#Créer une image docker (de petite taille) avec nginx

## 1 - mettre un page index.html avec 
  <html><head><title>Bonjour !</title></head><body><h1>nom.prenom</h2></body></html>

## 2 - l'exécuter en deamon avec un 256 de ram et 5000 milli-cpu sur le port 8877 de la machine

## 3 - identifier via inspect /jq la date de création, les port exposés et l’adress ip interne

## 4 - Pousser cette image dans votre repository (docker-hub) (optionnel)

## 5 - Faire un “one-liner” qui :
 - démarre cette image docker :
  - avec un user 1056 et group 0
  - avec 256M de Ram et 500 mico-cpu
  - en deamon
  - ouvert avec port aléatoire 
 - vérifie que le serveur est lancé

## 6 - Faire un “one-liner” pour executer dans l’application une commande pour afficher les informations de release (selon la LSB)

## 7 (optionel) 
