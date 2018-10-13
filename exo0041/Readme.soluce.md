
# Pod mutualisation des volumes

## 1 - L'objectif est de faire un pod avec deux conteneurs, l’un qui écrit dans un fichier partager et l’autre qui affiche son contenu

### 1.1 - Builder une image a partir du Dockerfile [Dockerfile.fortune](Dockerfile.fortune) et des fichers présents dans le dossier

   $ `TARGET_REPO=kaneda-k && docker build -t $TARGET_REPO/fortune:ocp-0.1 . -f Dockerfile.fortune`

### 1.2 - Faire a partir du fichier [fortune.po.sample.000.yaml](fortune.po.sample.000.yaml) un Pod qui instancie cette image docker et affichier ces logs

   On obtient un fichier comme [fortune.po.011.yaml](fortune.po.011.yaml).

   $ `kubectl create -f fortune.po.012.yaml && kubectl logs fortune -f`

### 1.3 - Enrichire le manifest de ce pod avec un volume "exchange" de type "emptyDir" et le monter dans le pod au chemin "/opt/exchange", supprimer l'ancien pod et lancer le nouveau (n'oublier pas grace period). (optionnel : verifier les logs)

   On obtient un fichier comme [fortune.po.013.yaml](fortune.po.013.yaml).

   $ `kubectl delete po fortune && kubectl create -f fortune.po.013.yaml`
   $ `kubectl logs fortune -f`

### 1.4 - Enrichire le manifest de ce pod avec un second container "tail" qui monte egalement le volume "exchange" au chemin "/opt/exchange". Ajouter des parametres a ce conteneur pour changer le script appeller par defaut dans le docker au profit du script d'affichage (/run-tail.sh). N'oubliez pas de supprimer le reduite la verbosité du premier contenur. Supprimer l'ancien pod et lancer le nouveau (n'oublier pas grace period). verifier du  logs)

   $ `kubectl delete po fortune && kubectl create -f fortune.po.014.yaml`
   $ `kubectl logs fortune -f`

