INSERT INTO Client (
	nomclient,"prénomclient",
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Dickens', 'Charles',
	   'c.dickens@yahoo.gbr', 'David Copperfield',
	   'Pickwick', 'J3927A');

INSERT INTO Client (
	nomclient,"prénomclient",
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Mouse', 'Mickey', 'mickeycollab@disney.ca',
	   'Fantasy street', 'Los Angeles', 'H4P8Z3');

INSERT INTO Client (
	nomclient,"prénomclient",
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Marloppe', 'Jonney', 'MJfire1337@protonmail.com',
	   '72 rue Beef', 'Montréal', 'H4PPY5');

INSERT INTO Client (
	nomclient,"prénomclient",
	adressecourrielclient,rueclient, villeclient,
	codepostalclient)
VALUES ('Marloppe', 'Konney', 'KJfire1337@protonmail.com',
	   '72 rue Beef', 'Montréal', 'H4PPY5');

INSERT INTO Téléphone("numéroclient", "numérodetéléphone")
VALUES((SELECT "numéroclient" FROM Client WHERE ("nomclient" = 'Dickens' AND "prénomclient" = 'Charles')), '5148817777');

INSERT INTO Téléphone("numéroclient", "numérodetéléphone")
VALUES((SELECT "numéroclient" FROM Client WHERE ("nomclient" = 'Mouse' AND "prénomclient" = 'Mickey')), '1114446666');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('QC Transport', '14 rue du Long-Lac, Sainte-Tite-Du-Grand');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('La tite Anisse', '2131 rue du Saint-Sauveur, Montréal');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('AB Transport', '1125 rue du Saint-Levin, Montréal');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('Benjamin', '72 rue Beef, Montréal');

