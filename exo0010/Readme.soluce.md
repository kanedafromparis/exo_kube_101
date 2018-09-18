
Créer une image docker (de petite taille) avec nginx
 - mettre un page index.html avec 
  <html><head><title>Bonjour !</title></head><body><h1>nom.prenom</h1></body></html>
  
 $ TARGET_REPO=kaneda-k && docker build --rm -t $TARGET_REPO/nginx:ocp-0.1 . -f Dockerfile.nginx
 
 - l'exécuter avec un 256 de ram et 500 micro-cpu sur le port 8877 de la machine
 
 $ TARGET_REPO=kaneda-k &&  docker run -m 256M --cpu-quota=5000 -d -p 8877:8080 $TARGET_REPO/nginx:ocp-0.1
 $ curl -I http://$(minikube ip):8877 && curl -I http://$(minikube ip):8877
 
 - identifier via inspect /jq la date de création, les port exposés et l’adress ip interne
 
 $ #docker inspect $(docker ps -q -n 1) | jq . | less
 $ docker inspect $(docker ps -q -n 1) | jq .[]."Created"
 $ docker inspect $(docker ps -q -n 1) | jq .[]."NetworkSettings"."Ports"
 $ docker inspect $(docker ps -q -n 1) | jq .[]."NetworkSettings"."IPAddress"
 
 - Pousser cette image dans votre repository (docker-hub)

 $ # docker login
 $ docker push $TARGET_REPO/nginx:ocp-0.1
 
 - Faire un “one-liner” qui démarre cette image docker sur un port aléatoire vérifie que le serveur est lancé
 
 # 
 $ TARGET_REPO=kaneda-k &&  docker run -u 1056:0 -m 256M --cpu-quota=5000 -d -p 8080 $TARGET_REPO/nginx:ocp-0.1; \
   && DK_HOSTPORT=`docker inspect $(docker ps -n 1 -q) | jq -r '.[0].NetworkSettings.Ports."8080/tcp"[0].HostPort'` \
   && DK_HOSTIP=`minikube ip` && curl -i http://$DK_HOSTIP:$DK_HOSTPORT
 
 - Faire un “one-liner” pour accéder en ligne de commande dans l’application

 $ docker exec -t -i $(docker ps --filter 'label=Name=ocp-nginx' -q) cat /etc/os-release

