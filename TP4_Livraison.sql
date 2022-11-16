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
    numérokitrepasêtrecomposéde VARCHAR(10) NOT NULL,
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
    PRIMARY KEY (numérokitrepas, numéroingrédient),
    FOREIGN KEY (numérokitrepas)
    REFERENCES Kitrepas(numérokitrepas)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (numéroingrédient)
    REFERENCES Ingrédient(numéroingrédient)
    ON UPDATE CASCADE ON DELETE RESTRICT
);