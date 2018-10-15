
lancer l’application cheers (kanedafromparis/cheers:0.0x)
 - faire 20 jobs (avec 5 en parallèle) qui remplissent l’application de valeur aléatoire)

  $ kubectl run cheers --image=kanedafromparis/cheers:0.0.2 --replicas=1 --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy cheers --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=cheers -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip)
 
  $ kubectl apply -f 2-fill-injobs.yaml
 
  $ watch -n 2 kubectl get po
     
     
     
     
curl "http://$IP_NODE:$PORT_NODE/api/1.0/cheers" \
    -H 'Accept-Encoding: gzip, deflate' \
    -H 'Accept-Language: en-US,en;q=0.9' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -H 'Accept: application/json, text/plain, */*' \
    -H 'X-Requested-With: XMLHttpRequest' \
    -H 'Connection: keep-alive' \
    --data-binary '{"intro":"I am a big fan","cause":"You R the best"}' --compressed