
Faire un fichier de définition d’un pod cheers, avec une variable d'environnement EXO_4 à "1", et la commande curl de validation

 $ kubectl run cheers --image=kanedafromparis/cheers:0.0.2 --env="EXO_4='1'" --replicas=1 --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy cheers --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=cheers -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \
     && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.[] | select(.name=="EXO_4") | .value'

     or
     
 $ kubectl apply -f cheers.deploy.svc.yaml \
     && kubectl expose deploy cheers --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=cheers -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \
     && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.[] | select(.name=="EXO_4") | .value'
     
Faire un pod avec deux conteneur, l’un qui écrit dans un dossier du node et l’autre qui affiche ce contenu

 $  kubectl apply -f fortune.po.yaml
 $  kubetail fortune

Lancer l’application resourcemonger 
 - tester les sondes

 # https://hub.docker.com/r/kanedafromparis/resourcesmonger/

 $ kubectl apply -f https://raw.githubusercontent.com/kanedafromparisfriends/resourcesmonger/master/src/main/kubernetes/rsm-ns.yaml \
     && kubectl apply -f https://raw.githubusercontent.com/kanedafromparisfriends/resourcesmonger/master/src/main/kubernetes/rsm-deploy.yaml \
     && kubectl apply -f https://raw.githubusercontent.com/kanedafromparisfriends/resourcesmonger/master/src/main/kubernetes/rsm-svc.yaml \
     && kubectl apply -f https://raw.githubusercontent.com/kanedafromparisfriends/resourcesmonger/master/src/main/kubernetes/rsm-hap.yaml
 
     && PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \

     curl -s http://$IP_NODE:$PORT_NODE/api/1.0/kaboom/cpu | jq .
 
     curl -s http://$IP_NODE:$PORT_NODE/api/1.0/kaboom/ram | jq .
 
 
 $ kubectl top 