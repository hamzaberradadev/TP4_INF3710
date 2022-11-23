INSERT INTO Client (
	nomclient,prenomclient,
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Dickens', 'Charles',
	   'c.dickens@yahoo.gbr', 'David Copperfield',
	   'Pickwick', 'J3927A');

INSERT INTO Client (
	nomclient,prenomclient,
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Mouse', 'Mickey', 'mickeycollab@disney.ca',
	   'Fantasy street', 'Los Angeles', 'H4P8Z3');

INSERT INTO Client (
	nomclient,prenomclient,
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Marloppe', 'Jonney', 'MJfire1337@protonmail.com',
	   '72 rue Beef', 'Montreal', 'H4PPY5');

INSERT INTO Client (
	nomclient,prenomclient,
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Marloppe', 'Konney', 'KJfire1337@protonmail.com',
	   '72 rue Beef', 'Montreal', 'H4PPY5');

INSERT INTO Telephone(numeroclient, numerodetelephone)
VALUES((SELECT numeroclient FROM Client WHERE ("nomclient" = 'Dickens' AND prenomclient = 'Charles')), '5148817777');

INSERT INTO Telephone(numeroclient, numerodetelephone)
VALUES((SELECT numeroclient FROM Client WHERE ("nomclient" = 'Mouse' AND prenomclient = 'Mickey')), '1114446666');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('QC Transport', '14 rue du Long-Lac, Sainte-Tite-Du-Grand');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('La tite Anisse', '2131 rue du Saint-Sauveur, Montreal');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('AB Transport', '1125 rue du Saint-Levin, Montreal');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('Benjamin', '72 rue Beef, Montreal');

