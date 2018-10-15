# PV manuelle

## 1 - 

### 1.1 - En utilisant le fichier [nginx.pv.sample.011.yaml](nginx.pv.sample.011.yaml) crée 3 PV (pv01rwx, pv02rwx,pv03rwx) de 1 Go en editable pas tous (ReadWriteMany), pensez a verifier les pv avec kubectl

   On obtient un fichier comme [nginx.pv.011.yaml](nginx.pv.011.yaml)
    
   $ `kubectl apply -f nginx.pv.011.yaml`

   $ `kubectl get pv`
   
   
### 1.2 - Toujours en s'inspirant du fichier [nginx.pv.sample.011.yaml](nginx.pv.sample.011.yaml) crée 3 PV (pv01rwo, pv02rwo,pv03rwo) de 1 Go en editable uniquement par un seul pod (ReadWriteOnce)


   On obtient un fichier comme [nginx.pv.012.yaml](nginx.pv.012.yaml)
    
   $ `kubectl apply -f nginx.pv.012.yaml`

   $ `kubectl get pv`
   

### 2.1 - En utilisant le fichier [nginx.pvc.sample.021.yaml](nginx.pvc.sample.021.yaml) crée un PersistentVolumeClaim "pvc01rwx" de 500 Mi en access mode ReadWriteMany

   On obtient un fichier comme [nginx.pvc.021.yaml](nginx.pvc.021.yaml)
    
   $ `kubectl apply -f nginx.pv.021.yaml`

   $ `kubectl get pvc`
   

### 2.2 - En utilisant le fichier [nginx.pvc.sample.021.yaml](nginx.pvc.sample.021.yaml) crée un PersistentVolumeClaim "pvc01rwo" de 500 Mi     en access mode ReadWriteOnce

   On obtient un fichier comme [nginx.pvc.022.yaml](nginx.pvc.022.yaml)
    
   $ `kubectl apply -f nginx.pvc.022.yaml`

   $ `kubectl get pvc`
   
### 3.1 - En utilisant le fichier [nginx.deploy.svc.sample.031.yaml](nginx.deploy.svc.sample.031.yaml) crée un deployment de 3 replicas tous utilisant le pvc rwx "pvc01rwx" du namespace

   On obtient un fichier comme [nginx.deploy.svc.031.yaml](nginx.deploy.svc.031.yaml)
    
   $ `kubectl apply -f nginx.deploy.svc.031.yaml`

   $ `kubectl get pvc`

### 3.2 - Supprimer le PVC "pvc01rwx" et regarder l'impact sur les PVC et les po
   
   $ `kubectl delete pvc pv01rwx`
   
   on constate que le PVC est en etat "pvc01rwx" Terminating, maisqu'il n'est pas supprimer.
   
### 3.3 - Downscaller le deploy "nginx" a 0 replicat et regarder l'impact sur les PVC et les po
   
   $ `kubectl scale deploy/nginx --replicas=0`
   
   on constate que le PVC a disparu.

### 3.4 - Modifier le deploy "nginx" pour le faire utiliser le PVC en RWO ("pvc01rwo"), puis passer les replicas a 3 et regarder l'impact sur les PVC et les po
   
   On obtient un fichier comme [nginx.deploy.svc.033.yaml](nginx.deploy.svc.033.yaml)
    
   $ `kubectl apply -f nginx.deploy.svc.033.yaml`

   $ `kubectl get pvc`
   
   