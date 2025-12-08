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
--         ON DELETE SET NULL
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
--     date_debut DATE,
--     date_retour DATE,
--     etudiant_id INT REFERENCES etudiant(id)
--         ON DELETE SET NULL,
--     livre_id INT REFERENCES livre(id)
--         ON DELETE SET NULL
-- );

INSERT INTO auteur (nom) VALUES
('Victor Hugo'),
('Jane Austen'),
('Albert Camus');

INSERT INTO livre (titre, annee_publication, auteur_id) VALUES
('Victor Hugo'),
('Jane Austen'),
('Albert Camus');
