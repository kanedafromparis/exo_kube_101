

# À partir du fichier config-sample.json listant les projets et ses membres , faire une commande bash (en one-liner) pour

## 1 - Afficher la liste des projets 

   $ `cat projets.json | jq .[].projectName`

## 2 - Afficher la liste des identifiants utilisateurs des membres 

NB : On peut toujours parcourire le json avec `cat projets.json | jq . | less`

   $ `cat projets.json | jq .[].persons[].username`

## 3 - Afficher les identifiants utilisateurs des développeurs des projets

  On affiche les developpeurs avec :
  
   $ `cat projets.json | jq '.[].persons[] | select(.jobtitle=="developpeur")'`
   ou
   $ `cat projets.json | jq '[ .[]?.persons[] | select(.jobtitle | contains("developpeur"))] | .[].username'`

  on parse cette liste avec `.[].username`

   $ `cat projets.json | jq '.[].persons[] | select(.jobtitle=="developpeur").username'`
   ou
   cat projets.json | jq '[ .[]?.persons[] | select(.jobtitle | contains("developpeur"))] | .[].username'

## 4 - Afficher le projet le plus récents

  On affiche les dates des projets avec 

   $ `cat projets.json | jq  -r '.[]?.startdate' | sort`
   
  On extrait le dernier élément avec ` tail -n 1`
  
   $ `cat projets.json | jq  -r '.[]?.startdate' | sort | tail -n 1`

  On affiche projet de date "2017-12-05" avec 
  
   $ `cat projets.json | jq '[.[]? | select(.startdate | contains("2017-12-05"))] | .[]?.projectName'`

  Avec un one liner :
   $ `cat projets.json | jq '[.[]? | select(.startdate | contains('$(cat projets.json | jq '.[]?.startdate' | sort | tail -n 1)'))] | .[]?.projectName'`