# Update 03/2018 : autre technique dans le labo d'Heliox (propre aussi !)
https://www.youtube.com/watch?v=8joLK039fjk

# Comment faire des PCB avec des produits "basiques" (notes prises par un collègue)
![pcb-maison](https://user-images.githubusercontent.com/404135/27997429-23e793a2-64f8-11e7-9a58-84f0372525b4.jpg)

De bas en haut :
* méthode de l'imprimante laser mais trop chauffé
* méthode de l'imprimante laser mais mal décollé
* méthode de l'imprimante laser repassé au marqueur indélébile (meilleur résultat pour application "industrielle")
* masque réalisé au typex, pas terrible car le blanco se décolle pendant le bain d'acide. Je testerai avec du verni à ongle pour voir...
* masque réalisé au marqueur indélébile

Méthode de l'imprimante laser : on imprime sur du papier le typon qu'on souhaite réaliser.
Ensuite on met le papier contre le PCB (duquel on a ôté la couche de verni protecteur à l'acétone) et on chauffe. J'ai fait ça sur mes plaques de cuisson (une feuille d'alu sur le vitrocéramique presque au minimum, sinon ça crame la plaque cf le test du bas, et quelque chose pour faire du poids qui ne craint pas la chaleur au dessus), mais on peut aussi utiliser un fer à repasser.
Après 1/2 heure (les deux tests du bas étaient resté qu'1/4 d'heure et c'était pas assez) on retire ça du feu et on le plonge dans l'eau chaude. Laissez tremper facilement 10-15 min et retirer PRÉCAUTIONNEUSEMENT (c'est l'étape la plus délicate) le papier en LAISSANT l'encre sur le PCB.
C'est pour cette raison qu'il faut une imprimante laser : l'encre n'est qu'un film à la surface du papier, tandis qu'avec une jet d'encre, l'encre est liquide et pénètre en profondeur (hum <3 ) le papier, rendant la manip impossible.
Ensuite il suffit de placer tout ça dans le bain.

Le bain en question se fait avec 2/3 de vinaigre blanc (acide acétique) et 1/3 d'eau oxygénée (peroxyde d'hydrogène), si les concentrations sont les mêmes (les miens étaient à 10° tous les deux par exemple, si vous trouvez des trucs plus concentrés bien sûr ça fonctionne mieux mais il faut adapter les proportions pour que ça reste stœchiométrique : 1 mol d'acide pour 1 mol de peroxyde, vous avez les masses molaires et masses volumique sur Wikipédia).
Il faut ensuite juste mettre du sel de cuisine (une bonne cuiller à soupe pour 200mL environ, y'en aura jamais trop de toute façon) ou de l'acide sulfurique (c'est de l'acide à batterie, par contre aucune idée des quantités à mettre, au pire c'est qu'un catalyseur).
Laisser les PCBs dedans pendant 20-30 min (il faut rester à côté sur la fin pour pas qu'ils soient trop attaqués) en touillant de temps en temps (avec un bulleur d'aquarium ça doit être le mieux)

Enfin il ne vous reste plus qu'à nettoyer les traces de masque (que ce soit du verni à ongle, du blanco, ou l'encre d'imprimante, de l'acétone fait très bien l'affaire), et vous avez vos PCBs 
