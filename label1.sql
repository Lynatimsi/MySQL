/* 1- Lister tous les artistes pour chaque label,classé par nom d'artiste */
SELECT Artiste.nom_artiste, Label.nom_label 
FROM Artiste
JOIN Label ON Artiste.id_label = Label.id
ORDER BY  Artiste.nom_artiste, Label.nom_label;

/* 2- Lister les labels qui n’ont pas d’artistes */
SELECT Label.nom_label 
FROM Label 
LEFT JOIN Artiste  ON Label.id = Artiste.id_label /* pour sélectionner meme les labels qui n'ont pas d'artistes associés */
WHERE Artiste.id IS NULL;

/* 3- Lister le nombre de chansons par artiste dans l'ordre décroissant */
SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons 
FROM Artiste
LEFT JOIN Album ON Album.id_artiste = Artiste.id
LEFT JOIN Chanson ON Chanson.id_album = Album.id
GROUP BY Artiste.id
ORDER BY nb_chansons DESC;

/* 4- Lister le ou les artistes qui ont enregistré le plus de chansons dans la base, avec le nombre de chansons enregistrées */
SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons 
FROM Artiste
LEFT JOIN Album ON Album.id_artiste = Artiste.id
LEFT JOIN Chanson ON Chanson.id_album = Album.id
GROUP BY Artiste.id
ORDER BY nb_chansons DESC
LIMIT 1;

/* 5- Lister les artistes qui ont enregistré le moins de chansons, avec le nombre de chansons */
SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons 
FROM Artiste
LEFT JOIN Album ON Album.id_artiste = Artiste.id
LEFT JOIN Chanson ON Chanson.id_album = Album.id
GROUP BY Artiste.id
ORDER BY nb_chansons ASC;

/* 6- - Afficher le nombre d’artistes qui ont enregistré le moins de chansons dans la base */
SELECT COUNT(*) AS nb_artistes
FROM (
    SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons 
    FROM Artiste
    LEFT JOIN Album ON Album.id_artiste = Artiste.id
    LEFT JOIN Chanson ON Chanson.id_album = Album.id
    GROUP BY Artiste.id
    ORDER BY nb_chansons ASC
) AS artistes_avec_nb_chansons WHERE nb_chansons = (
    SELECT MIN(nb_chansons) 
    FROM (
        SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons 
        FROM Artiste
        LEFT JOIN Album ON Album.id_artiste = Artiste.id
        LEFT JOIN Chanson ON Chanson.id_album = Album.id
        GROUP BY Artiste.id
        ORDER BY nb_chansons ASC
    ) AS artistes_avec_nb_chansons );

/* 7- Lister les artistes qui ont enregistré des chansons plus longues que 5 minutes,avec le nombre de chansons correspondantes.*/
SELECT Artiste.nom_artiste, COUNT(Chanson.id) AS nb_chansons_longues 
FROM Artiste 
JOIN Album  ON Album.id_artiste =Artiste.id
JOIN Chanson  ON Chanson.id_album = Album.id
WHERE Chanson.duree_chanson > "5.00"
GROUP BY Artiste.nom_artiste;

/* 8- Pour chaque album de chaque artiste, combien de chansons étaient moins longues que 5 minutes ? */
SELECT Artiste.nom_artiste, Album.nom_album, COUNT(Chanson.id) AS nb_chansons_courtes 
FROM Artiste
LEFT JOIN Album ON  Album.id_artiste = Artiste.id 
LEFT JOIN Chanson ON  Chanson.id_album = Album.id 
WHERE Chanson.duree_chanson <= "5.00"
GROUP BY Artiste.nom_artiste, Album.nom_album;

/* 9- Afficher l’années où il y a eu le plus de chansons enregistrées, avec le nombre de chansons correspondante */
SELECT annee_enregistrement, COUNT(Chanson.id) AS nb_chansons 
FROM Album
LEFT JOIN Chanson ON  Chanson.id_album = Album.id
GROUP BY annee_enregistrement
ORDER BY nb_chansons DESC
LIMIT 1;

/* 10- Lister les artistes avec leur chansons et l’année qui sont dans le top 5 des chansons les plus longues  */
SELECT Artiste.nom_artiste, Chanson.nom_chanson, Album.annee_enregistrement 
FROM Artiste
LEFT JOIN Album ON  Album.id_artiste = Artiste.id
LEFT JOIN Chanson ON  Chanson.id_album = Album.id
WHERE Chanson.id IN (
    SELECT id 
    FROM Chanson
    ORDER BY duree_chanson DESC
    LIMIT 5);

