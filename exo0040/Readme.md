# Pods web

## 1 - POD (po)

## 1.0 - Faire un fichier de définition d’un pod du projet [cheers](https://hub.docker.com/r/kanedafromparis/cheers/). ATTENTION à la version. Vous pouvez partir de [cheers.po.sample.yaml](cheers.po.sample.yaml)

### 1.1 - À l'aide du kubectl mapper le port 8080 du pod avec le port 8888 local pour tester l'application 

### 1.2 - En Navigant dans l'application, afficher les informations d'environement avec votre navigateur

### 1.3 - modifier le fichier pour ajouter une variable d'environnement EXO_4 à "1" et appliquer vos modifications. Vous pouves utiliser "kubectl explain Pod"

### 1.4 - verifier et la commande curl de validation

### 1.5 - (optionnel) Il est possible de récupérer des informations du pod pour renseigner les variables d'environnement. Modifier le fichier pour ajouter l'information de namespace et le nom du NODE sur lequel tourne le POD dans les variables d'environnement (respectivement KUBE_NAMESPACE et KUBE_NODE_NAME) et verifier à l'aide d'une commande curl de validation Vous pouvez vous aider du fichier [cheers.po.sample.015.yaml](cheers.po.sample.015.yaml) 

## 2 - Service (SVC)

### 2.1 - A l'aide de kubectl faire un fichier de définition d’un service exposant ce pod

### 2.2 - Modifier ce service pour l'exposer en NodePort

### 2.3 - verifier (optionnel : faire une commande curl de validation)

### 2.4 - supprimer ce service et le recrée exposé en NodePort en une seul commande

### 2.5 - verifier (optionnel : faire une commande curl de validation)
