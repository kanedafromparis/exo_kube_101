
# Créer une [image docker](Dockerfile) (de petite taille) avec nginx

NB: Dans cette exemple, j'utilise directement minikube comme host docker, J'utilise donc `eval $(minikube docker-env)` pour que docker communique avec le docker api de minikube puis `minikube ip` pour recupere l'adresse IP du host

 - on adapte [nginx.vh.default.conf](nginx.vh.default.conf) et [nginx.conf]

## 1 - mettre un page index.html avec 
  <html><head><title>Bonjour !</title></head><body><h1>nom.prenom</h1></body></html>
  
 $ `TARGET_REPO=kaneda-k &&\
     docker build \
     -t $TARGET_REPO/nginx:ocp-0.1 . \
     -f Dockerfile.nginx'
 
## 2 - l'exécuter avec un 256 de ram et 500 milli-cpu sur le port 8877 de la machine
 
 $ `TARGET_REPO=kaneda-k &&\

   docker run \
    -m 256M \
    --cpu-quota=500 \
    -d \
    -p 8877:8080 \
    $TARGET_REPO/nginx:ocp-0.1`
    
 On verifie que cela fonctionne correctement avec un curl
    
    
 $ `curl -I http://$(minikube ip):8877`
 
## 3 - identifier via inspect /jq la date de création, les port exposés et l’adress ip interne

NB : On présuppose que c'est la dernière instancier
     On récupere sa réference par $(docker ps -q -n 1)
     
     docker inspect $(docker ps -n 1 -q) 
     
     ou 
     
     CONTAINERID=`docker ps -n 1 -q` && docker inspect $CONTAINERID sont équivalent   
     
### pour parcourir les informations de l'instance docker 
 $ `docker inspect $(docker ps -q -n 1) | jq . | less `

### pour extraire l'attribut de la date de création

 $ `docker inspect $(docker ps -q -n 1) | jq .[]."Created" `

### pour extraire l'attribut Réseaux des port mapper
 $ `docker inspect $(docker ps -q -n 1) | jq .[]."NetworkSettings"."Ports"`

### pour extraire l'attribut de l'adresse interne

 $ `docker inspect $(docker ps -q -n 1) | jq .[]."NetworkSettings"."IPAddress"`
 
## 4 - Pousser cette image dans votre repository (docker-hub)

 $ docker login
 $ docker push $TARGET_REPO/nginx:ocp-0.1
 
## 5 - Faire un “one-liner” qui démarre cette image docker sur un port aléatoire vérifie que le serveur est lancé
 
 $ `TARGET_REPO=kaneda-k &&\
     docker run -u 1056:0 \
     -m 256M --cpu-quota=5000 \
     -d -p 8080 \
     $TARGET_REPO/nginx:ocp-0.1 \
   && \
     DK_HOSTPORT=`docker inspect $(docker ps -n 1 -q) | jq -r '.[0].NetworkSettings.Ports."8080/tcp"[0].HostPort'` \
   && DK_HOSTIP=`minikube ip` &&\
   curl -i http://$DK_HOSTIP:$DK_HOSTPORT`
 
## 6 - Faire un “one-liner” pour executer dans l’application une commande pour afficher les informations de release (selon la LSB)

 $ docker exec -t -i $(docker ps --filter 'label=Name=ocp-nginx' -q) cat /etc/os-release

