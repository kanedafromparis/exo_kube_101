
À partir du fichier config-sample.json listant les projets et des fichiers projets, faire un script bash pour
- Afficher la liste des identifiants utilisateurs, 

  $ # cat projets.json | jq .
  $ # cat projets.json | jq .[].projectName
  $ cat projets.json | jq .[].persons[].username

- Afficher le nombre de développeurs des projets, à partir du fichier listant les projets et des fichiers projets

 $ cat projets.json | jq '.[].persons[] | select(.jobtitle=="developpeur")'
 $ cat projets.json | jq '[ .[]?.persons[] | select(.jobtitle | contains("developpeur"))] | .[].username'
 
 
- trouver le projet le plus récents

 $ cat projets.json | jq  '.[]?.startdate' | sort -r
 
 "2007-03-33"
 
 cat projets.json | jq '[.[]? | select(.startdate | contains("2007-03-33"))] | .[]?.projectName'


