# Namespace et Navigation

Le but de cet exercices est de tester la gestion des namespace

## 1 - 

## 1.1 - Faire un fichier de définition de 5 namespace projet-001, projet-002, projet-003, projet-004, projet-005 [projet.ns.sample.011.yaml](projet.ns.sample.011.yaml).


    Il n'y a pas de version latest, il faut utiliser la version 

   On obtient un fichier commet [projet.ns.011.yaml](projet.ns.011.yaml)
   $ `kubectl apply -f projet.ns.011.yaml`

   On peut aussi passer plus vite avec 
   
   $ `for ...`
     
### 1.2 - Appliquer le fichier  [nginx.list.sample.012.yaml](nginx.list.sample.012.yaml). Identifier ce qui a été crée, sans modifier le contexte avec "-n"

   $ `kubectl apply -f projet.ns.011.yaml`
   
   $ `kubectl get all -n projet-011`
   
   On voit :
   1 - deployment.apps/nginx00X
   1 - replicaset.apps/nginx00X-XXXXXXXXX
   3 - pod/nginx001-XXXXXXXXX-XXXXX
   
   $ `kubectl get all -n projet-012`
   
   On voit :
   1 - deployment.apps/nginx00X
   1 - replicaset.apps/nginx00X-XXXXXXXXX
   2 - pod/nginx002-XXXXXXXXX-XXXXX

   $ `kubectl get all -n projet-013`
   
   On voit :
   1 - No resources found.

   $ `kubectl get all -n projet-014`
   
   On voit :
   3 - deployment.apps/nginx00X
   3 - replicaset.apps/nginx00X-XXXXXXXXX
   6 - pod/nginx001-XXXXXXXXX-XXXXX

   $ `kubectl get all -n projet-015`
   
   On voit :
   1 - No resources found.
   
### 1.3 - Appliquer le fichier  [nginx.list.sample.012.yaml](nginx.list.sample.012.yaml). L'objectif sera d'identifier ce qui a été crée, sans utiliser "-n" ( modifier le contexte avec kubectl config ...)

### 1.3.1 - lancer les commandes `kubectl config set-context --namespace=projet-011 projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

   $ `kubectl config set-context --namespace=projet-011 projet-011 && kubectl config use-context projet-011 && kubectl get deploy`

   On obtient le message suivant :
   "The connection to the server localhost:8080 was refused - did you specify the right host or port?"
   Car le cluster n'a pas été defini


### 1.3.2 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

   $ `kubectl config set-context --namespace=projet-011 --cluster=minikube projet-011 && kubectl config use-context projet-011 && kubectl get deploy`

   On obtient le message suivant :
   "Error from server (Forbidden): deployments.extensions is forbidden: User 'system:anonymous' cannot list deployments.extensions in the namespace 'projet-011'"
   Car aucun utilisateur n'a été defini

### 1.3.3 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube --user=admin projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

   $ `kubectl config set-context --namespace=projet-011 --cluster=minikube --user=admin projet-011 && kubectl config use-context projet-011 && kubectl get deploy`

   On obtient le message suivant :
   "Error from server (Forbidden): deployments.extensions is forbidden: User 'system:anonymous' cannot list deployments.extensions in the namespace 'projet-011'"
   Car l'utilisateur admin n'existe pas

### 1.3.4 - (optionnel) lancer les commandes `kubectl config view` puis corriger la commande 'kubectl config set-context' precedente

   $`kubectl config view -o json | jq .users[]?.name`
   retourne "minikube"
   la commande `kubectl config view -o json | jq .users[]` nous permets de voir l'emplacement des certificats client de cet utilisateur
   
### 1.3.5 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube --user=minikube projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` pour chacun des contextes. (Conseil : faire un script bash)

   $ `for i in {1..5}; do echo $i; kubectl config set-context --namespace=projet-01$i --cluster=minikube --user=minikube projet-01$i && kubectl config use-context projet-01$i && kubectl get deploy; done`

   