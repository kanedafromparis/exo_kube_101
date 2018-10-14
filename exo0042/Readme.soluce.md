
# Test des sondes

## 1 - L'objectif est de faire verifier le comportement de de kubernetes en regards des sondes liveness et readiness

### 1.1 - Modifier le fichier [rms-1.2.deploy.svc.sample.000.yaml](rms-1.2.deploy.svc.sample.000.yaml) pour que la sonde livenessProbe test au bout de 15 secondes le container toutes les 3 secondes, attende 1 secondes avant de statuer sur le success ou l'echec et, enfin, qu'elle attende 1 success et authorise 3 échecs.

   On obtient un fichier comme [rms-1.2.deploy.svc.011.yaml](rms-1.2.deploy.svc.011.yaml)

### 1.2 - Crée la ressources deploy rsm à l'aide du fichier ainsi obtenu puis 

   Dans un terminal on lance
   $ `kubectl apply -f rms-1.2.deploy.svc.011.yaml`


#### 1.2.1 - Dans un terminal (1) ce mettre a l'ecoute des évenements du namespace courant

   Dans un terminal on lance
   $ `kubectl get events -w`


#### 1.2.2 - Dans un terminal (2) monitorer les mouvement des Pods de ce deploy 

   Dans un terminal on lance
   $ `watch -n 2 kubectl get po -l run=rsm`


#### 1.2.3 - Dans un terminal (3) monitorer les logs de vos Pod 

   Dans un terminal on lance ~ 15 sec apres chaque deployment
   $ `kubectl logs -f $(kubectl get po -l run=rsm | grep Running | cut -d ' ' -f 1 | tail -n 1)`

   ou
   
   $ `kubetail -l run=rsm`


#### 1.2.4 - Dans un terminal (4) monitorer activé le ralentissement des réponses en faisant un curl sur "/api/1.0/probes/switchlowlivenessreadiness" de l'application

   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && gaeshi:exo0042 csabourdin$ curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowliveness`

#### 1.2.5 - modifier la valeur de "SLOW_LIVENESS" pour la mettre a 20. Activé le ralentissement, que constatez-vous ?

   On obtient un fichier comme [rms-1.2.deploy.svc.025.yaml](rms-1.2.deploy.svc.025.yaml) puis 
   Dans un terminal on lance
   $ `kubectl apply -f rms-1.2.deploy.svc.025.yaml`

   ou 
   
   $ `kubectl edit deploy rsm`

   puis 
   
   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowliveness`

   Normalement on constate qu'apres 3 evenements "Warning   Unhealthy   Pod   Liveness probe failed" que le container est relancé

### 1.2 - Modifier le fichier [rms-1.2.deploy.svc.sample.020.yaml](rms-1.2.deploy.svc.sample.020.yaml) pour que la sonde readinessProbe test au bout de 15 secondes le container toutes les 5 secondes, attende 5 secondes avant de statuer sur le success ou l'echec et, enfin, qu'elle attende 1 success et authorise 5 échecs.

   On obtient un fichier comme [rms-1.2.deploy.svc.021.yaml](rms-1.2.deploy.svc.021.yaml)

### 1.2 - si ce n'est pas fait, crée la ressources deploy rsm à l'aide du fichier  obtenu puis 

   Dans un terminal on lance
   $ `kubectl apply -f rms-1.2.deploy.svc.021.yaml`


#### 1.2.1 - Dans un terminal (1) ce mettre a l'ecoute des évenements du namespace courant

   Dans un terminal on lance
   $ `kubectl get events -w`


#### 1.2.2 - Dans un terminal (2) monitorer les mouvement des Pods de ce deploy 

   Dans un terminal on lance
   $ `watch -n 2 kubectl get po -l run=rsm`


#### 1.2.3 - Dans un terminal (3) monitorer les logs de vos Pod 

   Dans un terminal on lance ~ 15 sec apres chaque deployment
   $ `kubectl logs -f $(kubectl get po -l run=rsm | grep Running | cut -d ' ' -f 1 | tail -n 1)`

   ou
   
   $ `kubetail -l run=rsm`


#### 1.2.4 - Dans un terminal (4) monitorer activé le ralentissement des réponses en faisant un curl sur "/api/1.0/probes/switchlowlivenessreadiness" de l'application

   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowreadiness`

#### 1.2.5 - modifier la valeur de "SLOW_READINESS" pour la mettre a 50. Activé le ralentissement, que constatez-vous ?

   On obtient un fichier comme [rms-1.2.deploy.svc.025.yaml](rms-1.2.deploy.svc.025.yaml) puis 
   Dans un terminal on lance
   $ `kubectl apply -f rms-1.2.deploy.svc.025.yaml`

   ou 
   
   $ `kubectl edit deploy rsm`

   puis 
   
   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowreadiness`

   Normalement on constate qu'apres 5 evenements "Warning   Unhealthy   Pod   Readiness probe failed" que le container est relancé

 

#### 1.3 - (optionnel) modifier la valeur de "SLOW_READINESS" pour la mettre à la une seconde de la borne d'echec, puis activé le ralentissement pour la sonde readiness regarder l'impact, puis activé le ralentissement pour la sonde readiness regarder l'impactles deux sonde. Que constatez-vous ?

   On obtient un fichier comme [rms-1.2.deploy.svc.031.yaml](rms-1.2.deploy.svc.031.yaml) puis 
   Dans un terminal on lance
   $ `kubectl apply -f rms-1.2.deploy.svc.031.yaml`

   ou 
   
   $ `kubectl edit deploy rsm`

   puis 
   
   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowreadiness`

   Normalement on constate qu'il y a des "Warning   Unhealthy   Pod   Readiness probe failed" mais pas suffisement pour que le pod soit redemmarer.
   
   $ `PORT_NODE=$(kubectl get svc -l run=rsm -o json | jq -r .items[]?.spec.ports[]?.nodePort)      && IP_NODE=$(minikube ip) && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/probes/switchslowliveness`

   Normalement on constate egalement des "Warning   Unhealthy   Pod" mais pas necessairement suffisement pour que le pod soit redemmarer.
   ATTENTION ce test est assez relatif a la machine d'execusion et à la charge du node lors des tests.
   
 