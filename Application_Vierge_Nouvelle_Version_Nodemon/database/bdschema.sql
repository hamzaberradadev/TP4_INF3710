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

