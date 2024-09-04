/* a- Table 'Label */
CREATE TABLE Label (
    id INT NOT NULL AUTO_INCREMENT,
    nom_label VARCHAR(100),
    PRIMARY KEY (id)
);

/* Insertion des données dans la table Label */
INSERT INTO Label (id, nom_label) VALUES
     ("Blackened"),
     ("Warner Bros"),
     ("Universal"),
     ("MCA"),
     ("Elektra"),
     ("Capitol"),
     ("ABC");

/* b- Table 'Artiste' */
CREATE TABLE Artiste (
    id INT NOT NULL AUTO_INCREMENT,
    nom_artiste VARCHAR(100),
    id_label INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_label) REFERENCES Label(id)
);

/* Insertion des données  dans la table Artiste */ 
INSERT INTO Artiste (id, nom_artiste, id_label) VALUES
     ("Metallica",1),
     ("Megadeth",1),
     ("Anthrax",1),
     ("Ericc Clapton",2),
     ("ZZ Top",2),
     ("Van Halen",2),
     ("Lynyrd Skynyrd",3),
     ("AC/DC",3),
     ("The Beatles",6);

/* c- Table 'Album' */
CREATE TABLE Album (
    id INT NOT NULL AUTO_INCREMENT ,
    nom_album VARCHAR(100),
    annee_enregistrement INT NOT NULL,
    id_artiste INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_artiste) REFERENCES Artiste(id)
);

/* Insertion des donnée dans la table Album */
INSERT INTO Album (nom_album, annee_enregistrement, id_artiste) VALUES
     ("And Justice For All",1988,1),
     ("Black Album",1991,1),
     ("Master of Puppets",1986,1),
     ("Endgame",2009,2),
     ("Peace Sells",1986,2),
     ("The Greater of 2 Evils",2004,3),
     ("Reptile",2001,4),
     ("Riding with King",2000,4),
     ("Greatest Hits",1992,5),
     ("Greatest Hits",2004,6),
     ("All-Time Greatest Hits",1975,7),
     ("Greatest Hits",2003,8),
     ("Sgt Pepper s ",1967,9);

CREATE TABLE Chanson(
     id INT NOT NULL AUTO_INCREMENT,
     nom_chanson VARCHAR(100),
     duree_chanson TIME,
     id_album INT NOT NULL,
     PRIMARY KEY (id),
     FOREIGN KEY (id_album) REFERENCES Album(id)
     );

/* Insertion des donnée dans la table Chanson */
    INSERT INTO Chanson (nom_chanson, duree_chanson ,id_album) VALUES
     ("One","7.25",1),
     ("Blackend","6.42",1),
     ("Enter Sandman","5.3",2),
     ("Sad but true","5.29",2),
     ("Master of Puppets","8.35",3),
     ("Battery","5.13",3),
     ("Dialectic Chaos","2.26",4),
     ("Endgame","5.57",4),
     ("Peace Sells","4.09",5),
     ("The Conjuring","5.09",5),
     ("Madhouse","4.26",6),
     ("I am the law","6.03",6),
     ("Reptile","3.36",7),
     ("Modem Girl","4.49",7),
     ("Riding with the King","4.23",8),
     ("Key to the Highway","3.39",8),
     ("Sharp Dressed Man","4.15",9),
     ("Legs","4.32",9),
     ("Eruption","3.39",10),
     ("Hot For Teacher ","4.43",10),
     ("Sweet Home Alabama","4.45",11),
     ("Free Bird","14.23",11),
     ("Thunderstruck","4.52",12),
     ("TNT","3.35",12),
     ("Sgt Pepper s","2.0333",13),
     ("With a little help from friends","2.7333",13),
     ("Lucy in the Sky with Diamonds","3.4666",13),
     ("Getting Better","2.8",13),
     ("Fixing a Hole","2.6",13),
     ("She s Leaving Home","3.5833",13),
     ("Being for the Benefit of Mr.Kite!","2.6166",13),
     ("Within You Without You","5.066",13),
     ("When I am Sixty-Four","2.6166",13),
     ("Lovely Rita","2.7",13),
     ("Good Morning Good Morning","2.6833",13),
     ("Sgt Pepper s","1.3166",13),
     ("A day in the Life","5.65",13);  

