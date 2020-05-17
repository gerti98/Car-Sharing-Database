-- ---------------------------------
--  Operazione 1 -- Iscrizione Utente V
-- ---------------------------------

DROP PROCEDURE IF EXISTS Iscrizione_Utente;


DELIMITER $$

CREATE PROCEDURE Iscrizione_Utente(IN _NomeUtente VARCHAR(100), 
								   IN _Password VARCHAR(100), 
                                   IN _DomandaDiRiserva VARCHAR(100),
                                   IN _RispostaDiRiserva VARCHAR(100),
                                   IN _CodiceFiscale VARCHAR(100))
BEGIN
	DECLARE statoUtente VARCHAR(100) DEFAULT 'inattivo';
    
	INSERT INTO Account
    VALUES(_NomeUtente, _Password, _DomandaDiRiserva, _RispostaDiRiserva, statoUtente, current_date(), _CodiceFiscale);
END $$

DELIMITER ;

-- ------------------------------------------
--  Operazione 2 -- Registrazione Autovettura
-- ------------------------------------------

DROP PROCEDURE IF EXISTS Registrazione_Autovettura;

DELIMITER $$
CREATE PROCEDURE Registrazione_Autovettura(IN _Targa VARCHAR(100),
										   IN _Modello VARCHAR(100),
                                           IN _CasaProduttrice VARCHAR(100),
                                           IN _AnnoImmatricolazione INT,
                                           IN _Cilindrata DOUBLE,
                                           IN _CostoOperativo DOUBLE,
                                           IN _CostoUsura DOUBLE,
                                           IN _VelocitaMax DOUBLE,
                                           IN _CarburanteCurr DOUBLE,
                                           IN _KmPercorsi INT,
                                           IN _ConsumoUrbano DOUBLE,
                                           IN _CapacitaSerbatoio DOUBLE,
                                           IN _ConsumoMisto DOUBLE,
                                           IN _ConsumoExtraurbano DOUBLE,
                                           IN _TipoAlimentazione VARCHAR(100),
                                           IN _Rumore DOUBLE,
                                           IN _DimensioneBagagliaio DOUBLE,
                                           IN _TavoliPosteriori TINYINT,
                                           IN _Connettivita TINYINT,
                                           IN _TettoInVetro TINYINT,
                                           IN _NomeUtente VARCHAR(100))
BEGIN 
	DECLARE disponibilita CHAR(100) DEFAULT "disponibile";
    
	INSERT INTO autovettura
    VALUES(_Targa, _CostoOperativo, _Modello, _CostoUsura, _CasaProduttrice, disponibilita, _AnnoImmatricolazione, _Cilindrata, _VelocitaMax);
    
    INSERT INTO optional
    VALUES(_Targa, _TavoliPosteriori, _TettoInVetro, _DimensioneBagagliaio, _Connettivita, _Rumore);
    
    INSERT INTO Consumo
    VALUES(_Targa, _CapacitaSerbatoio, _ConsumoUrbano, _ConsumoMisto, _TipoAlimentazione, _ConsumoExtraurbano);
    
    INSERT INTO stato_veicolo
    VALUES(_Targa, _KmPercorsi, _CarburanteCurr);
    
    INSERT INTO possesso
    VALUES(_NomeUtente, _Targa);

END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS registra_fruibilita;

DELIMITER $$

CREATE PROCEDURE registra_fruibilita(IN _Targa VARCHAR(100),
									 IN _Giorno INT,
                                     IN _OraInizio TIME,
                                     IN _OraFine TIME)
BEGIN 
	DECLARE proponente VARCHAR(100);
    
    SET proponente = (SELECT P.NomeUtenteProponente
				      FROM Possesso P
                      WHERE P.Targa = _Targa
					 );
                     
	INSERT INTO fruibilita
    VALUES(proponente, _Targa, _Giorno, _OraInizio, _OraFine);

END $$
DELIMITER ;

-- ----------------------------------------------
--  Operazione 3 -- Creazione Istanza Car Sharing
-- ----------------------------------------------

DROP PROCEDURE IF EXISTS prenotazione_noleggio;

