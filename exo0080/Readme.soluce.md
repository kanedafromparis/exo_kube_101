Définir des variables de ConfigMap et les vérifier dans cheers (ou resourcesmonger)

 $ kubectl run cheers --image=kanedafromparis/cheers:0.0.2 --replicas=1 \
     --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy cheers --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=cheers -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \
     && curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.'
     
     && kubectl create configmap sample-config --from-literal=sample='Grass looks green' --from-file=sample-env-file.properties
     
     ou
     
 $ kubectl apply -f cheers.deploy.svc.yaml
 
 $ curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.[] | select(.name=="SAMPLE_LITERAL")'
 $ curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.[] | select(.name=="EXO_8")'
 $ curl -s http://$IP_NODE:$PORT_NODE/api/1.0/infos/env | jq '.[] | select(.name=="MY_POD_SERVICE_ACCOUNT")'

Modifier les fichiers de configuration de votre nginx pour
 - ajouter un header 
…
  $ kubectl run nginx --image=kanedafromparis/nginx:0.3 --replicas=1 \
     --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy nginx --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \
     
  $ kubectl create configmap nginx-v-conf --from-file=nginx.vh.default.conf
  
  $ k edit deploy nginx
   #   volumeMounts:
   #   - mountPath: /etc/nginx/conf.d
   #     name: nginx-v-conf
   #     readOnly: true
   # 
   #  ...
   #  
   # volumes:
   # - name: nginx-v-conf
   #   configMap:
   #     defaultMode: 0555
   #     name: nginx-v-conf
   # 
  $ PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort)  \
      && IP_NODE=$(minikube ip) \
      && curl -s -I http://$IP_NODE:$PORT_NODE/ | grep X-kaneda-header
 - remplacer l’index.html
 
 $ PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
    && IP_NODE=$(minikube ip) \
    && curl -s  http://$IP_NODE:$PORT_NODE/ | grep h1

   $ k edit deploy nginx
   #   volumeMounts:
   #   - mountPath: /var/www/localhost/htdocs
   #     name: sample-index-html
   #     readOnly: true
   # 
   #  ...
   #  
   # volumes:
   # - name: sample-index-html
   #   configMap:
   #     defaultMode: 0555
   #     name: sample-index-html
   # 
 
Créer des secrets avec la configuration ngnix des sous domaines
Créer des certificats auto-signés dans un secret et utilisez-les pour les configurations de votre pod nginx

 $ openssl dhparam -out dh.pem 2048
 $ openssl req -x509 -nodes -days 10 -newkey rsa:2048 -keyout nginx-selfsigned.key -out nginx-selfsigned.crt
 $ kubectl create configmap nginx-v-ssl-conf --from-file=nginx.vh.default.ssl.conf
 $ kubectl create secret generic nginx-v-dhparam --from-file=dh.pem
 $ kubectl create secret tls nginx-selfsigned --cert=nginx-selfsigned.crt --key=nginx-selfsigned.key

  $ k edit deploy nginx
    #
   #         volumeMounts:
   #         - mountPath: /etc/nginx/conf.d
   #           name: nginx-v-conf
   #           readOnly: true
   #         - mountPath: /var/www/localhost/htdocs
   #           name: sample-index-html
   #           readOnly: true
   #         - mountPath: /etc/nginx/ssl/domain
   #           name: nginx-selfsigned
   #           readOnly: true
   #         - mountPath: /etc/nginx/dh
   #           name: nginx-v-dhparam
   #           readOnly: true
   #
   #
   # ...
   #      volumes:
   #      - configMap:
   #          defaultMode: 365
   #          name: nginx-v-ssl-conf
   #        name: nginx-v-conf
   #      - configMap:
   #          defaultMode: 365
   #          name: sample-index-html
   #        name: sample-index-html
   #      - name: nginx-v-dhparam
   #        secret:
   #          defaultMode: 420
   #          secretName: nginx-v-dhparam
   #      - name: nginx-selfsigned
   #        secret:
   #          defaultMode: 420
   #          secretName: nginx-selfsigned
   #   #



// kex nginx-5f966768cc-sctn2 sh
// krmsec -l run=nginx