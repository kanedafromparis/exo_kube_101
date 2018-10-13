

## Minikube 
## 0 - Installer minikube

 cf. https://github.com/kubernetes/minikube#installation
 $ `curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

 - Si ce n'est pas fait, installer le client-docker (par la release apt-get install docker.io) 
 - Si vous etes dans une VM (virtualbox, ec2,...) , utiliser '--vm-driver "none"', l'experience utilisateurs est moins bonne, mais reste simple et facilite la prise en main dans kubernetes.
 - Il peux etre utile d'augmenter les ressources de votre minikube :
 `minikube stop`
 `minikube config set cpus 4`
 `minikube config set memory 4096`
 
 ATTENTION, le demarrage peu etre un peu long
 minikube ssh
 
## 1 - lancer la console web (dashboard)

  $ `minikube dashboard`

## 3 - lister les service et identifier les ports d'utilisation

  $ `minikube service list`
  
## 4 - afficher l'ip de votre instance

  $ `minikube ip`

## 5 - lister les add-ons

  $ `minikube addons list`
  
## 6 - mettre a jour vos variables d'environement pour utiliser le serveur docker de minikube 
  $ `eval $(minikube docker-env)`
  $ docker ps