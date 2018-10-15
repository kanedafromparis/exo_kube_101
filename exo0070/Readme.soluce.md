# JOBS

## 1 - A partir du fichier [pwgen.jobs.sample.000.yaml](pwgen.jobs.sample.000.yaml)

### 1.1 - Faire un job qui lance la commande pwgen et affiche 22 mots de passe de 15 carateres contenant au moins un caracter speciale


   On obtient un fichier comme [pwgen.jobs.011.yaml](pwgen.jobs.011.yaml)

   $ `kubectl apply -f pwgen.jobs.011.yaml`

   On peut consluter les logs avec  
   
   $ `kubectl logs $(kubectl get po -l run=pwgen -o name)`
     
### 1.2 - Modifier le fichier obtenu pour que l'image docker retourne une erreur "exit 1"

   On obtient un fichier comme [pwgen.jobs.012.yaml](pwgen.jobs.012.yaml)

   $ `kubectl apply -f pwgen.jobs.012.yaml`
   
   Remarque : 
   pensez a supprimer le job precedent avec :  
   
   $ `kubectl delete -f pwgen.jobs.012.yaml && kubectl apply -f pwgen.jobs.012.yaml`

### 1.3 - Modifier le fichier obtenu pour ce job ne fasse que 3 essaies, on peur repartir de [pwgen.jobs.sample.012.yaml](pwgen.jobs.sample.012.yaml)

   On obtient un fichier comme [pwgen.jobs.013.yaml](pwgen.jobs.013.yaml)

   $ `kubectl apply -f pwgen.jobs.013.yaml`
   
   Remarque : 
   Pensez a consulter le describe 
   
   $ `kubectl describe jobs pwgen`
   
   
   pensez a supprimer le job precedent avec :  
   
   
   $ `kubectl delete -f pwgen.jobs.013.yaml && kubectl apply -f pwgen.jobs.013.yaml`
   Remarque : https://github.com/kubernetes/kubernetes/issues/62382#issuecomment-384327386
