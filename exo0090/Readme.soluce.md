Déployer une base de donné (mysql)
Faire cronjob qui remplit toutes le 10 sec cette base de nom aléatoire
# Faire job qui envois un mail avec le nombre d’entrée dans cet base 


 $ kubectl apply -f mysql.deploy.svc.yaml
 

 $ kubectl exec $(kubectl get po -l app=mysql --no-headers | cut -d " " -f 1) -it bash
 $ kubectl exec $(kubectl get po -l app=mysql --no-headers | cut -d " " -f 1) -it -- bash -c "echo \"--\" \
       && echo \"mysql -h \$MYSQL_SERVICE_HOST -P \$MYSQL_PORT_3306_TCP_PORT -u \$MYSQL_USER -p\$MYSQL_PASSWORD \$MYSQL_DATABASE\" \
       && echo \"--\" \
       && echo \"mysql -h \$MYSQL_SERVICE_HOST -P \$MYSQL_PORT_3306_TCP_PORT -u root -p\$MYSQL_ROOT_PASSWORD \$MYSQL_DATABASE\" \
       && echo \"--\" \
       && echo \"mysql -h \$MYSQL_SERVICE_HOST -P \$MYSQL_PORT_3306_TCP_PORT -u root -p\$MYSQL_ROOT_PASSWORD mysql\"" 

       
 $ kubectl run -i -t --rm ephemeral --image='mysql:5.6' -- /bin/sh -l
    $ mysql -h xx -P xx -u xx -xx exo009 --execute="CREATE TABLE cron (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,SENTENCE VARCHAR(30) NOT NULL,REG_DATE TIMESTAMP);"
    $ mysql -h xx -P 3306 -u x -pxx exo009 --execute="INSERT INTO cron (SENTENCE,REG_DATE) VALUES ('test',NOW());"
    $ mysql -h xx -P xx -u xx -pxx exo009 --execute="SELECT * FROM cron;"

 $ kubectl apply -f mysql.feeder.cronjobs.yaml
 
Faire un job de fitz buzz
 $ kubectl create configmap fizzbuz --from-file=fizzbuz.sh
 $ kubectl apply -f fizzbuz.jobs.yaml
 $ kg po -a
 
 $ kubectl logs $(kubectl get po -l run=fizzbuz -a --no-headers | cut -d " " -f 1)
 
 


kubectl run nginx --image=kanedafromparis/nginx:0.3 --replicas=1 --port=8080 --limits='cpu=100m,memory=256Mi' \
     && kubectl expose deploy nginx --type=NodePort \
     && PORT_NODE=$(kubectl get svc -l run=nginx -o json | jq -r .items[]?.spec.ports[]?.nodePort) \
     && IP_NODE=$(minikube ip) \
     && curl -s http://$IP_NODE:$PORT_NODE/ | jq '.'