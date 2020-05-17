
DROP PROCEDURE IF EXISTS accetta_prenotazione;

DELIMITER $$

CREATE PROCEDURE accetta_prenotazione(IN _NomeUtenteProponente VARCHAR(100),
									  IN _GiornoPartenza DATE,
                                      IN _OrarioPartenza DATE,
                                      IN _CodicePrenotazione VARCHAR(100))
BEGIN 
	DECLARE _Variazione VARCHAR(100);
    DECLARE _flex VARCHAR(100);
    
    DECLARE _Tragitto VARCHAR(100);
	DECLARE _TragittoVariazione VARCHAR(100);
     
	DECLARE km_correnti_var INT DEFAULT 0;
    DECLARE km_var INT DEFAULT 0;
    
    DECLARE km_uscita INT;
    DECLARE km_entrata INT;
    
    SELECT CodiceVariazione INTO _Variazione
    FROM Prenotazione_pool
    WHERE CodicePrenotazione = _CodicePrenotazione;
	
    
    SELECT KilometriPiu, KilometroUscita, KilometroEntrata, IdentificativoTragitto INTO km_var, km_uscita, km_entrata, _TragittoVariazione
    FROM Variazione
		NATURAL JOIN
		 Tragitto_Variato
    WHERE _Variazione = CodiceVariazione;
    
    SELECT Flessibilita, ChilometriCorrentiVariazione INTO _flex, km_correnti_var
    FROM Pool
    WHERE _NomeUtenteProponente = NomeUtenteProponente
		AND _GiornoPartenza = GiornoPartenza
        AND _OrarioPartenza = OrarioPartenza;
        
	SELECT IdentificativoTragitto INTO _Tragitto
    FROM Riferimento_Tragitto_Pool
	WHERE _NomeUtenteProponente = NomeUtenteProponente
		AND _GiornoPartenza = GiornoPartenza
        AND _OrarioPartenza = OrarioPartenza;
    
    
    IF _flex = NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Raggiunto massimo chilometri variazione';
	ELSEIF _flex = 'bassa' THEN
		IF km_correnti_var + Km_var > 3 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Raggiunto massimo chilometri variazione';
        END IF;
    ELSEIF _flex = 'media' THEN
		IF km_correnti_var + Km_var > 5 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Raggiunto massimo chilometri variazione';
        END IF;
	ELSE
		IF km_correnti_var + Km_var > 7 THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Raggiunto massimo chilometri variazione';
        END IF;
    END IF;
    
    
    -- Arrivati a questo punto la variazione deve essere implementata
    UPDATE Tragitto
    SET Kilometro = Kilometro + Km_var
    WHERE IdentificativoTragitto = _Tragitto
		AND KilometroTragitto > km_uscita;
        
	INSERT INTO Tragitto
		SELECT _Tragitto, KilometroTragitto + Km_uscita, ChilometroIniziale, IdentificatoreStradaIniziale, ChilometroFinale, IdentificatoreStradaFinale
        FROM Tragitto
        WHERE IdentificativoTragitto = _TragittoVariazione;
        
	UPDATE Pool
    SET ChilometriCorrentiVariazione = ChilometriCorrentiVariazione + km_var
    WHERE _NomeUtenteProponente = NomeUtenteProponente
		AND _GiornoPartenza = GiornoPartenza
        AND _OrarioPartenza = OrarioPartenza;
    
END ;

DELIMITER ;

-- ---------------------------------
--  Operazione 6 - Calcolo Spesa Car Pooling

-- Tale operazione dovrà essere effettuata quando non è più possibile
-- modificare il tragitto d'interesse, ovvero quando il pool passa in status chiuso
-- ---------------------------------

DROP PROCEDURE IF EXISTS calcolo_spesa;

DELIMITER $$

CREATE PROCEDURE calcolo_spesa(IN _CodicePrenotazione VARCHAR(100),
							   OUT _Spesatotale DOUBLE(100))