/* 11- Lister le nombre d’albums enregistrés par année */
SELECT annee_enregistrement, COUNT(*) AS nb_albums 
FROM Album
GROUP BY annee_enregistrement;

/* 12- Afficher le nombre maximum d’albums enregistrés sur toutes les années */
SELECT MAX(nb_albums) AS max_albums
FROM (
      SELECT annee_enregistrement, COUNT(*) AS nb_albums 
      FROM Album
      GROUP BY annee_enregistrement) AS albums_par_annee;

/* 13- Afficher la ou les années où on a eu le maximum d’albums enregistrés, avec le maximum correspondant */
SELECT annee_enregistrement, COUNT(*) AS nb_albums 
FROM Album
GROUP BY annee_enregistrement
HAVING COUNT(*) = (
    SELECT MAX(nb_albums)
    FROM (
        SELECT COUNT(*) AS nb_albums 
        FROM Album
        GROUP BY annee_enregistrement
    ) AS albums_par_annee);

/* 14- Lister la durée totale des chansons enregistrées par chaque artiste dans l’ordre décroissant */
SELECT Artiste.nom_artiste, SUM(TIME_TO_SEC(Chanson.duree_chanson)) AS duree_totale 
FROM Artiste /* TIME_TO_SEC pour convertir le total en format minutes:secondes.*/
LEFT JOIN Album ON Album.id_artiste = Artiste.id
LEFT JOIN Chanson ON Chanson.id_album = Album.id
GROUP BY Artiste.nom_artiste
ORDER BY duree_totale DESC;

/* 15- Lister le ou les albums d’artistes qui n’ont pas de chansons plus courte que 5 minutes */
SELECT Artiste.nom_artiste, Album.nom_album  
FROM Album
LEFT JOIN Artiste ON Artiste.id = Album.id_artiste 
WHERE Album.id NOT IN (
    SELECT Album.id 
    FROM Album
    LEFT JOIN Chanson ON Album.id = Chanson.id_album
    WHERE Chanson.duree_chanson < "5.00" );

/* 16- Afficher une table de résultat avec tous les artistes, albums, chansons et durée des chansons, tous dans l’ordre croissant par artiste, album et chanson */
SELECT Artiste.nom_artiste, Album.nom_album, Chanson.nom_chanson, Chanson.duree_chanson 
FROM Artiste
LEFT JOIN Album ON Album.id_artiste = Artiste.id 
LEFT JOIN Chanson ON Chanson.id_album = Album.id 
ORDER BY Artiste.nom_artiste, Album.nom_album, Chanson.nom_chanson;

/* 17- Lister le top 3 des artistes avec la plus longue moyenne de durée de chanson, dans l’ordre descendant (avec en premier la moyenne la plus longue) */
SELECT Artiste.nom_artiste, AVG(TIME_TO_SEC(Chanson.duree_chanson)) AS moyenne_duree_chanson 
FROM Artiste
LEFT JOIN Album ON Album.id_artiste = Artiste.id 
LEFT JOIN Chanson ON Chanson.id_album =  Album.id 
GROUP BY Artiste.nom_artiste
ORDER BY moyenne_duree_chanson DESC
LIMIT 3;

/* 18- Afficher la durée totale d’album pour toutes les chansons de l’album des Beatles Sgt. Pepper's en minutes et secondes */
SELECT Album.nom_album, SEC_TO_TIME(SUM(TIME_TO_SEC(Chanson.duree_chanson))) AS duree_totale 
FROM Album
JOIN Artiste ON  Album.id_artiste = Artiste.id
JOIN Chanson ON  Chanson.id_album = Album.id 
WHERE Artiste.nom_artiste = "The Beatles" AND Album.nom_album = "Sgt. Pepper’s"
GROUP BY Album.nom_album;

/* 19- - Lister les artistes qui n’ont pas sorti d’album pendant les décenies 1980’s et 1990’s */ 
SELECT Artiste.nom_artiste 
FROM Artiste
WHERE Artiste.id NOT IN (
    SELECT DISTINCT Album.id_artiste 
    FROM Album
    WHERE Album.annee_enregistrement BETWEEN 1980 AND 1999);

/* 20- Lister les artistes qui ont sorti un album pendant les décennies 1980’s et 1990’s */
SELECT DISTINCT Artiste.nom_artiste 
FROM Artiste
JOIN Album ON  Album.id_artiste = Artiste.id 
WHERE Album.annee_enregistrement BETWEEN 1980 AND 1999;