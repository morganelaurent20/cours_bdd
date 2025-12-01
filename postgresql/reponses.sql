--Affiche tous les clients inscrits en 2025.
SELECT * FROM clients
WHERE date_inscription > '2024-12-31';

--Affiche uniquement les noms et emails des clients dont le nom contient la lettre "e".
SELECT nom, email FROM clients
WHERE nom LIKE '%e%';

--Affiche les clients dont l’email est nul.
SELECT * FROM clients
WHERE email IS NULL;

--Affiche les clients dont l’id est compris entre 5 et 10.
SELECT * FROM clients
WHERE client_id BETWEEN 5 AND 10;

--Affiche les clients dont le nom ne commence pas par "M".
SELECT * FROM clients
WHERE nom NOT LIKE  'M%';

--Affiche les clients inscrits avant 2023 ou dont le nom contient "ad".
SELECT * FROM clients
WHERE date_inscription < '2024-01-01' OR nom LIKE '%ad%';

--Affiche les clients dont l’email appartient à une liste donnée (IN).
SELECT * FROM clients
WHERE email IN ('claire.leroy@yahoo.com', 'nicolas.girard@example.com');

--Affiche les clients dont la date d’inscription est comprise entre janvier et mars 2024.
SELECT * FROM clients
WHERE date_inscription BETWEEN '2024-01-01' AND '2024-03-31';

--Affiche les clients dont le nom est différent de "Dupont".
SELECT * FROM clients
WHERE nom NOT LIKE  'Dupont';


-- JOINTURES 

-- INNER JOIN : clients et commandes
-- Lister toutes les commandes de Bob Martin
SELECT c.nom, c.email, o.commande_id, o.date_commande, o.statut 
FROM clients c INNER JOIN commandes o ON c.client_id = o.client_id
WHERE c.nom LIKE 'Bob Martin';


-- LEFT JOIN : tous les clients, même sans commande
SELECT c.nom, c.email, co.commande_id
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id;

-- Jointure multiple : commandes et produits
SELECT co.commande_id, c.nom AS client, p.nom AS produit, lc.quantite
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id;

-- FULL OUTER JOIN : clients et commandes
SELECT c.nom, co.commande_id
FROM clients c
FULL OUTER JOIN commandes co ON c.client_id = co.client_id;

-- CROSS JOIN : produit cartésien
SELECT c.nom, p.nom
FROM clients c
CROSS JOIN produits p;


-- Exercices pratiques


-- Affiche la liste des clients avec leurs commandes (même ceux qui n’ont pas de commande).
SELECT c.nom, c.email, co.commande_id
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id;

-- Affiche toutes les commandes avec le nom du client et leur statut.
SELECT co.commande_id, c.nom, co.statut
FROM commandes co
INNER JOIN clients c on co.client_id = c.client_id;

-- Affiche les produits commandés par "Alice Dupont".
SELECT c.nom, c.email, p.nom 
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
WHERE c.nom LIKE 'Alice Dupont';

-- Affiche les clients qui n’ont jamais passé de commande.
SELECT co.commande_id, c.nom
FROM commandes co
LEFT JOIN clients c on co.client_id = c.client_id
WHERE co.commande_id IS NULL;

-- Affiche toutes les commandes avec les produits associés et la quantité commandée.
SELECT co.commande_id, p.nom AS produit, lc.quantite
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id;

-- Affiche les clients et les produits qu’ils ont commandés, en utilisant une jointure multiple.
SELECT DISTINCT c.nom AS client, p.nom AS produit
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id;

-- Affiche toutes les commandes, même celles sans client (test avec FULL OUTER JOIN).
SELECT c.nom, co.commande_id
FROM clients c
FULL OUTER JOIN commandes co ON c.client_id = co.client_id;

-- Affiche toutes les combinaisons possibles entre clients et produits (CROSS JOIN).
SELECT c.nom, p.nom
FROM clients c
CROSS JOIN produits p;