DELIMITER $$
CREATE PROCEDURE prenotazione_noleggio(IN _NomeUtenteFruitore VARCHAR(100),
									   IN _Targa VARCHAR(100),
                                       IN _DataInizioNoleggio DATE,
                                       IN _DataFineNoleggio DATE)
BEGIN 

	DECLARE risposta VARCHAR(100) DEFAULT NULL;
	DECLARE CarburanteCurr DOUBLE;
	DECLARE Proponente VARCHAR(100);
    
    SELECT DISTINCT F.NomeUtenteProponente INTO Proponente
    FROM Fruibilita F
    WHERE F.Targa = _Targa
		AND dayofweek(_DataInizioNoleggio) = F.Giorno
        AND current_time() < F.OrarioFine
        AND current_time() > F.OrarioInizio;
        
	IF Proponente = _NomeUtenteFruitore THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile prenotare un'auto già posseduta";
	END IF;
    
	IF Proponente IS NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile noleggiare l'autovettura in questo momento, riprovare più tardi";
	END IF;
    
    INSERT INTO prenotazione_noleggio
    VALUES(_DataInizioNoleggio, _NomeUtenteFruitore, _Targa, _DataFineNoleggio);
    
    INSERT INTO carburante_pre_noleggio
    VALUES(_Targa, CarburanteCurr);
    
    INSERT INTO risposta_proponente_noleggio
    VALUES(proponente, _DataInizioNoleggio, _NomeUtenteFruitore, _Targa, risposta);
    
END $$
DELIMITER ;

-- ---------------------------------
--  Operazione 4 - Registra_Sinistro
-- ---------------------------------

DROP PROCEDURE IF EXISTS Registra_Sinistro;

DELIMITER $$

CREATE PROCEDURE Registra_Sinistro(IN _NomeUtente VARCHAR(100),
								   IN _Targa VARCHAR(100),
                                   IN _TargaExt VARCHAR(100),
                                   IN _CasaAutomobilistica VARCHAR(100),
                                   IN _Modello VARCHAR(100),
                                   IN _Orario TIME,
                                   IN _Data DATE,
                                   IN _Dinamica VARCHAR(100),
                                   IN _Chilometro INT,
                                   IN _IdentificatoreStrada VARCHAR(100))
BEGIN 
	INSERT INTO Sinistro
    VALUES(_Targa, _Orario, _Data, _Dinamica, _Chilometro, _IdentificatoreStrada, _NomeUtente);
    
    INSERT INTO Veicolo_Esterno
    VALUES(_TargaExt, _Modello, _CasaAutomobilistica);
    
    INSERT INTO Coinvolgimento_Esterno
    VALUES(_Targa, _TargaExt, _Data, _Orario);
END $$

DELIMITER ;

-- ---------------------------------
--  Operazione 5 - Creazione Istanza Car Pooling
-- ---------------------------------

DROP PROCEDURE IF EXISTS Car_Pooling_Proponente;

DELIMITER $$
CREATE PROCEDURE Car_Pooling_Proponente(IN _NomeUtenteProponente VARCHAR(100),
							 IN _GiornoPartenza DATE,
                             IN _OrarioPartenza TIME,
                             IN _GiornoArrivo DATE, -- Può essere NULL
                             IN _Flessibilita VARCHAR(100),
                             IN _Validita TIMESTAMP,
                             IN _PercentualeAumentoKm DOUBLE,
                             IN _Targa VARCHAR(100),
                             IN _IdentificativoTragitto VARCHAR(100))
BEGIN 
	DECLARE statopool VARCHAR(100) DEFAULT "aperto";
    
    IF (date(_Validita + INTERVAL 48 HOUR) = _GiornoPartenza AND
		time(_Validita + INTERVAL 48 HOUR) > _OrarioPartenza) OR
        date(_Validita + INTERVAL 48 HOUR) > _GiornoPartenza
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il periodo di validità deve avere un anticipo di minimo 48h dalla partenza.";
	END IF;
    
	INSERT INTO Pool
    VALUES(_NomeUtenteProponente, _GiornoPartenza, _OrarioPartenza, _GiornoArrivo, _Flessibilita, _Validita, _PercentualeAumentoKm, statopool, _Targa, 0);
    
	
    
    INSERT INTO Riferimento_Tragitto_Pool 
    VALUES(_NomeUtenteProponente, _GiornoPartenza, _OrarioPartenza, _IdentificativoTragitto);
