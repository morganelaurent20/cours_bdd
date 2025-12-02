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

-- HAVING 

-- TEST 
SELECT
    client_id,
    COUNT(client_id) AS nombre_commandes
FROM
    Commandes
GROUP BY
    client_id
HAVING
    COUNT(client_id) < 3;


--Exercices pratiques

--Afficher les catégories de produits dont le prix moyen est supérieur à 800
SELECT p.categorie, AVG(p.prix) AS prix_moyen
FROM produits p
GROUP BY p.categorie
HAVING AVG(p.prix) > 800;

--Afficher les commandes dont le montant total (somme des quantités × prix unitaire) dépasse 1000.
SELECT commande_id, sum(quantite * prix_unitaire) AS montant_total
FROM lignes_commandes
group by commande_id
HAVING sum(quantite * prix_unitaire) > 1000;

--Afficher les familles de produits dont le stock cumulé est inférieur à 50.
SELECT p.nom, SUM(lc.quantite) AS nb_stock
FROM lignes_commandes lc
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY p.nom
HAVING SUM(lc.quantite) < 50;

-- Les sous‑requêtes (subqueries)

-- Exemples pratiques
-- a) Clients ayant passé au moins une commande
SELECT nom, email
FROM clients
WHERE client_id IN (
    SELECT client_id
    FROM commandes
);

--b) Produits dont le prix est supérieur au prix moyen
SELECT nom, prix
FROM produits
WHERE prix > (
    SELECT AVG(prix) FROM produits
);

-- c) Nombre de commandes par client (sous‑requête dans SELECT)
SELECT c.nom,
       (SELECT COUNT(*) FROM commandes co WHERE co.client_id = c.client_id) AS nb_commandes
FROM clients c;


--L’opérateur CASE

--2. Exemples pratiques
--a) Catégoriser les produits selon leur prix
SELECT nom,
       prix,
       CASE
           WHEN prix < 20 THEN 'Bon marché'
           WHEN prix BETWEEN 20 AND 100 THEN 'Moyen'
           ELSE 'Cher'
       END AS categorie_prix
FROM produits;

--b) Traduire le statut des commandes
SELECT commande_id,
       statut,
       CASE statut
           WHEN 'en cours' THEN 'Commande en préparation'
           WHEN 'livrée' THEN 'Commande terminée'
           WHEN 'annulée' THEN 'Commande annulée'
           ELSE 'Statut inconnu'
       END AS statut_detail
FROM commandes;

--c) Vérifier si un client a renseigné son email
SELECT nom,
       CASE
           WHEN email IS NULL THEN 'Email manquant'
           ELSE 'Email renseigné'
       END AS info_email
FROM clients;

--Exercices pratiques

--Afficher les produits dont le prix est supérieur au prix moyen (sous‑requête).
SELECT nom, prix
FROM produits
WHERE prix > (
    SELECT AVG(prix) FROM produits
);

--Afficher les clients qui ont passé au moins deux commandes (sous‑requête avec COUNT).
SELECT c.nom, COUNT(co.commande_id) AS nb_commandes
FROM clients c
INNER JOIN commandes co on co.client_id = c.client_id
WHERE (SELECT COUNT(*) FROM commandes co WHERE co.client_id = c.client_id) > 1
GROUP BY c.nom;

--Afficher les commandes avec une colonne supplémentaire indiquant si elles sont "récentes" (après 2025‑01‑01) ou "anciennes" (avant).
SELECT commande_id,
       date_commande,
       CASE 
           WHEN date_commande > '2025-01-01'::date THEN 'récentes'
           ELSE 'anciennes'
       END AS ancienneté
FROM commandes;

--Catégoriser les produits en trois classes de prix : bas, moyen, élevé (avec CASE).
SELECT nom,
      prix,
      CASE
          WHEN prix < 20 THEN 'bas'
          WHEN prix BETWEEN 20 AND 100 THEN 'Moyen'
          ELSE 'élevé'
      END AS categorie_prix
FROM produits;

--Afficher les clients avec une colonne indiquant "nouveau" si inscrits après 2024, sinon "ancien".
SELECT client_id,
       date_inscription,
       CASE 
           WHEN EXTRACT(YEAR FROM date_inscription) > 2024 THEN 'nouveau'
           ELSE 'ancien'
       END AS ancienneté
FROM clients;


--Afficher les produits commandés et ajouter une colonne "stock critique" si le stock est inférieur à 5.
SELECT p.produit_id, p.nom, 
       SUM(lc.quantite) AS stock, 
       CASE 
           WHEN SUM(lc.quantite) < 5 THEN 'Stock critique'
           ELSE 'Stock suffisant'
       END AS stock_critique
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
GROUP BY p.produit_id;

--Utiliser une sous‑requête pour afficher le produit le plus cher commandé par chaque client.
SELECT c.nom, p.prix, p.nom
FROM commandes co
INNER JOIN clients c ON co.client_id = c.client_id
INNER JOIN lignes_commandes lc ON co.commande_id = lc.commande_id
INNER JOIN produits p ON lc.produit_id = p.produit_id
WHERE (c.client_id, p.prix) IN (
    SELECT co2.client_id, MAX(p2.prix)
    FROM commandes co2
    JOIN lignes_commandes lc2 ON co2.commande_id = lc2.commande_id
    INNER JOIN produits p2 ON lc2.produit_id = p2.produit_id
    GROUP BY co2.client_id
);

--Afficher les commandes avec une colonne "statut détaillé" traduite en français (avec CASE).


--Afficher les clients qui n’ont jamais passé de commande (sous‑requête avec NOT IN).


--Afficher les lignes de commande avec une colonne calculée "montant_total" et une classification : "petite commande" (<50), "moyenne" (50‑200), "grande" (>200)