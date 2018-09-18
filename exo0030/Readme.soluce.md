

Installer minikube

 $ # cf. https://github.com/kubernetes/minikube#installation
 $ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/


lancer la console

  $ minikube dashboard

lister les version de kubernetes possibles

  $ minikube get-k8s-versions

lister les add-ons

  $ minikube addons list
