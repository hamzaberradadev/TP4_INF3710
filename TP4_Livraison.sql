CREATE TABLE IF NOT EXISTS Client(
numéroclient SERIAL NOT NULL,
nomclient CHAR(20),
prénomclient CHAR(20),
adressecourrielclient VARCHAR(40),
rueclient VARCHAR(20),
villeclient CHAR(20),
codepostalclient VARCHAR(6),
PRIMARY KEY (numéroclient)
);

CREATE TABLE IF NOT EXISTS Téléphone(
numéroclient INT NOT NULL,
numérodetéléphone VARCHAR(14) NOT NULL,
PRIMARY KEY (numéroclient, numérodetéléphone),
FOREIGN KEY (numéroclient) 
REFERENCES Client(numéroclient) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur SERIAL NOT NULL, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(40),
	PRIMARY KEY (numérofournisseur)
);

CREATE TABLE IF NOT EXISTS Planrepas(
numéroplan SERIAL NOT NULL,
catégorie CHAR(25),
fréquence VARCHAR(3),
nbrpersonnes VARCHAR(3),
nbrcalories VARCHAR(6),
prix VARCHAR(5),
numérofournisseur INT NOT NULL,
PRIMARY KEY (numéroplan),
FOREIGN KEY (numérofournisseur) 
REFERENCES Fournisseur(numérofournisseur) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan INT NOT NULL,
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan INT NOT NULL,
	typederepas CHAR(20),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan INT NOT NULL,
	typedepoisson CHAR(20),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Rapide(
	numéroplan INT NOT NULL,
	tempspréparation VARCHAR(4),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Famille(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan INT NOT NULL,
	nbingrédients VARCHAR(3),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Famille(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Kitrepas(
    numérokitrepas SERIAL NOT NULL,
    description VARCHAR(500),
    numéroplan INT NOT NULL,
    PRIMARY KEY (numérokitrepas),
    FOREIGN KEY (numéroplan)
    REFERENCES Planrepas(numéroplan)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Image(
    numéroimage SERIAL NOT NULL,
    données VARCHAR(500),
    numérokitrepas INT NOT NULL,
    PRIMARY KEY (numéroimage),
    FOREIGN KEY (numérokitrepas)
    REFERENCES Kitrepas(numérokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Étape(
    numérokitrepas INT NOT NULL,
    descriptionétape VARCHAR(500),
    duréeétape VARCHAR(3),
    numérokitrepasêtrecomposéde VARCHAR(10),
    PRIMARY KEY (numérokitrepas),
    FOREIGN KEY (numérokitrepas)
    REFERENCES Kitrepas(numérokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Ingrédient(
    numéroingrédient SERIAL NOT NULL,
    nomingrédient CHAR(20),
    paysingrédient CHAR(20),
    PRIMARY KEY (numéroingrédient)
);
 
CREATE TABLE IF NOT EXISTS Abonner(
    numéroclient INT NOT NULL,
    numéroplan INT NOT NULL,
    durée VARCHAR(3) NOT NULL,
    PRIMARY KEY (numéroclient, numéroplan),
    FOREIGN KEY (numéroclient)
    REFERENCES Client(numéroclient)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (numéroplan)
    REFERENCES Planrepas(numéroplan)
    ON UPDATE CASCADE ON DELETE RESTRICT
);
 
CREATE TABLE IF NOT EXISTS Contenir(
    numérokitrepas INT NOT NULL,
    numéroingrédient INT NOT NULL,
    PRIMARY KEY (numérokitrepas),
    PRIMARY KEY (numéroingrédient),
    FOREIGN KEY (numérokitrepas)
    REFERENCES Kitrepas(numérokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (numéroingrédient)
    REFERENCES Ingrédient(numéroingrédient)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

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

INSERT INTO Téléphone("numéroclient", "numérodetéléphone")
VALUES((SELECT "numéroclient" FROM Client WHERE ("nomclient" = 'Dickens' AND "prénomclient" = 'Charles')), '5148817777');

INSERT INTO Téléphone("numéroclient", "numérodetéléphone")
VALUES((SELECT "numéroclient" FROM Client WHERE ("nomclient" = 'Mouse' AND "prénomclient" = 'Mickey')), '1114446666');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('QC Transport', '14 rue du Long-Lac, Sainte-Tite-Du-Grand');

INSERT INTO Fournisseur(nomfournisseur, adressefournisseur)
VALUES ('La tite Anisse', '2131 rue du Saint-Sauveur, Montréal');

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
