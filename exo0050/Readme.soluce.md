

https://github.com/kanedafromparisfriends/logversion


Lancer un déploiement de "kanedafromparis/logversion:1.0" avec 2 replicas

 $ kubectl run logs --image=kanedafromparis/logversion:1.0 --replicas=2 --port=8080 --limits='cpu=100m,memory=256Mi' 

 - dans un autre terminal mapper le service sur un port local et faire un test de version du services
 $ kubectl port-forward $(kubectl get po -l run=logs --no-headers | cut -d " " -f 1 | tail -n 1) 8080:8888
 
 $ curl 127.0.0.1:8888/api/1.0/version/info
 
 - surveiller l’évolution des pods
 
 $ watch -n 2 kubectl get po
 ou
 $ kubectl get po --wacth
 
 - afficher les logs des pods
 
 $ kubetail -l run=logs
 
 - passer le nombre de réplicas à 5
 
 $ kubectl scale deploy/logs --replicas=5
 
 - passer la version du container à la 2.0
 
 $ kubectl get deploy logs -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:2.0"' | kubectl replace -f -
 
 // kubectl rollout status deploy logs
 
 - passer le nombre de réplicas à 6 et modifier la strategie de deploiement
   - Augmenter le nombre de pods de transition a 3 
 
 $ kubectl get deploy logs -o json | jq '.spec.replicas=6'| jq '.spec.strategy.rollingUpdate.maxSurge=3' | kubectl replace -f -
   
 - passer la version du container à la 3.0
 
 $ kubectl get deploy logs -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.0"' | kubectl replace -f -
 
 - passer la version du container à la 3.1
 
 $ kubectl get deploy logs -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.1"' | kubectl replace -f -

 - lister l'historique des rollouts
 
 $ kubectl rollout history deploy/logs
 
 - passer la version du container à la 3.2

  $ kubectl get deploy logs -o json | jq '.spec.template.spec.containers[0].image|="kanedafromparis/logversion:3.1"' | kubectl replace -f -

   - faire un retour arrière (passer a la generatation 4)

   $ kubectl rollout deploy/logs
   $ kubectl scale deploy/logs --replicas=6

 - ouvert l’application à l'extérieur
 
 $ kubectl expose deploy/logs --type=NodePort
 
 - Modifier les sondes
   - sur liveness et tester l’application depuis l'extérieurs
   
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
            httpHeaders:
            - name: X-Custom-Header
              value: Awesome
        initialDelaySeconds: 3
        timeoutSeconds: 10
        periodSeconds: 2
        failureThreshold: 5
        successThreshold: 1
   
   $ while(true) ; do sleep 5 && curl $(minikube ip):$(kubectl get svc -l run=logs -o json | jq -r .items[]?.spec.ports[]?.nodePort)/healthz; done
   
   $ 
   - sur readiness et tester l’application depuis l'extérieurs

        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
            httpHeaders:
            - name: X-Custom-Header
              value: Awesome
        initialDelaySeconds: 3
        timeoutSeconds: 10
        periodSeconds: 2
        failureThreshold: 5
        successThreshold: 1
        
 - Modifier 
   - la stratégie en "Recreate"
   - supprimer les sondes liveness
 - tester l’application depuis l'extérieurs
 
  $ while(true) ; do sleep 5 && curl $(minikube ip):$(kubectl get svc -l run=logs -o json | jq -r .items[]?.spec.ports[]?.nodePort)/healthz; done

   - Modifier la version en 3.2
 - tester l’application depuis l'extérieurs

 $ while(true) ; do sleep 5 && curl $(minikube ip):$(kubectl get svc -l run=logs -o json | jq -r .items[]?.spec.ports[]?.nodePort)/healthz; done
 
 - faire une rollout sur la version 3 puis un rollout par défaut