END $$
DELIMITER ;	

DROP PROCEDURE IF EXISTS Car_Pooling_Fruitore;

DELIMITER $$
CREATE PROCEDURE Car_Pooling_Fruitore(IN _NomeUtenteProponente VARCHAR(100),
									  IN _GiornoPartenza DATE,
                                      IN _OrarioPartenza DATE,
                                      IN _CodicePrenotazione VARCHAR(100),
                                      IN _NomeUtenteFruitore VARCHAR(100),
                                      IN _CodiceVariazione VARCHAR(100),
                                      IN _KmUscita INT,
                                      IN _KmEntrata INT,
                                      IN _IdentificativoTragittoModificato VARCHAR(100))
BEGIN 
	DECLARE rispostapool TINYINT DEFAULT NULL;
    DECLARE kmpiu INT DEFAULT 0;
    
    DECLARE km_ultimo INT DEFAULT 0;
    
    SET kmpiu = (SELECT max(KilometroTragitto)
			     FROM Tragitto
                 WHERE _IdentificativoTragittoModificato = IdentificativoTragitto
                 );
                 
	SET km_ultimo = (SELECT ChilometroFinale - ChilometroIniziale
					 FROM Tragitto
                     WHERE _IdentificativoTragittoModificato = IdentificativoTragitto
						AND KilometroTragitto = kmpiu);
                        
    INSERT INTO prenotazione_pool
    VALUES(_CodicePrenotazione, NULL, _NomeUtenteFruitore, _CodiceVariazione);
    
    INSERT INTO riferimento_pool
    VALUES(_CodicePrenotazione, _NomeUtenteProponente, _GiornoPartenza, _OrarioPartenza, rispostapool);
    
    INSERT INTO variazione
    VALUES(_CodiceVariazione, _KmUscita, _KmEntrata, kmpiu + km_ultimo);
    
    INSERT INTO tragitto_variato
    VALUES(_IdentificativoTragittoModificato, _CodiceVariazione);
END $$
DELIMITER ;

-- ------------------------------------------
--  Operazione 7 -- Registrazione Valutazione
-- ------------------------------------------

DROP PROCEDURE IF EXISTS recensione_fruitore;

DELIMITER $$

CREATE PROCEDURE recensione_fruitore(IN _Servizio VARCHAR(100),
									 IN _CodiceValutazione VARCHAR(100),
                                     IN _IdentificativoTragitto VARCHAR(100),
                                     IN _NumStelle INT,
                                     IN _NomeUtenteFruitore VARCHAR(100),
                                     IN _NomeUtenteProponente VARCHAR(100),
                                     IN _Recensione TEXT
                                     )
BEGIN 
	DECLARE ruolorecensore CHAR(10) DEFAULT 'fruitore';
    
	INSERT INTO Valutazione
    VALUES (_CodiceValutazione, _NumStelle, _Servizio, _Recensione, ruolorecensore, _NomeUtenteFruitore, _NomeUtenteProponente);
    
    INSERT INTO luogo_servizio
    VALUES(_CodiceValutazione, _IdentificativoTragitto);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS recensione_proponente;

DELIMITER $$

CREATE PROCEDURE recensione_proponente(IN _Servizio VARCHAR(100),
									 IN _CodiceValutazione VARCHAR(100),
                                     IN _IdentificativoTragitto VARCHAR(100),
                                     IN _NumStelle INT,
                                     IN _NomeUtenteFruitore VARCHAR(100),
                                     IN _NomeUtenteProponente VARCHAR(100),
                                     IN _Recensione TEXT
                                     )
BEGIN 
	DECLARE ruolorecensore CHAR(10) DEFAULT 'proponente';
    
	INSERT INTO Valutazione
    VALUES (_CodiceValutazione, _NumStelle, _Servizio, _Recensione, ruolorecensore, _NomeUtenteFruitore, _NomeUtenteProponente);
    
    INSERT INTO luogo_servizio
    VALUES(_CodiceValutazione, _IdentificativoTragitto);
END $$
DELIMITER ;

-- ------------------------------------------------
--  Operazione 8 -- Aggiornamento Stato Autovettura

