
# Test des sondes

## 1 - L'objectif est de faire verifier le comportement de de kubernetes en regards des sondes liveness et readiness

### 1.1 - Modifier le fichier [rms-1.2.deploy.svc.sample.000.yaml](rms-1.2.deploy.svc.sample.000.yaml) pour que la sonde livenessProbe test au bout de 15 secondes le container toutes les 3 secondes, attende 1 secondes avant de statuer sur le success ou l'echec et, enfin, qu'elle attende 1 success et authorise 3 échecs.

### 1.2 - Crée la ressources deploy rsm à l'aide du fichier ainsi obtenu puis 

#### 1.2.1 - Dans un terminal (1) ce mettre a l'ecoute des évenements du namespace courant

#### 1.2.2 - Dans un terminal (2) monitorer les mouvement des Pods de ce deploy 

#### 1.2.3 - Dans un terminal (3) monitorer les logs de vos Pod 

#### 1.2.4 - Dans un terminal (4) monitorer activé le ralentissement des réponses en faisant un curl sur "/api/1.0/probes/switchlowlivenessreadiness" de l'application

#### 1.2.5 - modifier la valeur de "SLOW_LIVENESS" pour la mettre a 20. Activé le ralentissement, que constatez-vous ?

### 1.2 - Modifier le fichier [rms-1.2.deploy.svc.sample.020.yaml](rms-1.2.deploy.svc.sample.020.yaml) pour que la sonde readinessProbe test au bout de 15 secondes le container toutes les 5 secondes, attende 5 secondes avant de statuer sur le success ou l'echec et, enfin, qu'elle attende 1 success et authorise 5 échecs.

### 1.2 - si ce n'est pas fait, crée la ressources deploy rsm à l'aide du fichier  obtenu puis 

#### 1.2.1 - Dans un terminal (1) ce mettre a l'ecoute des évenements du namespace courant

#### 1.2.2 - Dans un terminal (2) monitorer les mouvement des Pods de ce deploy 


#### 1.2.3 - Dans un terminal (3) monitorer les logs de vos Pod 

#### 1.2.4 - Dans un terminal (4) monitorer activé le ralentissement des réponses en faisant un curl sur "/api/1.0/probes/switchlowlivenessreadiness" de l'application

#### 1.2.5 - modifier la valeur de "SLOW_READINESS" pour la mettre a 50. Activé le ralentissement, que constatez-vous ?

#### 1.3 - (optionnel) modifier la valeur de "SLOW_READINESS" pour la mettre à la une seconde de la borne d'echec, puis activé le ralentissement pour la sonde readiness regarder l'impact, puis activé le ralentissement pour la sonde readiness regarder l'impactles deux sonde. Que constatez-vous ?
