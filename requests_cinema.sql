-- Informations d'un film avec la durée au format HH MM
-- Fonctionnel mais au format H M.

SELECT 
	f.id_film,
	f.titre_film, 
	DATE_FORMAT(annee_sortie, "%Y") AS release_date,
	CONCAT(CAST(f.duree_film DIV 60 AS FLOAT), 'H', CAST(f.duree_film % 60 AS FLOAT)) AS duree,
	CONCAT(p.prenom, ' ', p.nom) AS nom_realisateur
	
FROM film f
	INNER JOIN realisateur r
		ON f.id_realisateur = r.id_realisateur
	INNER JOIN personne p
		ON r.id_personne = p.id_personne

    WHERE id_film = 1 -- Selection des infos qu'on souhaite par l'ID film.

-- Liste des films dont la durée excède 2h15 classés par odre du + long au + court)

SELECT f.titre_film, df.duree

FROM film f
    INNER JOIN detail_film df
   		ON f.id_film = df.id_film

WHERE f.duree_film > 135
ORDER BY f.duree_film DESC

-- Liste des films d'un réalisateur en précisant la release Date

SELECT
	f.titre_film,
	DATE_FORMAT(f.annee_sortie, "%Y") AS annee_sortie
	
FROM film f
	INNER JOIN realisateur r
		ON f.id_realisateur = r.id_realisateur
	INNER JOIN personne p
		ON r.id_personne = p.id_personne
	
WHERE p.nom = 'Nolan'

-- Nombre films par Genre classés dans l'ordre décroissant

SELECT 	
	g.nom_genre,
	COUNT(f.id_film) AS nombre_films

FROM film f
	INNER JOIN appartenir a
		ON f.id_film = a.id_film
	INNER JOIN genre g
		ON a.id_genre = g.id_genre	

GROUP BY g.nom_genre
ORDER BY nombre_films DESC

-- Casting d'un film en particulier (id film) : Nom, prenom sexe des acteurs

SELECT p.nom, p.prenom, p.sexe

FROM film f
	INNER JOIN casting c
		ON f.id_film = c.id_film
	INNER JOIN acteur a
		ON c.id_acteur = a.id_acteur
	INNER JOIN personne p
		ON a.id_personne = p.id_personne
		
WHERE f.id_film = 1

-- Films tournés par un acteur en particulier (id_acteur) avec leur rôle, l'année de sortie (du film + récent au + ancien)

SELECT f.titre_film, DATE_FORMAT(f.annee_sortie, '%Y') AS date_sortie, r.nom_role

FROM film f
	INNER JOIN casting c
		ON f.id_film = c.id_film
	INNER JOIN role r
		ON c.id_role = r.id_role

WHERE id_acteur = 10

ORDER BY date_sortie DESC

-- Liste des personnes qui sont à la fois acteurs et réalisateurs

SELECT p.nom, p.prenom

FROM personne p
	INNER JOIN realisateur r
		ON p.id_personne = r.id_personne
	INNER JOIN acteur a
		ON a.id_personne = r.id_personne

-- Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)

SELECT f.titre_film, DATE_FORMAT(f.annee_sortie, '%Y') AS date_sortie

FROM film f

WHERE (date_format(NOW(), '%Y') - DATE_FORMAT(f.annee_sortie, '%Y')) < 5

ORDER BY f.annee_sortie DESC 