-- Si può ipotizzare che tale eventi inizia quandro viene registrato il primo Timestamp 
-- Nell'entità Tracking e finisce alla fine del tragitto
-- ------------------------------------------------

DROP EVENT IF EXISTS aggiorna_stato_autovettura;

DELIMITER $$

CREATE EVENT aggiorna_stato_autovettura
ON SCHEDULE EVERY 10 MINUTE
DO 
BEGIN 
	/*
	CALL aggiorna_stato_autovettura();
	*/
    
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS aggiorna_stato_autovettura2;

DELIMITER $$

CREATE PROCEDURE aggiorna_stato_autovettura2(IN _Targa VARCHAR(100))
BEGIN
	DECLARE km_percorsi INT DEFAULT 0;
    
    DECLARE km_extraurbana INT DEFAULT 0;
    DECLARE km_autostrada INT DEFAULT 0;
    DECLARE km_urbana INT DEFAULT 0;
    DECLARE nuovi_km INT;
    
    DECLARE consumo_extraurbano DOUBLE;
    DECLARE consumo_autostrada DOUBLE;
    DECLARE consumo_urbano DOUBLE;
    
    DECLARE consumo_litri DOUBLE;
    
    
	SET km_extraurbana = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tracking T
							  NATURAL JOIN
                               Strada S 
                          WHERE _Targa = T.Targa
							AND T.Istante + INTERVAL 10 MINUTE > CURRENT_TIMESTAMP()
							AND (
                                 S.ClassificazioneTecnica = 'Extraurbana Principale'
								 OR S.ClassificazioneTecnica = 'Extraurbana Secondaria'
							    )
                         );
                         
   SET km_urbana = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tracking T
							  NATURAL JOIN
                               Strada S 
                          WHERE _identificativoTragitto = T.IdentificativoTragitto
							AND S.ClassificazioneTecnica = 'Urbana'
                         );
                         
   SET km_autostrada = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tracking T
							  NATURAL JOIN
                               Strada S 
                          WHERE _identificativoTragitto = T.IdentificativoTragitto
							AND S.ClassificazioneTecnica = 'Autostrada'
                         );
                     
  SET nuovi_km = km_urbana + km_autostrada + km_extraurbana;
  SET consumo_litri = (km_autostrada/100)*consumo_autostrada + (km_extraurbano/100)*consumo_extraurbano + (km_urbano/100)*consumo_urbano;
  
  SELECT C.ConsumoMedioUrbano, C.ConsumoMedioMisto, C.ConsumoMedioExtraurbano INTO consumo_urbano, consumo_autostrada, consumo_extraurbano
  FROM Consumo C
  WHERE _Targa = C.Targa;

	
  UPDATE Stato_Veicolo 
  SET Targa = Targa, KmPercorsi = (KmPercorsi + nuovi_km), Carburante = Carburante - consumo_litri
  WHERE _Targa = Targa;
END $$
DELIMITER ;

-- Aggiornamento on demand, quando l'autovettura effettua un rifornimento di carburante

DROP PROCEDURE IF EXISTS aggiorna_stato_autovettura_pieno;

DELIMITER $$

CREATE PROCEDURE aggiorna_stato_autovettura_pieno(IN _Targa VARCHAR(100))
BEGIN 
	DECLARE pieno DOUBLE;
    
    SET pieno = (SELECT CapacitaSerbatoio
				 FROM Consumo
                 WHERE _Targa = Targa);
                 
	UPDATE Stato_Veicolo 
	SET Targa = Targa, KmPercorsi = KmPercorsi, Carburante = pieno
	WHERE _Targa = Targa;
END $$
DELIMITER ;

-- ---------------------------------
--  Operazione 9
-- ---------------------------------

DROP PROCEDURE IF EXISTS open_ride_sharing;

DELIMITER $$
CREATE PROCEDURE open_ride_sharing(IN _OrarioPartenza VARCHAR(100),
                                   IN _NomeUtenteProponente VARCHAR(100),
                                   IN _IdentificativoTragitto VARCHAR(100),
                                   IN _Targa VARCHAR(100))
BEGIN 
	INSERT INTO Sharing
    VALUES(_OrarioPartenza, _NomeUtenteProponente, _IdentificativoTragitto, _Targa);
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS open_chiamata;

