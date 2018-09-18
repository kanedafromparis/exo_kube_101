
Créer une image docker (de petite taille) avec nginx
 - mettre un page index.html avec 
  <html><head><title>Bonjour !</title></head><body><h1>nom.prenom</h2></body></html>

 - l'exécuter avec un 256 de ram et 500 micro-cpu sur le port 8877 de la machine
 - identifier via inspect /jq la date de création, les port exposés et l’adress ip interne
 - Pousser cette image dans votre repository (docker-hub)
 - Faire un “one-liner” qui démarre cette image docker sur un port aléatoire vérifie que le serveur est lancé
 - Faire un “one-liner” pour accéder en ligne de commande dans l’application


