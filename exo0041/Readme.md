# Pod mutualisation des volumes

## 1 - L'objectif est de faire un pod avec deux conteneurs, l’un qui écrit dans un fichier partager et l’autre qui affiche son contenu

### 1.1 - Builder une image a partir du Dockerfile [Dockerfile.fortune](Dockerfile.fortune) et des fichers présents dans le dossier

### 1.2 - Faire a partir du fichier [fortune.po.sample.000.yaml](fortune.po.sample.000.yaml) un Pod qui instancie cette image docker et afficher ces logs

### 1.3 - Enrichire le manifest de ce pod avec un volume "exchange" de type "emptyDir" et le monter dans le pod au chemin "/opt/exchange", supprimer l'ancien pod et lancer le nouveau (n'oublier pas grace period). (optionnel : verifier les logs)

### 1.4 - Enrichire le manifest de ce pod avec un second container "tail" qui monte egalement le volume "exchange" au chemin "/opt/exchange". Ajouter des parametres a ce conteneur pour changer le script appeller par defaut dans le docker au profit du script d'affichage (/run-tail.sh). N'oubliez pas de supprimer le reduite la verbosité du premier contenur. Supprimer l'ancien pod et lancer le nouveau (n'oublier pas grace period). verifier du  logs)
