# Namespace et Navigation

Le but de cet exercices est de tester la gestion des namespace

## 1 - Navigation dans les NS

## 1.1 - Faire un fichier de définition de 5 namespace projet-001, projet-002, projet-003, projet-004, projet-005 [projet.ns.sample.011.yaml](projet.ns.sample.011.yaml).

### 1.2 - Appliquer le fichier  [nginx.list.sample.012.yaml](nginx.list.sample.012.yaml). Identifier ce qui a été crée, sans modifier le contexte avec "-n"

### 1.3 - Appliquer le fichier  [nginx.list.sample.012.yaml](nginx.list.sample.012.yaml). L'objectif sera d'identifier ce qui a été crée, sans utiliser "-n" ( modifier le contexte avec kubectl config ...)

### 1.3.1 - lancer les commandes `kubectl config set-context --namespace=projet-011 projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

### 1.3.2 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

### 1.3.3 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube --user=admin projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` regarder le message d'erreur

### 1.3.4 - (optionnel) lancer les commandes `kubectl config view` puis corriger la commande 'kubectl config set-context' precedente

### 1.3.5 - lancer les commandes `kubectl config set-context --namespace=projet-011 --cluster=minikube --user=minikube projet-011` puis `kubectl config use-context projet-011` puis la commande `kubectl get deploy` pour chacun des contextes. (Conseil : faire un script bash)
