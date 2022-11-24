CREATE TABLE IF NOT EXISTS Client(
numeroclient SERIAL NOT NULL,
nomclient CHAR(20),
prenomclient CHAR(20),
adressecourrielclient VARCHAR(40),
rueclient VARCHAR(20),
villeclient CHAR(20),
codepostalclient VARCHAR(6),
PRIMARY KEY (numeroclient)
);

CREATE TABLE IF NOT EXISTS Telephone(
numeroclient INT NOT NULL,
numerodetelephone VARCHAR(14) NOT NULL,
PRIMARY KEY (numeroclient, numerodetelephone),
FOREIGN KEY (numeroclient) 
REFERENCES Client(numeroclient) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numerofournisseur SERIAL NOT NULL, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(40),
	PRIMARY KEY (numerofournisseur)
);

CREATE TABLE IF NOT EXISTS Planrepas(
numeroplan SERIAL NOT NULL,
categorie CHAR(25) NOT NULL,
frequence NUMERIC NOT NULL,
nbrpersonnes NUMERIC NOT NULL,
nbrcalories NUMERIC NOT NULL,
prix NUMERIC NOT NULL CHECK (prix>=0),
numerofournisseur INT NOT NULL,
PRIMARY KEY (numeroplan),
FOREIGN KEY (numerofournisseur) 
REFERENCES Fournisseur(numerofournisseur) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Famille(
	numeroplan INT NOT NULL,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan)
	REFERENCES Planrepas(numeroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Vegetarien(
	numeroplan INT NOT NULL,
	typederepas CHAR(20) NOT NULL,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan)
	REFERENCES Planrepas(numeroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Pescetarien(
	numeroplan INT NOT NULL,
	typedepoisson CHAR(20) NOT NULL,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan)
	REFERENCES Planrepas(numeroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Rapide(
	numeroplan INT NOT NULL,
	tempspreparation NUMERIC,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan)
	REFERENCES Famille(numeroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Facile(
	numeroplan INT NOT NULL,
	nbingredients INT NOT NULL,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan)
	REFERENCES Famille(numeroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Kitrepas(
    numerokitrepas SERIAL NOT NULL,
    description VARCHAR(500) NOT NULL,
    numeroplan INT NOT NULL,
    PRIMARY KEY (numerokitrepas),
    FOREIGN KEY (numeroplan)
    REFERENCES Planrepas(numeroplan)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Image(
    numeroimage SERIAL NOT NULL,
    donnees VARCHAR(500) NOT NULL,
    numerokitrepas INT NOT NULL,
    PRIMARY KEY (numeroimage),
    FOREIGN KEY (numerokitrepas)
    REFERENCES Kitrepas(numerokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Etape(
    numerokitrepas INT NOT NULL,
    numeroetape INT NOT NULL,
    numerosousetape INT NOT NULL,
    descriptionetape VARCHAR(500) NOT NULL,
    dureeetape NUMERIC NOT NULL,
    PRIMARY KEY (numerokitrepas, numeroetape,
				numerosousetape),
    FOREIGN KEY (numerokitrepas)
    REFERENCES Kitrepas(numerokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Ingredient(
    numeroingredient SERIAL NOT NULL,
    nomingredient CHAR(20),
    paysingredient CHAR(20),
    PRIMARY KEY (numeroingredient)
);
 
CREATE TABLE IF NOT EXISTS Abonner(
    numeroclient INT NOT NULL,
    numeroplan INT NOT NULL,
    duree NUMERIC NOT NULL,
    PRIMARY KEY (numeroclient, numeroplan),
    FOREIGN KEY (numeroclient)
    REFERENCES Client(numeroclient)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (numeroplan)
    REFERENCES Planrepas(numeroplan)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Contenir(
    numerokitrepas INT NOT NULL,
    numeroingredient INT NOT NULL,
    PRIMARY KEY (numerokitrepas, numeroingredient),
    FOREIGN KEY (numerokitrepas)
    REFERENCES Kitrepas(numerokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (numeroingredient)
    REFERENCES Ingredient(numeroingredient)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

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