Créer trois pv (en hostPath, sous minikube)
Créer un nginx partagent un volume
Faire un cronjob qui ajoute du text dans un fichier de ce partage
l’afficher depuis le ngnix

 $ kubectl apply -f nginx.pv.yaml
 $ kubectl apply -f nginx.deploy.svc.yaml

 $ PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
    && IP_NODE=$(minikube ip) \
    && curl -s $IP_NODE:$PORT_NODE/index.html

 $ ka document.feeder.cronjobs.yaml
 
  $ PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
    && IP_NODE=$(minikube ip) \
    && curl -s $IP_NODE:$PORT_NODE/index.html
 
    
Définir une classe de storage dynamique “foo”, avec un politique de rétention
l'appeler dans un replicatset redis de 4 replicat
supprimer les replicatset et regarder les comportements

  $ kubectl create configmap redis-conf --from-file=redis.conf

  $ ka foo.storageclass.yaml
  
  $ PORT_NODE=$(kubectl get svc -l app=redis -o json | jq -r .items[]?.spec.ports[0]?.nodePort) \
    && IP_NODE=$(minikube ip)
  
  (printf "PING\r\n";) | nc $IP_NODE $PORT_NODE 