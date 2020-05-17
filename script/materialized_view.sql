DROP TABLE IF EXISTS MV_Tempi_Percorrenza;

CREATE TABLE MV_Tempi_Percorrenza(
	IdentificatoreStrada VARCHAR(100),
    MinutiMediPercorrenza DOUBLE,
    NumeroAttuazioni INT,
    PRIMARY KEY(IdentificatoreStrada), 
    CONSTRAINT FK_TempiPercorrenza_Strada
	FOREIGN KEY (IdentificatoreStrada)
	REFERENCES Strada(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)Engine = InnoDB Default Charset = latin1;

INSERT INTO MV_Tempi_Percorrenza
SELECT S.IdentificatoreStrada, 0, 0
FROM Strada S;

DROP TABLE IF EXISTS MV_Tempi_Traffico;

CREATE TABLE MV_Tempi_Traffico(
	IdentificatoreStrada VARCHAR(100) NOT NULL,
    MinutiMediPercorrenza DOUBLE,
    NumeroAttuazioni INT,
    PRIMARY KEY(IdentificatoreStrada), 
    CONSTRAINT FK_TempiTraffico_Strada
	FOREIGN KEY (IdentificatoreStrada)
	REFERENCES Strada(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)Engine = InnoDB Default Charset = latin1;

INSERT INTO MV_Tempi_Traffico
SELECT S.IdentificatoreStrada, 0, 0
FROM Strada S;


DROP TABLE IF EXISTS MV_Affidabilita_Utente;

CREATE TABLE MV_Affidabilita_Utente(
	NomeUtente VARCHAR(100) NOT NULL,
    Affidabilita DOUBLE,
    PRIMARY KEY(NomeUtente),
    CONSTRAINT FK_Affidabilita_NomeUtente
    FOREIGN KEY (NomeUtente)
    REFERENCES Account(NomeUtente)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)Engine = InnoDB Default Charset = latin1;

INSERT INTO MV_Affidabilita_Utente
SELECT A.NomeUtente, 0
FROM Account A;


DROP EVENT IF EXISTS aggiorna_tempi_medi;

DELIMITER $$
CREATE EVENT aggiorna_tempi_medi
ON SCHEDULE EVERY 1 DAY
DO
BEGIN 
	CALL chiama_tragitti_medi();
END $$

DELIMITER ;


DROP EVENT IF EXISTS aggiorna_tempi_traffico;
DELIMITER $$
CREATE EVENT aggiorna_tempi_traffico
ON SCHEDULE EVERY 1 DAY
DO
BEGIN 
	CALL chiama_tragitti_traffico();
END $$

DELIMITER ;


DROP EVENT IF EXISTS aggiorna_affidabilita_utente;
DELIMITER $$
CREATE EVENT aggiorna_affidabilita_utente
ON SCHEDULE EVERY 5 DAY
DO
BEGIN 
	CALL chiama_utenti();
END $$

DELIMITER ;
