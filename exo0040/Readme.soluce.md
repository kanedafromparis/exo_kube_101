# Pods web

## 1 - Faire un fichier de définition d’un pod du projet [cheers](https://hub.docker.com/r/kanedafromparis/cheers/).

    Il n'y a pas de version latest, il faut utiliser la version 

   le fichier est [cheers.po.000.yaml](cheers.po.000.yaml)
   $ `kubectl create -f cheers.po.000.yaml`

   On peut aussi passer plus vite avec 
   
   $ `kubectl run cheers --image=kanedafromparis/cheers:0.0.2 --env="EXO_4='1'" --replicas=1 --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy cheers --type=NodePort`
     
### 1.1 - mapper le port 8080 du pod avec le port 8888 local pour tester l'application 

   $ `kubectl port-forward pod/cheers 8888:8080`

### 1.2 - Afficher les informations d'environement avec votre navigateur

   Aller dans le navigateur sur [http://127.0.0.1:8888/assets/env.html](http://127.0.0.1:8888/assets/env.html)

### 1.3 - modifier le fichier pour ajouter avec une variable d'environnement EXO_4 à "1" et appliquer vos modifications

   On obtient un fichier comme [cheers.po.013.yaml](cheers.po.013.yaml)
   On remarquera que :
    
   $ `kubectl create -f cheers.po.013.yaml`

   et 
   
   $ `kubectl apply -f cheers.po.013.yaml`

   ne fonctionnent pas. Il faut d'abord supprimer le pod
   
   $ `kubectl delete po cheers && kubectl create -f cheers.po.013.yaml`
   
   Remarque : le delai de supression est un peu long, on peut le raccourcir avec "--grace-period=" ou en ayant mis en place l'attribut "  terminationGracePeriodSeconds dans la spec du pod (pour plus de detail : kubectl explain pod.spec.terminationGracePeriodSeconds).
   
   
### 1.4 - verifier et la commande curl de validation
   
   Dans un terminal on lance le port-forward.
   
   $ `kubectl port-forward pod/cheers 8888:8080`
   
   Dans un deuxieme terminal on fait un curl dont on filtre le resultat avec jq.
   
   $ `curl -s http://127.0.0.1:8888/api/1.0/infos/env | jq '.[] | select(.name=="EXO_4") | .value'`
   
   
### 1.5 - (optionnel) Il est possible de récupérer des informations du pod pour renseigner les variables d'environnement. Modifier le fichier pour ajouter l'information de namespace et le nom du NODE sur lequel tourne le POD dans les variables d'environnement (respectivement KUBE_NAMESPACE et KUBE_NODE_NAME) et verifier à l'aide d'une commande curl de validation Vous pouvez vous aider du fichier [cheers.po.sample.015.yaml](cheers.po.sample.015.yaml) 

   On obtient un fichier comme [cheers.po.015.yaml](cheers.po.015.yaml).
   
   $ `kubectl delete po cheers && kubectl create -f cheers.po.016.yaml`

   Dans un terminal on lance le port-forward.
   
   $ `kubectl port-forward pod/cheers 8888:8080`
   
   Dans un deuxieme terminal on fait un curl dont on filtre le resultat avec jq.
   
   $ `curl -s http://127.0.0.1:8888/api/1.0/infos/env | jq '.[] | select( .name | contains("KUBE_")) | (.name, .value)'`

## 2 - Service (SVC)

### 2.1 - A l'aide de kubectl faire un fichier de définition d’un service exposant ce pod

   $ `kubectl expose po cheers`

### 2.2 - Modifier ce service pour l'exposer en NodePort

   $ `kubectl edit svc cheers`

   Modifier type: ClusterIP en type: NodPort

### 2.3 - verifier (optionnel : faire une commande curl de validation)

   $ `curl -s http://$(minikube ip):$(kubectl get svc cheers -o json | jq .spec.ports[].nodePort)/api/1.0/randomcheers`

### 2.4 - supprimer ce service et le recrée exposé en NodePort en une seul commande

   $ `kubectl delete svc cheers && kubectl expose po cheers --type=NodePort`

### 2.5 - verifier (optionnel : faire une commande curl de validation)

   $ `curl -s http://$(minikube ip):$(kubectl get svc cheers -o json | jq .spec.ports[].nodePort)/api/1.0/randomcheers`