INSERT INTO Fournisseur(adressefournisseur)
VALUES ('27 chemin du cosmos, Levis');

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('cetogène', 2, 2, 572, 30, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('orientale', 4, 3, 864, 45, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('keto', 2, 4, 946, 50, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('orientale', 4, 2, 595, 25, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('cetogène', 2, 3, 741, 30, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('grec', 4, 2, 695, 35, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('keto', 4, 2, 563, 45, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('grec', 1, 3, 658, 30, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('gastronomique', 1, 2, 675, 35, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='AB Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('gastronomique', 1, 3, 810, 40, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='AB Transport'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('Italien-Canadien', 1, 2, 910, 35, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='Benjamin'));

INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
					 nbrcalories, prix, numerofournisseur)
VALUES('Italien-Canadien', 1, 3, 745, 30, (SELECT numerofournisseur FROM Fournisseur
	   WHERE nomFournisseur='Benjamin'));

INSERT INTO Famille(numeroplan)
SELECT numeroplan FROM Planrepas WHERE categorie = 'cetogène';

INSERT INTO Famille(numeroplan)
SELECT numeroplan FROM Planrepas WHERE categorie = 'orientale';

INSERT INTO Rapide(numeroplan, tempspreparation)
VALUES((SELECT numeroplan FROM Famille WHERE
		numeroplan IN 
		(SELECT numeroplan FROM Planrepas WHERE
		 (categorie='cetogène' AND nbrpersonnes=2))), 15);
		 
INSERT INTO Rapide(numeroplan, tempspreparation)
VALUES((SELECT numeroplan FROM Famille WHERE
		numeroplan IN 
		(SELECT numeroplan FROM Planrepas WHERE
		 (categorie='cetogène' AND nbrpersonnes=3))), 20);

INSERT INTO Facile(numeroplan, nbingredients)
VALUES((SELECT numeroplan FROM Famille WHERE
		numeroplan IN 
		(SELECT numeroplan FROM Planrepas WHERE
		 (categorie='orientale' AND nbrpersonnes=2))), 15);
		 
INSERT INTO Facile(numeroplan, nbingredients)
VALUES((SELECT numeroplan FROM Famille WHERE
		numeroplan IN 
		(SELECT numeroplan FROM Planrepas WHERE
		 (categorie='orientale' AND nbrpersonnes=3))), 20);

INSERT INTO Vegetarien(numeroplan
,typederepas)
VALUES((SELECT numeroplan FROM Planrepas
		WHERE (categorie = 'grec' AND
			  nbrpersonnes=2)), 'salade');

INSERT INTO Vegetarien(numeroplan
,typederepas)
VALUES((SELECT numeroplan FROM Planrepas
	   WHERE categorie = 'grec' AND
	   nbrpersonnes=3), 'curry');

INSERT INTO Pescetarien(numeroplan
,typedepoisson)
VALUES((SELECT numeroplan FROM Planrepas WHERE
	   (categorie='keto' AND
	   nbrpersonnes=4)), 'saumon');

INSERT INTO Pescetarien(numeroplan
,typedepoisson)
VALUES((SELECT numeroplan FROM Planrepas WHERE
	   (categorie='keto' AND
	   nbrpersonnes=2)), 'brochet');

INSERT INTO Kitrepas(description,numeroplan)
VALUES('Un kit balance qui contient beaucoup de choses', 
	   (SELECT numeroplan FROM Planrepas WHERE (categorie = 'grec' AND nbrpersonnes=3)));
	   
INSERT INTO Kitrepas(description,numeroplan)
VALUES('Un kit complètement debalance qui contient beaucoup de les choses', 
	   (SELECT numeroplan FROM Planrepas WHERE (categorie = 'cetogène' AND nbrpersonnes=3)));

INSERT INTO Image(donnees,numerokitrepas)
VALUES('A0 B2 BF 12 C2 B8 98 ...',
(SELECT numerokitrepas FROM Kitrepas WHERE 
(description='Un kit balance qui contient beaucoup de choses')));

INSERT INTO Image(donnees,numerokitrepas)
VALUES('40 62 B1 F2 F2 08 A8 ...',
(SELECT numerokitrepas FROM Kitrepas WHERE 
(description='Un kit complètement debalance qui contient beaucoup de les choses')));

INSERT INTO Etape(numerokitrepas, numeroetape,
					numerosousetape, descriptionetape,
				  dureeetape)
VALUES(
(SELECT numerokitrepas FROM Kitrepas WHERE 
(description='Un kit balance qui contient beaucoup de choses')),
	1, 1, 'voici etape 1.1', 10);
	
INSERT INTO Etape(numerokitrepas, numeroetape,
					numerosousetape, descriptionetape,
				  dureeetape)
VALUES(
(SELECT numerokitrepas FROM Kitrepas WHERE 
(description='Un kit balance qui contient beaucoup de choses')),
	1, 2, 'voici etape 1.2', 15);

INSERT INTO ingredient(nomingredient,paysingredient)
VALUES('Banane', 'Maroc');

INSERT INTO ingredient(nomingredient,paysingredient)
VALUES('Riz', 'Inde');

INSERT INTO ingredient(nomingredient,paysingredient)
VALUES('Curry', 'Inde');

INSERT INTO ingredient(nomingredient,paysingredient)
VALUES('Orange', 'Niger');

INSERT INTO abonner(numeroclient, numeroplan, duree)
VALUES((SELECT numeroclient FROM Client WHERE
	   nomclient='Dickens'),
	   (SELECT numeroplan FROM Planrepas WHERE 
		(categorie = 'grec' AND nbrpersonnes=3)),
	   2);
	   
INSERT INTO abonner(numeroclient, numeroplan, duree)
VALUES((SELECT numeroclient FROM Client WHERE
	   nomclient='Mouse'),
	   (SELECT numeroplan FROM Planrepas WHERE 
		(categorie = 'orientale' AND nbrpersonnes=3)),
	   1);

INSERT INTO contenir(numerokitrepas, numeroingredient)
VALUES((SELECT numerokitrepas FROM Kitrepas WHERE
	   description=
		'Un kit balance qui contient beaucoup de choses'),
	   (SELECT numeroingredient FROM ingredient WHERE 
		nomingredient = 'Banane'));
		
INSERT INTO contenir(numerokitrepas, numeroingredient)
VALUES((SELECT numerokitrepas FROM Kitrepas WHERE
	   description=
		'Un kit complètement debalance qui contient beaucoup de les choses'),
	   (SELECT numeroingredient FROM ingredient WHERE 
		nomingredient = 'Riz'));