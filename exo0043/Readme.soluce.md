
# Labels 

## 1 - Appliquer le manifest  fichier comme [nginx.list.000.yaml](nginx.list.000.yaml), puis :

   Dans un terminal on lance
   $ `kubectl apply -f nginx.list.000.yaml`

### 1.1 - compter le nombre de pod aux labels color=red

   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l color=red | wc -l`

   La reponse est 5
   
### 1.2 - compter le nombre de pod aux labels color=green

   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l color=green | wc -l`

   La reponse est 18
   
### 1.3 - compter le nombre de pod ayant un labels color red ou blue

   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l "color in (blue, red)" | wc -l`

   La reponse est 12

### 1.5 - compter le nombre de pod n'ayant un labels status "prod"

   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l "status=prod" | wc -l`

   La reponse est 5

### 1.6 - compter le nombre de pod n'ayant un labels status "dev" et une color "blue"

   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l "status=dev,color in (bleu, red)" | wc -l`

   La reponse est 1

### 1.7 - compter le nombre de pod n'ayant un labels status=dev et pas color=red


   Dans un terminal on lance
   $ `kubectl get po --show-labels --no-headers -l "status=dev,color!=red" | wc -l`

   La reponse est 5

