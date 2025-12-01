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

-- Lister toutes les commandes de Bob Martin
SELECT * FROM clients c INNER JOIN commandes o ON c.client_id = o.client_id
WHERE c.nom LIKE 'Bob Martin';
