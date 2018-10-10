

## Minikube 
## 0 - Installer minikube

 cf. https://github.com/kubernetes/minikube#installation
 $ `curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

 - Si ce n'est pas fait, installer docker (par la release apt-get install docker.io) 
 - Si vous etes dans une VM (virtualbox, ec2,...) , utiliser '--vm-driver "none"', l'experience utilisateurs est moins bonne, mais reste simple et facilite la prise en main dans kubernetes.

## 1 - lancer la console web (dashboard)

  $ `minikube dashboard`

## 2 - lister les version de kubernetes possibles

  $ `minikube get-k8s-versions`


## 3 - lister les service et identifier les ports d'utilisation

  $ `minikube service list`
  
## 4 - afficher l'ip de votre instance

  $ `minikube ip`

## 5 - lister les add-ons

  $ `minikube addons list`