DELIMITER $$
CREATE PROCEDURE open_chiamata(IN _CodiceChiamata VARCHAR(100),
							   IN _NomeUtenteFruitore VARCHAR(100),
							   IN _km_destinazione INT,
                               IN _km_attuale INT,
                               IN _strada_attuale VARCHAR(100),
                               IN _strada_destinazione VARCHAR(100))
BEGIN
	INSERT INTO Chiamata
    VALUES(_CodiceChiamata, CURRENT_TIMESTAMP(), NULL, NULL, 'pending', _NomeUtenteFruitore);
    
    INSERT INTO Destinazione
    VALUES(_km_destinazione, _strada_destinazione, _CodiceChiamata);
    
    INSERT INTO Posizione_attuale
    VALUES(_km_attuale, _strada_attuale, _CodiceChiamata);
END $$
DELIMITER ;

-- --------------------
-- Operazione 10
-- --------------------


DROP PROCEDURE IF EXISTS aggiorna_tempi_percorrenza;

DELIMITER $$

CREATE PROCEDURE aggiorna_tempi_percorrenza(IN _IdentificatoreTragitto VARCHAR(100))
BEGIN 
	DECLARE curr_strada VARCHAR(100);
    DECLARE finito INT DEFAULT 0;
    
    DECLARE _lunghezza INT DEFAULT 0;

	DECLARE _chilometro INT DEFAULT 0;
    
	DECLARE km_max INT DEFAULT 0;
    DECLARE timestamp_max TIMESTAMP;
    
    DECLARE km_min INT DEFAULT 0;
    DECLARE timestamp_min TIMESTAMP;
    
    DECLARE somma_minuti_medi DOUBLE DEFAULT 0;
    
    DECLARE scorri CURSOR FOR
    SELECT T.IdentificatoreStradaIniziale, T.KilometroTragitto
    FROM Tragitto T
    WHERE T.IdentificativoTragitto = _IdentificatoreTragitto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET finito = 1;
    
    OPEN scorri;
    
    scan : LOOP
		FETCH scorri INTO curr_strada, _chilometro;
        
        IF finito = 1 THEN
			LEAVE scan;
		END IF;
        
        SET _lunghezza = (SELECT S.Lunghezza
						 FROM Strada S
                         WHERE S.IdentificatoreStrada = curr_strada);
                         
		SELECT max(TR.Chilometro) INTO km_max
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro;
		
        SELECT max(TR.Istante) INTO timestamp_max
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND TR.Chilometro = km_max;
            
		SELECT min(TR.Chilometro) INTO km_min
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro;
		
        SELECT min(TR.Istante) INTO timestamp_min
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND TR.Chilometro = km_min;
        
		IF  abs(km_min - km_max) IS NOT NULL AND abs(km_min - km_max) <> 0 THEN 
			SET somma_minuti_medi = (abs(timestampdiff(MINUTE, timestamp_min, timestamp_max))* _lunghezza) / abs(km_min - km_max);
        ELSE
			SET somma_minuti_medi = 0;
		END IF;
        
        
        UPDATE MV_Tempi_Percorrenza
        SET MinutiMediPercorrenza = MinutiMediPercorrenza + somma_minuti_medi, NumeroAttuazioni = NumeroAttuazioni + 1
        WHERE curr_strada = IdentificatoreStrada;
    END LOOP;
    
    
    CLOSE scorri;
    
    

	

END $$
DELIMITER ;



-- --------------------
-- Operazione 10 Aggiornamento tempi traffico
-- --------------------

DROP PROCEDURE IF EXISTS aggiorna_tempi_traffico;

DELIMITER $$