INSERT INTO Fournisseur(adressefournisseur)
VALUES ('27 chemin du cosmos, Lévis');

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('cétogène', 2, 2, 572, 30, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('orientale', 4, 3, 864, 45, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('keto', 2, 4, 946, 50, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('orientale', 4, 2, 595, 25, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('cétogène', 2, 3, 741, 30, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('grec', 4, 2, 695, 35, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('keto', 4, 2, 563, 45, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='QC Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('grec', 1, 3, 658, 30, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='La tite Anisse'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('gastronomique', 1, 2, 675, 35, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='AB Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('gastronomique', 1, 3, 810, 40, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='AB Transport'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('Italien-Canadien', 1, 2, 910, 35, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='Benjamin'));

INSERT INTO Planrepas("catégorie", "fréquence", nbrpersonnes,
					 nbrcalories, prix, "numérofournisseur")
VALUES('Italien-Canadien', 1, 3, 745, 30, (SELECT "numérofournisseur" FROM Fournisseur
	   WHERE nomFournisseur='Benjamin'));

INSERT INTO Famille("numéroplan")
SELECT "numéroplan" FROM Planrepas WHERE catégorie = 'cétogène';

INSERT INTO Famille("numéroplan")
SELECT "numéroplan" FROM Planrepas WHERE catégorie = 'orientale';

INSERT INTO Rapide("numéroplan", "tempspréparation")
VALUES((SELECT "numéroplan" FROM Famille WHERE
		"numéroplan" IN 
		(SELECT "numéroplan" FROM Planrepas WHERE
		 ("catégorie"='cétogène' AND nbrpersonnes='2'))), 15);
		 
INSERT INTO Rapide("numéroplan", "tempspréparation")
VALUES((SELECT "numéroplan" FROM Famille WHERE
		"numéroplan" IN 
		(SELECT "numéroplan" FROM Planrepas WHERE
		 ("catégorie"='cétogène' AND nbrpersonnes='3'))), 20);

INSERT INTO Facile("numéroplan", "nbingrédients")
VALUES((SELECT "numéroplan" FROM Famille WHERE
		"numéroplan" IN 
		(SELECT "numéroplan" FROM Planrepas WHERE
		 ("catégorie"='orientale' AND nbrpersonnes='2'))), 15);
		 
INSERT INTO Facile("numéroplan", "nbingrédients")
VALUES((SELECT "numéroplan" FROM Famille WHERE
		"numéroplan" IN 
		(SELECT "numéroplan" FROM Planrepas WHERE
		 ("catégorie"='orientale' AND nbrpersonnes='3'))), 20);

INSERT INTO Végétarien("numéroplan"
,typederepas)
VALUES((SELECT "numéroplan" FROM Planrepas
		WHERE (catégorie = 'grec' AND
			  nbrpersonnes='2')), 'salade');

INSERT INTO Végétarien("numéroplan"
,typederepas)
VALUES((SELECT "numéroplan" FROM Planrepas
	   WHERE catégorie = 'grec' AND
	   nbrpersonnes='3'), 'curry');

INSERT INTO Pescétarien("numéroplan"
,typedepoisson)
VALUES((SELECT "numéroplan" FROM Planrepas WHERE
	   ("catégorie"='keto' AND
	   nbrpersonnes='4')), 'saumon');

INSERT INTO Pescétarien("numéroplan"
,typedepoisson)
VALUES((SELECT "numéroplan" FROM Planrepas WHERE
	   ("catégorie"='keto' AND
	   nbrpersonnes='2')), 'brochet');

INSERT INTO Kitrepas(description,"numéroplan")
VALUES('Un kit balancé qui contient beaucoup de choses', 
	   (SELECT "numéroplan" FROM Planrepas WHERE ("catégorie" = 'grec' AND nbrpersonnes='3')));
	   
INSERT INTO Kitrepas(description,"numéroplan")
VALUES('Un kit complètement débalancé qui contient beaucoup de les choses', 
	   (SELECT "numéroplan" FROM Planrepas WHERE ("catégorie" = 'cétogène' AND nbrpersonnes='3')));

INSERT INTO Image("données","numérokitrepas")
VALUES('A0 B2 BF 12 C2 B8 98 ...',
(SELECT "numérokitrepas" FROM Kitrepas WHERE 
(description='Un kit balancé qui contient beaucoup de choses')));

INSERT INTO Image("données","numérokitrepas")
VALUES('40 62 B1 F2 F2 08 A8 ...',
(SELECT "numérokitrepas" FROM Kitrepas WHERE 
(description='Un kit complètement débalancé qui contient beaucoup de les choses')));

INSERT INTO "Étape"("numérokitrepas", "numéroétape",
					"numérosousétape", "descriptionétape",
				  "duréeétape")
VALUES(
(SELECT "numérokitrepas" FROM Kitrepas WHERE 
(description='Un kit balancé qui contient beaucoup de choses')),
	1, 1, 'voici étape 1.1', '10');
	
INSERT INTO "Étape"("numérokitrepas", "numéroétape",
					"numérosousétape", "descriptionétape",
				  "duréeétape")
VALUES(
(SELECT "numérokitrepas" FROM Kitrepas WHERE 
(description='Un kit balancé qui contient beaucoup de choses')),
	1, 2, 'voici étape 1.2', '15');

INSERT INTO "ingrédient"("nomingrédient","paysingrédient")
VALUES('Banane', 'Maroc');

INSERT INTO "ingrédient"("nomingrédient","paysingrédient")
VALUES('Riz', 'Inde');

INSERT INTO "ingrédient"("nomingrédient","paysingrédient")
VALUES('Curry', 'Inde');

INSERT INTO "ingrédient"("nomingrédient","paysingrédient")
VALUES('Orange', 'Niger');

INSERT INTO abonner("numéroclient", "numéroplan", "durée")
VALUES((SELECT "numéroclient" FROM Client WHERE
	   nomclient='Dickens'),
	   (SELECT "numéroplan" FROM Planrepas WHERE 
		("catégorie" = 'grec' AND nbrpersonnes='3')),
	   '2');
	   
INSERT INTO abonner("numéroclient", "numéroplan", "durée")
VALUES((SELECT "numéroclient" FROM Client WHERE
	   nomclient='Mouse'),
	   (SELECT "numéroplan" FROM Planrepas WHERE 
		("catégorie" = 'orientale' AND nbrpersonnes='3')),
	   '1');

INSERT INTO contenir("numérokitrepas", "numéroingrédient")
VALUES((SELECT "numérokitrepas" FROM Kitrepas WHERE
	   description=
		'Un kit balancé qui contient beaucoup de choses'),
	   (SELECT "numéroingrédient" FROM "ingrédient" WHERE 
		"nomingrédient" = 'Banane'));
		
INSERT INTO contenir("numérokitrepas", "numéroingrédient")
VALUES((SELECT "numérokitrepas" FROM Kitrepas WHERE
	   description=
		'Un kit complètement débalancé qui contient beaucoup de les choses'),
	   (SELECT "numéroingrédient" FROM "ingrédient" WHERE 
		"nomingrédient" = 'Riz'));