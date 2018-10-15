# Creation d'utilisateurs

L'objectif est de créer des utilisateur de leurs donners des droits (simple)

ATTENTION : pour l'exercice, remplacer "user" et "domain" par les valeurs adequates et $KUBE_DOMAIN et $USERVALUE pour la correction


## 1 - A l'aide d'openssl faire 3 certificats et des requests de validation (CSR):

### 1.1  - pour un utilisateur "user@domain" appartenant au group organisationnel (O) users

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user`
   $ `KUBE_DOMAIN=kaneda-k.net`
   
   $ `openssl genrsa -out $USERVALUE.key 2048`
   $ `openssl req -new -key $USERVALUE.key -out $USERVALUE.csr -subj "/CN=$USERVALUE@$KUBE_DOMAIN/O=users"`
  

### 1.2  - pour un utilisateur "user-admin@domain" appartenant au group organisationnel (O) admin et (O) devops

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user-admin`
   $ `KUBE_DOMAIN=kaneda-k.net`
   
   $ `openssl genrsa -out $USERVALUE.key 2048`
   $ `openssl req -new -key $USERVALUE.key -out $USERVALUE.csr -subj "/CN=$USERVALUE@$KUBE_DOMAIN/O=admin/O=devops"`


### 1.3  - pour un utilisateur "user-viewer@domain" appartenant au group organisationnel (O) reader

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user-viewer`
   $ `KUBE_DOMAIN=kaneda-k.net`
   
   $ `openssl genrsa -out $USERVALUE.key 2048`
   $ `openssl req -new -key $USERVALUE.key -out $USERVALUE.csr -subj "/CN=$USERVALUE@$KUBE_DOMAIN/O=reader"`

## 2. - Signature des certificats

   Ces commandes ont besoin de la clés du cluster, a priori celle-ce est sur le master

### 2.1  - A l'aide d'openssl, de la CA et de la cles de la CA, crée les certificats pour une durée de 10 jours

   $ `USERVALUE=user`
   $ `sudo openssl x509 -req -in $USERVALUE.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $USERVALUE.crt -days 10`

   $ `USERVALUE=user-admin`
   $ `sudo openssl x509 -req -in $USERVALUE.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $USERVALUE.crt -days 10`
   
   $ `USERVALUE=user-viewer`
   $ `sudo openssl x509 -req -in $USERVALUE.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $USERVALUE.crt -days 10`

### 2.2  - (optionnel) faire un zip ou 7z par user avec la CA et un mot de passe aléatoire de 9 signes

   $ `PSWD=$(echo -n $(pwgen -sB 9 -1)) && 7za a -p$PSWD $USERVALUE.7z ca.crt $USERVALUE.crt
     && echo "$USERVALUE:$PSWD" > user-pwd-tmp.txt`

   NB: on peux aussi envoyer directement le user-pwd.txt par mail et le supprimer du serveur

## 3 - Affectation des droits 

### 3.1  - Avec l'utilisateur admin de cluster, créer un namespace (ns) "ns-user" et rendez l'utilisateur "user@domain" admin de ce namespace (ns)

   $ `USERVALUE=user`
   $ `KUBE_DOMAIN=kaneda-k.net`
   $ `kubectl create ns ns-$USERVALUE;`
   $ `kubectl create rolebinding admin --clusterrole=admin --user=$USERVALUE@$KOPS_DOMAIN -n ns-$USERVALUE;`

### 3.2  - Avec l'utilisateur admin de cluster, créer un namespace (ns) "ns-user-admin" et rendez le group  "admin" admin du cluster

   $ `USERVALUE=user-admin`
   $ `KUBE_DOMAIN=kaneda-k.net`
   $ `kubectl create ns ns-$USERVALUE;`
   $ `kubectl create clusterrolebinding cluster-admin-$USERVALUE --clusterrole=admin --group=admin;`

   
### 3.3  - Avec l'utilisateur admin de cluster, render l'utilisateur "user-viewer" viewers du namespace (ns) "ns-user" 

   $ `USERVALUE=user-viewer`
   $ `USERNS=ns-user`
   $ `KUBE_DOMAIN=kaneda-k.net`
   $ `kubectl create rolebinding view --clusterrole=view --user=$USERVALUE@$KOPS_DOMAIN -n $USERNS;`


### 3.4  - (Optionnel) creer un namespace (ns) "playground", rendre les membres du groupes (O) "users" admin et les membres du groupes (O) "dev" viewers

   $ `kubectl create ns playground;`
   $ `kubectl create rolebinding admin --clusterrole=admin --group=users -n playground`
   $ `kubectl create rolebinding view --clusterrole=view --group=dev -n playground`

## 4 - Preparation de la navigation

### 4.1 - créer un fichier "exo-context" pour le cluster "domain"

   $ `touch exo-context;`

### 4.2 - créer avec le fichier "exo-context" comme configuration du context, un cluster pour "domain" (avec la CA du cluster, le dns de l'api...)

   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   
   $ `API_KUBE_DOMAIN=api.kaneda-k.net`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-cluster $KUBE_DOMAIN \
       --certificate-authority=$(pwd)/ca.crt \
       --embed-certs=true \
       --server=https://$API_KUBE_DOMAIN`