-- Affiche les clients qui ont commandé au moins deux produits différents.


-- Affiche les produits qui n’ont jamais été commandés.



-- Les fonctions d’agrégation en SQL

--Exemples pratiques 

--a) Nombre total de clients
SELECT COUNT(*) AS nb_clients FROM clients;

--b) Prix maximum et minimum des produits
SELECT MAX(prix) AS prix_max, MIN(prix) AS prix_min FROM produits;

--c) Moyenne du prix des produits
SELECT AVG(prix) AS prix_moyen FROM produits;

--d) Somme des quantités commandées
SELECT SUM(quantite) AS total_quantites FROM lignes_commandes;

--e) Écart-type du prix des produits
SELECT STDDEV(prix) AS dispersion_prix FROM produits;

--f) Agrégation avec GROUP BY : total par client
SELECT c.nom, COUNT(co.commande_id) AS nb_commandes
FROM clients c
LEFT JOIN commandes co ON c.client_id = co.client_id
GROUP BY c.nom;

-- Les calculs arithmétiques en SQL

--Exemples pratiques

--a) Calculer le montant total d’une ligne de commande
SELECT ligne_id, quantite * prix_unitaire AS montant_total
FROM lignes_commandes;

--b) Augmenter tous les prix de 5%
SELECT produit_id, nom, prix, prix * 1.05 AS prix_augmenté
FROM produits;

--c) Calculer le nombre de commandes par année
SELECT EXTRACT(YEAR FROM date_commande) AS annee,
       COUNT(*) AS nb_commandes
FROM commandes
GROUP BY annee;

-- Exercices pratiques

--Compter le nombre de produits disponibles dans la table produits.
SELECT COUNT (*) AS Nb_produits FROM produits;

--Afficher le prix moyen des produits par catégorie (GROUP BY categorie).
SELECT categorie, AVG(prix) AS prix_moyen FROM produits
GROUP BY categorie;

--Calculer le montant total de chaque commande (somme des quantite * prix_unitaire).
SELECT commande_id, sum(quantite * prix_unitaire) AS montant_total
FROM lignes_commandes
group by commande_id;

--Afficher le client qui a passé le plus de commandes.
SELECT c.nom, COUNT(co.commande_id) AS nb_commandes
FROM commandes co
JOIN clients c ON c.client_id = co.client_id
GROUP BY c.nom
HAVING COUNT(co.commande_id) = (
    SELECT MAX(nb)
    FROM (
        SELECT COUNT(*) AS nb
        FROM commandes
        GROUP BY client_id
    ) AS t
);

--Calculer la somme des stocks disponibles par famille de produits.
SELECT p.nom, sum(lc.quantite) AS nb_stock
FROM lignes_commandes lc
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY p.nom;

--Afficher l’écart-type des prix des produits pour analyser la dispersion par catégorie.
SELECT categorie, STDDEV(prix) AS dispersion_prix 
FROM produits
GROUP BY categorie;

--Calculer le montant total des ventes par client.
SELECT c.nom, sum(lc.prix_unitaire) AS nb_commandes
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY c.nom;

--Afficher les commandes passées en 2025 et leur nombre.
SELECT EXTRACT(YEAR FROM date_commande) AS annee,
       COUNT(*) AS nb_commandes
FROM commandes
WHERE EXTRACT(YEAR FROM date_commande) = '2025'
GROUP BY annee;

--Calculer le prix minimum, maximum et moyen des produits commandés par catégorie.
SELECT categorie, MAX(prix) AS prix_max, MIN(prix) AS prix_min, AVG(prix) AS prix_moyen 
FROM produits 
GROUP BY categorie;

--Afficher les produits dont le stock est un multiple de 5 (utiliser %).
SELECT p.nom, SUM(lc.quantite) AS nb_stock
FROM lignes_commandes lc
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY p.nom
HAVING SUM(lc.quantite) % 5 = 0;
