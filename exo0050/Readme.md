# Deployment et rollout

### 1.1 - Lancer un deployement avec 2 replicas a partir du Fichier [logsversion.deploy.sample.011.yaml](logsversion.deploy.sample.011.yaml)

### 1.2 - Dans un autre terminal mapper un pod sur un port local "8888" et faire un test de version du services

### 1.3 - (Optionnel) Depuis la 1.10, on peux directement faite le mapping de port sur un deployment. Donc mapper le deployement sur un port local "8888". 

### 1.4 - Exposer le service en NodePort et dans un autre terminal surveiller l’évolution (watch) de la requete "/api/1.0/version/info" du deployment


### 1.5 - Dans un autre terminal surveiller l’évolution (watch) des pods de ce deployment

### 1.5 - Dans un troisieme terminal surveiller l’évolution des logs des pods de ce deployment

### 1.6 - Augmenter le nombre de replicats a 5
 
### 1.7 - Changer la version du container, c'est dire changer le label 1.0 en 2.0 et regarder l'impact sur les pods

### 1.8 - Augmenter le nombre de réplicas à 6 et modifier la strategie de deploiement pour augmenter le nombre de pods de transition a 3 et regarder l'impact sur les pods

### 2.1 -  Faire passer la version du container à la version 3.0 et regarder l'impact sur les pods

### 2.2. -  Superviser les logs et faire passer la version du container de 3.0 à la version 3.1. 

### 2.3. -  Utiliser l'historique des deployments pour redeployer (undo) la version précédentes

### 2.4. -  Utiliser l'historique des deployments pour redeployer la version 1.0

### 3.1. -  deployer la version 2.0 mais avec un strategy Recreate et surveiller l’évolution (watch) des pods et  surveiller l’évolution (watch) de la requete "/api/1.0/version/info" du deployment 

### 3.2. -  (Optionnel) deployer la version 3.2 mais avec un strategy Recreate et surveiller l’évolution (watch) des pods

### 3.3. -  (Optionnel) arrter ce deployment et revenir en arriere

### 3.4. -  (Optionnel) deployer la version 3.2 mais avec un strategy RollingUpdate et surveiller l’évolution (watch) des pods
