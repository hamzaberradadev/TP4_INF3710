CREATE TABLE IF NOT EXISTS Client(
numéroclient SERIAL,
nomclient CHAR(20),
prénomclient CHAR(20),
adressecourrielclient VARCHAR(40),
rueclient VARCHAR(20),
villeclient CHAR(20),
codepostalclient VARCHAR(6),
PRIMARY KEY (numéroclient)
);

CREATE TABLE IF NOT EXISTS Téléphone(
numéroclient SERIAL,
numérodetéléphone VARCHAR(14),
PRIMARY KEY (numéroclient, numérodetéléphone),
FOREIGN KEY (numéroclient) 
REFERENCES Client(numéroclient) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur SERIAL, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(40),
	PRIMARY KEY (numérofournisseur)
);

CREATE TABLE IF NOT EXISTS Planrepas(
numéroplan SERIAL,
catégorie CHAR(25),
fréquence VARCHAR(3),
nbrpersonnes VARCHAR(3),
nbrcalories VARCHAR(6),
prix VARCHAR(5),
numérofournisseur SERIAL,
PRIMARY KEY (numéroplan),
FOREIGN KEY (numérofournisseur) 
REFERENCES Fournisseur(numérofournisseur) 
ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan SERIAL,
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan SERIAL,
	typederepas CHAR(20),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan SERIAL,
	typedepoisson CHAR(20),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Rapide(
	numéroplan SERIAL,
	tempspréparation VARCHAR(4),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Famille(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan SERIAL,
	nbingrédients VARCHAR(3),
	PRIMARY KEY (numéroplan),
	FOREIGN KEY (numéroplan)
	REFERENCES Famille(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numérokitrepas SERIAL,
	description VARCHAR(500),
	numéroplan SERIAL,
	PRIMARY KEY (numérokitrepas),
	FOREIGN KEY (numéroplan)
	REFERENCES Planrepas(numéroplan)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Image(
	numéroimage SERIAL,
	données VARCHAR(500),
	numérokitrepas SERIAL,
	PRIMARY KEY (numéroimage),
	FOREIGN KEY (numérokitrepas)
	REFERENCES Kitrepas(numérokitrepas)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Étape(
	numérokitrepas SERIAL,
	descriptionétape VARCHAR(500),
	duréeétape VARCHAR(3),
	numérokitrepasêtrecomposéde SERIAL,
	PRIMARY KEY (numérokitrepas),
	FOREIGN KEY (numérokitrepas)
	REFERENCES Kitrepas(numérokitrepas)
	ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS Ingrédient(
	numéroingrédient SERIAL,
	nomingrédient CHAR(20),
	paysingrédient CHAR(20),
	PRIMARY KEY (numéroingrédient)
);

CREATE TABLE IF NOT EXISTS Abonner(
	numéroclient SERIAL,
	numéroplan SERIAL,
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
	numérokitrepas SERIAL,
	numéroingrédient SERIAL,
	PRIMARY KEY (numérokitrepas),
	FOREIGN KEY (numérokitrepas)
	REFERENCES Kitrepas(numérokitrepas)
	ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (numéroingrédient)
	REFERENCES Ingrédient(numéroingrédient)
	ON UPDATE CASCADE ON DELETE RESTRICT
);