### 4.3 - créer avec le fichier "exo-context" comme configuration du context, un user user@domain (avec la CA du cluster, la key du certificat "user" et le certificat "user")

   On initialise la variable USERVALUE
   ATTENTION A UTILISER LES BONNES VALEURS

   $ `USERVALUE=user`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-credentials $USERVALUE \
       --client-certificate=$(pwd)/$USERVALUE.crt \
       --client-key=$(pwd)/$USERVALUE.key \
       --embed-certs=true`

### 4.4 - créer avec le fichier "exo-context" comme configuration du context, un user user-admin@domain (avec la CA du cluster, la key du certificat "user-admin" et le certificat "user-admin")

   On initialise la variable USERVALUE
   $ `USERVALUE=user-admin`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-credentials $USERVALUE \
       --client-certificate=$(pwd)/$USERVALUE.crt \
       --client-key=$(pwd)/$USERVALUE.key \
       --embed-certs=true`


### 4.5 - créer avec le fichier "exo-context" comme configuration du context, un user user-viewer@domain (avec la CA du cluster, la key du certificat "user-viewer" et le certificat "user-viewer")


   On initialise la variable USERVALUE
   $ `USERVALUE=user-viewer`

   $ `kubectl --kubeconfig=exo-context config set-credentials $USERVALUE \
       --client-certificate=$(pwd)/$USERVALUE.crt \
       --client-key=$(pwd)/$USERVALUE.key \
       --embed-certs=true`


## 5 - Navigation

### 5.1 - avec le "exo-context" comme configuration du context, créer un context "user-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user", y creer un deploy "nginx" de l'image "kanedafromparis/nginx:0.1"

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user`
   $ `KUBE_DOMAIN=kaneda-k.net`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-context --namespace=ns-$USERVALUE --cluster=$KUBE_DOMAIN --user=$USERVALUE $USERVALUE-in-ns-$USERVALUE && kubectl --kubeconfig=$(pwd)/exo-context config use-context $USERVALUE-in-ns-$USERVALUE`

   $ `kubectl --kubeconfig=$(pwd)/exo-context create deploy nginx --image=kanedafromparis/nginx:0.1`

### 5.2 - avec le "exo-context" comme configuration du context, créer un context "user-admin-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user-admin", y modifier le deploy "nginx" de l'image "kanedafromparis/nginx:0.1" pour avoir 3 replicas

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user`
   $ `USERADMINVALUE=$USERVALUE-admin`
   $ `KUBE_DOMAIN=kaneda-k.net`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-context --namespace=ns-$USERVALUE --cluster=$KUBE_DOMAIN --user=$USERADMINVALUE $USERADMINVALUE-in-ns-$USERVALUE && kubectl --kubeconfig=$(pwd)/exo-context config use-context $USERADMINVALUE-in-ns-$USERVALUE`

   $ `kubectl --kubeconfig=$(pwd)/exo-context scale deploy/nginx --replicas=3`


### 5.3 - avec le "exo-context" comme configuration du context, créer un context "user-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user", y modifier le deploy "nginx" de l'image "kanedafromparis/nginx:0.1" pour avoir 1 replicas

   On initialise la variable USERVALUE
   On initialise la variable KUBE_DOMAIN
   ATTENTION A UTILISER LES BONNES VALEURS
   $ `USERVALUE=user`
   $ `USERREADERVALUE=$USERVALUE-viewer`
   $ `KUBE_DOMAIN=kaneda-k.net`

   $ `kubectl --kubeconfig=$(pwd)/exo-context config set-context --namespace=ns-$USERVALUE --cluster=$KUBE_DOMAIN --user=$USERREADERVALUE $USERREADERVALUE-in-ns-$USERVALUE && kubectl --kubeconfig=$(pwd)/exo-context config use-context $USERREADERVALUE-in-ns-$USERVALUE`

   $ `kubectl --kubeconfig=$(pwd)/exo-context get all`
   $ `kubectl --kubeconfig=$(pwd)/exo-context scale deploy/nginx --replicas=1`





