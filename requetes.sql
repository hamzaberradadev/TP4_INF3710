-- 4.1. Affichez les numéros (numéroclient) et les noms (nomclient) des clients qui ont commandé un repas avec un prix compris entre 20 dollars et 40 dollars. (2pts)

SELECT DISTINCT Client.numéroclient, Client.nomclient
FROM Client, Abonner, Planrepas
WHERE Client.numéroclient = Abonner.numéroclient
AND Planrepas.numéroplan = Abonner.numéroplan
AND Planrepas.prix BETWEEN 20 AND 40;

-- 4.2. Afficher les numéros des plans repas (numéroplan) qui ne proviennent pas du fournisseur au nom de 'QC Transport'. (2pts)

SELECT DISTINCT "numéroplan"
FROM Planrepas, Fournisseur
WHERE Planrepas.numérofournisseur = Fournisseur.numérofournisseur
AND nomfournisseur <> 'QC Transport';

-- 4.3. Affichez la liste des numéros des plans Famille (numéroplan) dont la catégorie du plan repas correspond à 'cétogène'. (2pts) 

SELECT Famille.numéroplan
FROM Famille, Planrepas
WHERE Famille.numéroplan = Planrepas.numéroplan
AND "catégorie" = 'cétogène';

-- 4.4. Affichez le nombre de fournisseurs n’ayant pas de nom dans leur dossier (la valeur de nomfournisseur est NULL). (2pts)

SELECT COUNT(*)
FROM Fournisseur
WHERE nomfournisseur IS NULL;

-- 4.5. Affichez les noms des fournisseurs (nomfournisseur) ayant fait des livraisons de plans repas dont le montant est supérieur aux livraisons faites par le fournisseur dont le nom est 'AB Transport'. (2pts) 

SELECT DISTINCT nomfournisseur 
FROM planrepas INNER JOIN fournisseur
ON planrepas."numérofournisseur" = fournisseur."numérofournisseur" 
WHERE (prix >(
	SELECT MIN(prix) 
	FROM planrepas INNER JOIN fournisseur 
	ON planrepas."numérofournisseur" = fournisseur."numérofournisseur" 
	WHERE nomfournisseur = 'AB Transport')
	  AND nomfournisseur<>'AB Transport');
-- 4.6. Affichez les noms des fournisseurs (nomfournisseur), les adresses (adressefournisseur) et le montant total des prix des livraisons de plans repas des fournisseurs ayant les deux plus larges montants de livraison sur la plateforme. (2pts) 

SELECT nomfournisseur, adressefournisseur, SUM(prix)
FROM planrepas INNER JOIN fournisseur
ON planrepas."numérofournisseur" = fournisseur."numérofournisseur"
WHERE fournisseur.numérofournisseur IN(
	SELECT fournisseur.numérofournisseur 
	FROM planrepas INNER JOIN fournisseur 
	ON planrepas."numérofournisseur" = fournisseur."numérofournisseur" 
	ORDER BY prix DESC LIMIT 2)
GROUP BY fournisseur.numérofournisseur;

-- 4.7. Affichez le nombre de kit repas qui n’ont jamais été réservés chez les fournisseurs. (2pts) 

SELECT COUNT(*)
FROM kitrepas
WHERE numérokitrepas NOT IN (
	SELECT numérokitrepas
	FROM abonner INNER JOIN kitrepas
	ON abonner.numéroplan = kitrepas.numéroplan);


-- 4.8. Affichez les numéros (numéroclient), les noms (nomclient) et les prénoms (prénomclient) des clients dont le prénom ne commence pas par une voyelle (en majuscule ou en minuscule) et qu’ils habitent (villeclient) à la même adresse (adressefournisseur) que le fournisseur 'Benjamin'. Ordonnez ces clients alphabétiquement selon le nom. (2pts)

SELECT "numéroclient",nomclient,prénomclient
FROM client 
WHERE strpos((SELECT DISTINCT adressefournisseur
			  FROM fournisseur 
			  WHERE nomfournisseur = 'Benjamin'),
			 villeclient) > 0 
AND "prénomclient" NOT LIKE '%[aeiouyAEIOUY]%'
ORDER BY nomclient ASC;


-- 4.9. Affichez le pays des ingrédients (paysingrédient) et le nombre d’ingrédients par pays dont le paysingrédient ne contient pas la lettre g à la troisième position de la fin; triés par ordre décroissant selon le pays de l’ingrédient (paysingrédient). (2pts) 

SELECT DISTINCT "paysingrédient", COUNT("paysingrédient")
FROM "ingrédient"
WHERE STRPOS("paysingrédient",'g') <> (LENGTH("paysingrédient")-2)
GROUP BY "paysingrédient"
ORDER BY "paysingrédient" DESC;

-- 4.10. Créez une vue 'V_fournisseur' contenant la catégorie du plan repas 'V_catégorie', l’adresse du fournisseur 'V_adresse' et le total des prix de tous les plans repas desservis par ce fournisseur 'V_tot'. Cette vue doit uniquement contenir les fournisseurs dont V_tot est supérieur à 12 500$ et dont le nom de la catégorie du plan repas contient la lettre 'e' et la lettre 'o' à la troisième position de la fin; triés par ordre croissant selon le nom de la catégorie du plan repas et par ordre décroissant selon 'V_tot'. Finalement, afficher le résultat de cette vue. (5pts)
-- à finir

CREATE OR REPLACE VIEW V_fournisseur(V_categorie,V_adresse,V_tot) AS
SELECT DISTINCT "catégorie", adressefournisseur, SUM(prix)
FROM planrepas INNER JOIN fournisseur
ON planrepas.numérofournisseur = fournisseur.numérofournisseur
GROUP BY "numéroplan", fournisseur."numérofournisseur";
