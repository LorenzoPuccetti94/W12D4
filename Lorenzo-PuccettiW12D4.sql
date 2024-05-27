/*Creazione del database richiesto*/
 CREATE DATABASE ToysGroup;
 
 /*creazione delle tabelle*/
CREATE TABLE `prodotto` (
  `id_prodotto` int NOT NULL,
  `prezzo` decimal(10,2) DEFAULT NULL,
  `descrizione` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_prodotto`)
) 
;

INSERT INTO prodotto (id_prodotto, prezzo, descrizione)
VALUES (1, 10, 'Dinosauro');
INSERT INTO prodotto (id_prodotto, prezzo, descrizione)
VALUES (2, 20, 'Cavalluccio');
INSERT INTO prodotto (id_prodotto, prezzo, descrizione)
VALUES (3, 30, 'Pupazzo');
 
 
CREATE TABLE `vendite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_vendita` date NOT NULL,
  `id_regione` int NOT NULL,
  `id_prodotto` int NOT NULL,
  `prezzo_vendita` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Vendite_aree_FK` (`id_regione`),
  KEY `Vendite_prodotto_FK` (`id_prodotto`),
  CONSTRAINT `Vendite_aree_FK` FOREIGN KEY (`id_regione`) REFERENCES `aree` (`cod_reg`),
  CONSTRAINT `Vendite_prodotto_FK` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
)
 ;
 
 INSERT INTO vendite (id, data_vendita, id_regione, id_prodotto, prezzo_vendita)
VALUES (1, 2021-10-10, 1, 1);
INSERT INTO vendite (id, data_vendita, id_regione, id_prodotto, prezzo_vendita)
VALUES (2, 1990-11-12, 1, 2);
INSERT INTO vendite (id, data_vendita, id_regione, id_prodotto, prezzo_vendita)
VALUES (3, 2008-03-04, 3, 1);
INSERT INTO vendite (id, data_vendita, id_regione, id_prodotto, prezzo_vendita)
VALUES (4, 2008-03-07, 1, 1);

 
CREATE TABLE `aree` (
  `cod_reg` int NOT NULL,
  `nome` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`cod_reg`)
;
 INSERT INTO aree (cod_reg, nome)
VALUES (1, 'Toscana');
 INSERT INTO aree (cod_reg, nome)
VALUES (1, 'Marche');
 INSERT INTO aree (cod_reg, nome)
VALUES (1, 'Emilia_Romagna');

ALTER TABLE toysgroup.aree DROP COLUMN cod_prodotto;
CREATE TABLE toysgroup.Vendite (
	id INT auto_increment NOT NULL,
	data_vendita DATE NOT NULL,
	id_regione INT NOT NULL,
	id_prodotto INT NOT NULL,
	prezzo_vendita DECIMAL NOT NULL,
	CONSTRAINT Vendite_pk PRIMARY KEY (id),
	CONSTRAINT Vendite_aree_FK FOREIGN KEY (id_regione) REFERENCES toysgroup.aree(cod_reg),
	CONSTRAINT Vendite_prodotto_FK FOREIGN KEY (id_prodotto) REFERENCES toysgroup.prodotto(id_prodotto)
)
;


select sum(vendite.prezzo_vendita) as fatturato, max(year(vendite.data_vendita)) as anno
from vendite 
group by year(vendite.data_vendita) 
;


select sum(vendite.prezzo_vendita) as fatturato, aree.nome 
from vendite join aree on cod_reg = vendite.id_regione
group by vendite.id_regione
;


select count(vendite.id_prodotto)
from vendite 
group by vendite.id_prodotto 
limit 1
;

select prodotto.id_prodotto, prodotto.descrizione
from prodotto  
where prodotto.id_prodotto not in (select distinct vendite.id_prodotto from vendite)

;
