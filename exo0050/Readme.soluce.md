# Deployment et rollout

### 1.1 - Lancer un deployement avec 2 replicas a partir du Fichier [logsversion.deploy.sample.011.yaml](logsversion.deploy.sample.011.yaml)

   On obtient un fichier comme [logsversion.deploy.011.yaml](logsversion.deploy.011.yaml).

   $ `kubectl apply -f logsversion.deploy.011.yaml`


### 1.2 - Dans un autre terminal mapper un pod sur un port local "8888" et faire un test de version du services

   Pour obtenir la liste des Pods ayant le labels "run=logsversion"
   $ `kubectl get po -l run=logsversion --no-headers -o name`
   
   Pour obtenir un seul pod depuis la liste des Pods ayant le labels "run=logsversion"
   $ `kubectl get po -l run=logsversion --no-headers -o name | tail -n 1`
   
   Pour mapper le port d'un pod à un port de la machine client
   $ `kubectl port-forward logsversion-xxx-xxx-xxx 8888:8080`
 
   Pour faire tout cela d'une seul commande
   $ `kubectl port-forward $(kubectl get po -l run=logsversion --no-headers -o name | tail -n 1) 8888:8080`

### 1.3 - (Optionnel) Depuis la 1.10, on peux directement faite le mapping de port sur un deployment. Donc mapper le deployement sur un port local "8888". 

   $ `kubectl port-forward deploy/logsversion 8888:8080`

### 1.4 - Exposer le service en NodePort et dans un autre terminal surveiller l’évolution (watch) de la requete "/api/1.0/version/info" du deployment

   $ `watch -n 2 curl -s $(minikube ip):$(kubectl get svc -l run=logsversion -o json | jq -r .items[]?.spec.ports[]?.nodePort)/api/1.0/v
ersion/info`

### 1.5 - Dans un autre terminal surveiller l’évolution (watch) des pods de ce deployment

   $ `watch -n 2 kubectl get po -l run=logsversion`

   ou
   
   $ `kubectl get po -l run=logsversion --wacth`

### 1.5 - Dans un troisieme terminal surveiller l’évolution des logs des pods de ce deployment

   $ `$ kubetail -l run=logsversion`

### 1.6 - Augmenter le nombre de replicats a 5

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.016.yaml](logsversion.deploy.016.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.016.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on passe la commande "scale"
 
   $ `kubectl scale deploy/logsversion --replicas=5`
 
### 1.7 - Changer la version du container, c'est dire changer le label 1.0 en 2.0 et regarder l'impact sur les pods

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.017.yaml](logsversion.deploy.017.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.017.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:2.0"' | kubectl apply -f -`

   REMARQUE : Il faut parfois relancer le port-forward et kubetail -l run=logsversion pour prendre en compte les nouveaux pods

### 1.8 - Augmenter le nombre de réplicas à 6 et modifier la strategie de deploiement pour augmenter le nombre de pods de transition a 3 et regarder l'impact sur les pods
 
   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.018.yaml](logsversion.deploy.018.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.018.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.replicas=6'| jq '.spec.strategy.rollingUpdate.maxSurge=3' | kubectl replace -f -`


### 2.1 -  Faire passer la version du container à la version 3.0 et regarder l'impact sur les pods

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.021.yaml](logsversion.deploy.021.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.021.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.0"' | kubectl replace -f -`

### 2.2. -  Superviser les logs et faire passer la version du container de 3.0 à la version 3.1. 

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.022.yaml](logsversion.deploy.022.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.022.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.1"' | kubectl replace -f -`

### 2.3. -  Utiliser l'historique des deployments pour redeployer (undo) la version précédentes

   Pour consulter h'historique des deployments
   
   $ `kubectl rollout history deploy/logsversion`
   
   Pour revenir au deployment précedent
   
   $ `kubectl rollout undo deploy/logsversion`
   
### 2.4. -  Utiliser l'historique des deployments pour redeployer la version 1.0

   Pour revenir au deployment numero 1

   $ `kubectl rollout  undo deploy/logsversion --to-revision=1`

   Remarque le numero de la revision depend de vos opérations.
   On Remarque egalement qu'il y a 6 pod Running
   
### 3.1. -  deployer la version 2.0 mais avec un strategy Recreate et surveiller l’évolution (watch) des pods et  surveiller l’évolution (watch) de la requete "/api/1.0/version/info" du deployment 


   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.031.yaml](logsversion.deploy.031.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.031.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.1"' | kubectl replace -f -`

### 3.2. -  (Optionnel) deployer la version 3.2 mais avec un strategy Recreate et surveiller l’évolution (watch) des pods

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.032.yaml](logsversion.deploy.032.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.032.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`
   
   Soit on manipule le manifest json de la ressource avec jq
 
   $ `kubectl get deploy logsversion -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.2"' | kubectl replace -f -`

   On constate que l'image n'existe pas et qu'il ne peux donc pas 
### 3.3. -  (Optionnel) arrter ce deployment et revenir en arriere

   Pour arreter le deployment (bien qu'en Recreate il soit trop tard)
   $ `kubectl rollout pause deploy/logsversion`
   
   Pour revenir au deployment precedent 
   $ `kubectl rollout undo deploy/logsversion`
   
   Si on avait mis en pause le deployment
   $ `kubectl rollout resume deploy/logsversion && kubectl rollout undo deploy/logsversion`
   

### 3.4. -  (Optionnel) deployer la version 3.2 mais avec un strategy RollingUpdate et surveiller l’évolution (watch) des pods

   Soit on modifie le manifest et on obtient un fichier comme [logsversion.deploy.034.yaml](logsversion.deploy.034.yaml) puis on applique les modifications

   $ `kubectl apply -f logsversion.deploy.035.yaml`

   Soit on modifie le manifest de la ressource en ligne de commande

   $ ` kubectl edit deploy logsversion`

   On constate que le deployment ne passe pas mais qu'il n'y a pas d'interruption de service.
   
   Remaque : L'utilisation des sondes livenessProbs et readinessProbs sont egalement utiliser pour valider la migration
