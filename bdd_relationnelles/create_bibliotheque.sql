-- -- -- Table auteur
--  CREATE TABLE auteur (
--     id SERIAL PRIMARY KEY,
--     nom VARCHAR(255) NOT NULL,
--     nationnalite varchar
--  );

-- -- Table Livre
-- CREATE TABLE livre (
--     id SERIAL PRIMARY KEY,
--     titre VARCHAR(255) NOT NULL,
--     annee_publication INT,
--     auteur_id INT REFERENCES auteur(id)
--         ON DELETE SET NULL -- si l'auteur n'existe plus on met NULL
-- );

-- -- Table departement
-- CREATE TABLE departement (
--     id SERIAL PRIMARY KEY,
--     nom VARCHAR(255) NOT NULL
-- );
-- -- Table etudiant
-- CREATE TABLE etudiant (
--     id SERIAL PRIMARY KEY,
--     nom VARCHAR(255) NOT NULL,
--     departement_id INT REFERENCES departement(id)
--         ON DELETE SET NULL
-- );



-- -- Table emprunt
-- CREATE TABLE emprunt (
--     id SERIAL PRIMARY KEY,
--     date_debut DATE NOT NULL,
--     date_retour DATE,
--     etudiant_id INT REFERENCES etudiant(id)
--         ON DELETE CASCADE,
--     livre_id INT REFERENCES livre(id)
--         ON DELETE CASCADE
-- );

-- Insertion dans auteur
INSERT INTO auteur (nom) VALUES
('Victor Hugo'),
('Jane Austen'),
('Albert Camus');

SELECT * FROM auteur;

-- Insertion dans livre
INSERT INTO livre (titre, annee_publication, auteur_id) VALUES
('Les Miserables', 1862, 1),
('Pride and Prejudice', 1813, 2),
('L Etranger', 1942, 3);

SELECT * FROM livre;