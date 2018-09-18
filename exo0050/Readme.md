Lancer un déploiement de "kanedafromparis/logversion:1.0" avec 2 replicas
 - dans un autre terminal mapper le service sur un port local et faire un test de version du services
 - surveiller l’évolution des pods
 - afficher les logs des pods
 - passer le nombre de réplicas à 5
 - passer la version du container à la 2.0
 - passer le nombre de réplicas à 6 et modifier la strategie de deploiement
   - Augmenter le nombre de pods de transition a 3 
 - passer la version du container à la 3.0
 - passer la version du container à la 3.1
   - lister l'historique des rollouts
 - passer la version du container à la 3.2
   - faire un retour arrière à la version 3.0
   - passer a un seul pod
    
 - ouvert l’application à l'extérieur
 - Modifier les sondes
   - sur liveness et tester l’application depuis l'extérieurs
   - sur readiness et tester l’application depuis l'extérieurs
 - Modifier 
   - la stratégie en "Recreate"
   - supprimer les sondes liveness
 - tester l’application depuis l'extérieurs
   - Modifier la version en 3.2
 - tester l’application depuis l'extérieurs
 - fair une rollout sur la version 3 puis un rollout par défaut


