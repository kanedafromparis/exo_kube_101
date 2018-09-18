Lancer un déploiement de "kanedafromparis/ressourcesmonger:1.0" avec 4 replicas
 - ouvrir ce service à l'extérieurs
 kubectl run rs --image=kanedafromparis/resourcesmonger:1.0 --replicas=1 --port=8080 --limits='cpu=200m,memory=256Mi' \
     && kubectl expose deploy rs --type=NodePort 
     
     
   $ while(true) ; do sleep 5 && curl $(minikube ip):$(kubectl get svc -l run=rs -o json | jq -r .items[]?.spec.ports[]?.nodePort)/api/1.0/kaboom/cpu; done

 
 - passer ce déploiement en autoscaling a 2 minimum et 4 max avec un cpu à 10%
 
 $ kubectl autoscale deploy rs --min=2 --max=4 --cpu-percent=10
 
 - regarder l’impact sur les pods
 
 $ watch -n 2 kubectl get po -l run=rs
 
 - scaller le déploiement à 8
 
 $ kubectl scale deploy rs --replicas=8
 
 - regarder l’impact sur les pods
 
 $ watch -n 2 kubectl get po -l run=rs
 
 - à l’aide de ab faire un teste de charge

 $ ab -k -c 10 -n 100 $(minikube ip):$(kubectl get svc -l run=rs -o json | jq -r .items[]?.spec.ports[]?.nodePort)/api/1.0/kaboom/cpu