CREATE PROCEDURE aggiorna_tempi_traffico(IN _IdentificatoreTragitto VARCHAR(100))
BEGIN 
	DECLARE curr_strada VARCHAR(100);
    DECLARE finito INT DEFAULT 0;
    
    DECLARE _lunghezza INT DEFAULT 0;

	DECLARE _chilometro INT DEFAULT 0;
    
	DECLARE km_max INT DEFAULT 0;
    DECLARE timestamp_max TIMESTAMP;
    
    DECLARE km_min INT DEFAULT 0;
    DECLARE timestamp_min TIMESTAMP;
    
    DECLARE somma_minuti_medi DOUBLE DEFAULT 0;
    
    DECLARE scorri CURSOR FOR
    SELECT T.IdentificatoreStradaIniziale, T.KilometroTragitto
    FROM Tragitto T
    WHERE T.IdentificativoTragitto = _IdentificatoreTragitto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET finito = 1;
    
    OPEN scorri;
    
    scan : LOOP
		FETCH scorri INTO curr_strada, _chilometro;
        
        IF finito = 1 THEN
			LEAVE scan;
		END IF;
        
        SET _lunghezza = (SELECT S.Lunghezza
						 FROM Strada S
                         WHERE S.IdentificatoreStrada = curr_strada);
                         
		SELECT max(TR.Chilometro) INTO km_max
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND Istante >= current_timestamp() + INTERVAL 10 MINUTE;
		
        SELECT max(TR.Istante) INTO timestamp_max
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND TR.Chilometro = km_max
            AND Istante >= current_timestamp() + INTERVAL 10 MINUTE;
            
		SELECT min(TR.Chilometro) INTO km_min
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND Istante >= current_timestamp() + INTERVAL 10 MINUTE;
		
        SELECT min(TR.Istante) INTO timestamp_min
        FROM Tracking TR
        WHERE TR.IdentificativoTragitto = _IdentificatoreTragitto 
			AND TR.ChilometroTragitto = _chilometro
            AND TR.Chilometro = km_min
            AND Istante >= current_timestamp() + INTERVAL 10 MINUTE;
        
        
        IF  abs(km_min - km_max) IS NOT NULL AND abs(km_min - km_max) <> 0 THEN 
			SET somma_minuti_medi = (abs(timestampdiff(MINUTE, timestamp_min, timestamp_max))* _lunghezza) / abs(km_min - km_max);
        ELSE
			SET somma_minuti_medi = 0;
		END IF;
        
        
        UPDATE MV_Tempi_Percorrenza
        SET MinutiMediPercorrenza = MinutiMediPercorrenza + somma_minuti_medi, NumeroAttuazioni = NumeroAttuazioni + 1
        WHERE curr_strada = IdentificatoreStrada;
    END LOOP;
    
    
    CLOSE scorri;
    
    

	

END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS chiama_tragitti_medi;

DELIMITER $$
CREATE PROCEDURE chiama_tragitti_medi()
BEGIN 
	
  
    
	DECLARE finito INT DEFAULT 0;
    DECLARE curr_trag VARCHAR(100);
    
    DECLARE scorri CURSOR FOR
    SELECT DISTINCT IdentificativoTragitto 
    FROM Tragitto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET finito = 1;
    
    
	TRUNCATE TABLE MV_Tempi_Percorrenza;
    
	INSERT INTO MV_Tempi_Percorrenza
	SELECT S.IdentificatoreStrada, 0, 0
	FROM Strada S;
      
    OPEN scorri;
    
    scan : LOOP
		FETCH scorri INTO curr_trag;
        
        IF finito = 1 THEN 
			LEAVE scan;
		END IF;
        
        CALL aggiorna_tempi_percorrenza(curr_trag);
    END LOOP;
    CLOSE scorri;
    
    
        UPDATE MV_Tempi_Percorrenza
    SET MinutiMediPercorrenza = MinutiMediPercorrenza / NumeroAttuazioni
    WHERE NumeroAttuazioni <> 0;
    
	UPDATE MV_Tempi_Percorrenza
    SET NumeroAttuazioni = 0;
END $$
DELIMITER ;




DROP PROCEDURE IF EXISTS chiama_tragitti_traffico;