BEGIN 
	DECLARE _identificativoTragitto VARCHAR(100);
    DECLARE _Targa VARCHAR(100);
	
    DECLARE km_extraurbana INT DEFAULT 0;
    DECLARE km_autostrada INT DEFAULT 0;
    DECLARE km_urbana INT DEFAULT 0;
    
    DECLARE consumo_extraurbano DOUBLE;
    DECLARE consumo_autostrada DOUBLE;
    DECLARE consumo_urbano DOUBLE;

    DECLARE _CostoOperativo DOUBLE;
    DECLARE CostoCarburante DOUBLE;
    DECLARE _CostoUsura DOUBLE;
    
    DECLARE spesa_pedaggio DOUBLE;
    
    DECLARE presenza INT DEFAULT 0;
    DECLARE num_utenti INT DEFAULT 0;
    DECLARE AumentoVariazione DOUBLE;
   
   
    SET presenza = (SELECT IF(P.CodiceValurazione IS NULL, 1, 0)
					FROM prenotazione_pool P
                    WHERE P.CodicePrenotazione = _CodicePrenotazione);
    
    SELECT P.Targa, P.PercentualeAumentoKm INTO _Targa, AumentoVariazione
    FROM Pool P
		 NATURAL JOIN
         Riferimento_pool RP
    WHERE RP.CodicePrenotazione = _CodicePrenotazione;
    
    
      
    SELECT count(*) INTO num_utenti
    FROM Riferimento_pool RP
		NATURAL JOIN 
         Pool P
    WHERE P.Targa = _Targa;
    
    SET _identificativoTragitto = (SELECT RTP.IdentificativoTragitto
								  FROM Riferimento_pool RP 
									   NATURAL JOIN 
                                       Riferimento_tragitto_Pool RTP
								  WHERE _CodicePrenotazione = RP.CodicePrenotazione
                                  );
    SET km_extraurbana = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tragitto T
							  NATURAL JOIN
                               Strada S 
                          WHERE _identificativoTragitto = T.IdentificativoTragitto
							AND (
                                 S.ClassificazioneTecnica = 'Extraurbana Principale'
								 OR S.ClassificazioneTecnica = 'Extraurbana Secondaria'
							    )
                         );
                         
   SET km_urbana = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tragitto T
							  NATURAL JOIN
                               Strada S 
                          WHERE _identificativoTragitto = T.IdentificativoTragitto
							AND S.ClassificazioneTecnica = 'Urbana'
                         );
                         
   SET km_autostrada = (SELECT sum(T.ChilometroFinale - T.ChilometroIniziale)
						  FROM Tragitto T
							  NATURAL JOIN
                               Strada S 
                          WHERE _identificativoTragitto = T.IdentificativoTragitto
							AND S.ClassificazioneTecnica = 'Autostrada'
                         );
                         
  SET CostoCarburante = 1.5;
  
  SET spesa_pedaggio = (SELECT sum(TT.pedaggio)
						FROM Tragitto T
							NATURAL JOIN
                             Strada S
							NATURAL JOIN 
							 Tratto TT
						WHERE T.IdentificativoTragitto = _IdentificativoTragitto
							AND S.ClassificazioneTecnica = 'Autostrada');
                            
  SELECT C.ConsumoMedioUrbano, C.ConsumoMedioMisto, C.ConsumoMedioExtraurbano INTO consumo_urbano, consumo_autostrada, consumo_extraurbano
  FROM Consumo C
  WHERE _Targa = C.Targa;
  
  SELECT A.CostoDiUsusra, A.CostoOperativo INTO _CostoUsura, _CostoOperativo
  FROM Autovettura A
  WHERE _Targa = C.Targa;
  
  SET _SpesaTotale = (_CostoOperativo + _CostoUsura*num_utenti + CostoCarburante*((km_autostrada/100)*consumo_autostrada + (km_extraurbano/100)*consumo_extraurbano
  + (km_urbano/100)*consumo_urbano) + (spesa_pedaggio/num_utenti)) * (100 + (AumentoVariazione * Presenza))/100
    
END ;
DELIMITER ; 
