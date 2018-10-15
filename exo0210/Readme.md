# Creation d'utilisateurs


## 1 - A l'aide d'openssl faire 3 certificats et des requests de validation (CSR):

### 1.1  - pour un utilisateur "user@domain" appartenant au group organisationnel (O) users

### 1.2  - pour un utilisateur "user-admin@domain" appartenant au group organisationnel (O) admin et (O) devops

### 1.3  - pour un utilisateur "user-viewer@domain" appartenant au group organisationnel (O) reader

## 2. - Signature des certificats

### 2.1  - A l'aide d'openssl, de la CA et de la cles de la CA, crée les certificats pour une durée de 10 jours

### 2.2  - (optionnel) faire un zip ou 7z par user avec la CA et un mot de passe aléatoire de 9 signes

## 3 - Affectation des droits 

### 3.1  - Avec l'utilisateur admin de cluster, créer un namespace (ns) "ns-user" et rendez l'utilisateur "user@domain" admin de ce namespace (ns)

### 3.2  - Avec l'utilisateur admin de cluster, créer un namespace (ns) "ns-user-admin" et rendez le group  "admin" admin du cluster

### 3.3  - Avec l'utilisateur admin de cluster, render l'utilisateur "user-viewer" viewers du namespace (ns) "ns-user" 

### 3.4  - (Optionnel) creer un namespace (ns) "playground", rendre les membres du groupes (O) "users" admin et les membres du groupes (O) "dev" viewers

## 4 - Preparation de la navigation

### 4.1 - créer un fichier "exo-context" pour le cluster "domain"

### 4.2 - créer avec le fichier "exo-context" comme configuration du context, un cluster pour "domain" (avec la CA du cluster, le dns de l'api...)

### 4.3 - créer avec le fichier "exo-context" comme configuration du context, un user user@domain (avec la CA du cluster, la key du certificat "user" et le certificat "user")

### 4.4 - créer avec le fichier "exo-context" comme configuration du context, un user user-admin@domain (avec la CA du cluster, la key du certificat "user-admin" et le certificat "user-admin")

### 4.5 - créer avec le fichier "exo-context" comme configuration du context, un user user-viewer@domain (avec la CA du cluster, la key du certificat "user-viewer" et le certificat "user-viewer")

## 5 - Navigation

### 5.1 - avec le "exo-context" comme configuration du context, créer un context "user-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user", y creer un deploy "nginx" de l'image "kanedafromparis/nginx:0.1"

### 5.2 - avec le "exo-context" comme configuration du context, créer un context "user-admin-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user-admin", y modifier le deploy "nginx" de l'image "kanedafromparis/nginx:0.1" pour avoir 3 replicas

### 5.3 - avec le "exo-context" comme configuration du context, créer un context "user-in-ns-user" pour le cluster "domaine", le namespace "ns-user" et l'utilisateur "user", y modifier le deploy "nginx" de l'image "kanedafromparis/nginx:0.1" pour avoir 1 replicas