DELIMITER $$
CREATE PROCEDURE chiama_tragitti_traffico()
BEGIN 
	
  
    
	DECLARE finito INT DEFAULT 0;
    DECLARE curr_trag VARCHAR(100);
    
    DECLARE scorri CURSOR FOR
    SELECT DISTINCT IdentificativoTragitto 
    FROM Tragitto;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    SET finito = 1;
    
    
	TRUNCATE TABLE MV_Tempi_Traffico;
    
	INSERT INTO MV_Tempi_Traffico
	SELECT S.IdentificatoreStrada, 0, 0
	FROM Strada S;
      
    OPEN scorri;
    
    scan : LOOP
		FETCH scorri INTO curr_trag;
        
        IF finito = 1 THEN 
			LEAVE scan;
		END IF;
        
        CALL aggiorna_tempi_percorrenza(curr_trag);
    END LOOP;
    CLOSE scorri;
    
    
        UPDATE MV_Tempi_Percorrenza
    SET MinutiMediPercorrenza = MinutiMediPercorrenza / NumeroAttuazioni
    WHERE NumeroAttuazioni <> 0;
    
	UPDATE MV_Tempi_Percorrenza
    SET NumeroAttuazioni = 0;
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS aggiorna_affidabilita;

DELIMITER $$
CREATE PROCEDURE aggiorna_affidabilita(IN _NomeUtente VARCHAR(100))
BEGIN
	DECLARE conta_rec_fruitore INT DEFAULT 0;
	DECLARE conta_rec_proponente INT DEFAULT 0;
    
    DECLARE somma_stelle_fruitore DOUBLE DEFAULT 0;
    DECLARE somma_stelle_proponente DOUBLE DEFAULT 0;
    
    DECLARE incidenti DOUBLE DEFAULT 0;
    
    DECLARE _affidabilita DOUBLE DEFAULT 0;
    
    SELECT count(*) INTO conta_rec_proponente
    FROM Valutazione V
    WHERE V.NomeUtenteProponente = _NomeUtente
		AND V.RuoloRecensore = 'fruitore';
	
    SELECT count(*) INTO conta_rec_fruitore
    FROM Valutazione V
    WHERE V.NomeUtenteFruitore = _NomeUtente
		AND V.RuoloRecensore = 'proponente';
        
	SELECT sum(V.NumStelle) INTO somma_stelle_fruitore
    FROM Valutazione V
    WHERE V.NomeUtenteFruitore = _NomeUtente
		AND V.RuoloRecensore = 'proponente';
        
	SELECT sum(V.NumStelle) INTO somma_stelle_proponente
    FROM Valutazione V
    WHERE V.NomeUtenteProponente = _NomeUtente
		AND V.RuoloRecensore = 'fruitore';
    
    SELECT IF(count(*) = 0, 0.1, 0) INTO incidenti
    FROM Sinistro S
    WHERE NomeUtenteCoinvolto = _NomeUtente;
    
    IF conta_rec_fruitore <> 0 AND conta_rec_proponente <> 0 THEN
	
		SET _affidabilita = (((somma_stelle_fruitore)/conta_rec_fruitore + (somma_stelle_proponente)/conta_rec_proponente) / 2) * (1 + incidenti);
	
    ELSEIF conta_rec_fruitore <> 0 AND conta_rec_proponente = 0 THEN
	
		SET _affidabilita = ((somma_stelle_fruitore)/conta_rec_fruitore) * (1 + incidenti);
	
    ELSEIF conta_rec_fruitore = 0 AND conta_rec_proponente <> 0 THEN

		SET _affidabilita = ((somma_stelle_proponente)/conta_rec_proponente) * (1 + incidenti);
	
    ELSE
    
		SET _affidabilita = NULL;
	
    END IF;
    
    UPDATE MV_Affidabilita_Utente
    SET affidabilita = _affidabilita
    WHERE NomeUtente = _NomeUtente;

END $$
DELIMITER ;



DROP PROCEDURE IF EXISTS chiama_utenti;

DELIMITER $$
CREATE PROCEDURE chiama_utenti()
BEGIN
	DECLARE finito INT DEFAULT 0;
    
    DECLARE curr_nome VARCHAR(100);
    
	DECLARE scorri CURSOR FOR
    SELECT A.NomeUtente
    FROM Account A;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET finito = 1;
    
    
    TRUNCATE MV_Affidabilita_Utente;
    
    INSERT INTO MV_Affidabilita_Utente
	SELECT A.NomeUtente, 0
	FROM Account A;

    
    OPEN scorri;
    scan : LOOP
		FETCH scorri INTO curr_nome;
		
        IF finito = 1 THEN
			LEAVE scan;
		END IF;
        
		CALL aggiorna_affidabilita(curr_nome);
    END LOOP;
    CLOSE scorri;
END $$
DELIMITER ;