-- ----------------------------
--  Triggers for Account
-- ----------------------------

DROP TRIGGER IF EXISTS Account_Trigger_I;

DELIMITER $$
CREATE TRIGGER Account_Trigger_I
BEFORE INSERT ON Account
FOR EACH ROW
BEGIN
	IF NEW.StatoUtente <> "inattivo" AND NEW.StatoUtente <> "attivo" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Stato Utente non permesso";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Account_Trigger_U;

DELIMITER $$
CREATE TRIGGER Account_Trigger_U
BEFORE UPDATE ON Account
FOR EACH ROW
BEGIN
	IF NEW.StatoUtente <> "inattivo" OR NEW.StatoUtente <> "attivo" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Stato Utente non permesso";
	END IF;
END $$
DELIMITER ;

-- ----------------------------
--  Triggers for Autovettura
-- ----------------------------

DROP TRIGGER IF EXISTS Autovettura_Trigger_I;

DELIMITER $$
CREATE TRIGGER Autovettura_Trigger_I
BEFORE INSERT ON Autovettura
FOR EACH ROW
BEGIN
/*
	IF NEW.Comfort < 1 OR NEW.Comfort > 5 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Comfort non permesso";
	END IF;
*/    
    IF NEW.Disponibilita <> "noleggiata" AND NEW.Disponibilita <> "disponibile" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Disponibilità non permesso";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Autovettura_Trigger_U;

DELIMITER $$
CREATE TRIGGER Autovettura_Trigger_U
BEFORE UPDATE ON autovettura
FOR EACH ROW
BEGIN
/*
	IF NEW.Comfort < 1 OR NEW.Comfort > 5 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Comfort non permesso";
	END IF;
*/    
    IF NEW.Disponibilita <> "noleggiata" AND NEW.Disponibilita <> "disponibile" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Disponibilità non permesso";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Composizione_Strada
-- ---------------------------------

DROP TRIGGER IF EXISTS Composizione_Strada_Trigger_U;

DELIMITER $$
CREATE TRIGGER Composizione_Strada_Trigger_U
BEFORE UPDATE ON Composizione_Strada
FOR EACH ROW
BEGIN
	IF NEW.SensoUnico <> NULL OR NEW.SensoUnico <> "crescente" OR NEW.SensoUnico <> "decrescente" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Senso Unico non permesso";
	END IF;
    
    IF NEW.SensiDiMarcia > 2 OR NEW.SensiDiMarcia < 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sensi di Marcia non permesso";
    END IF;
    
    IF NEW.SensiDiMarcia > NEW.NumeroCorsie THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sensi di Marcia è superiore al numero di corsie";
	END IF;
    
    IF NEW.SensoUnico IS NULL AND NEW.SensiDiMarcia <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di SensoUnico è invalido in quanto vi sono più sensi di marcia";
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Composizione_Strada_Trigger_I;

DELIMITER $$
CREATE TRIGGER Composizione_Strada_Trigger_I
BEFORE INSERT ON Composizione_Strada
FOR EACH ROW
BEGIN
	IF NEW.SensoUnico IS NULL AND NEW.SensoUnico <> "crescente" AND NEW.SensoUnico <> "decrescente" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Senso Unico non permesso";
	END IF;
    
    IF NEW.SensiDiMarcia > 2 OR NEW.SensiDiMarcia < 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sensi di Marcia non permesso";
    END IF;
    
    IF NEW.SensiDiMarcia > NEW.NumeroCorsie THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sensi di Marcia è superiore al numero di corsie";
	END IF;
    
    IF NEW.SensoUnico IS NULL AND NEW.SensiDiMarcia = 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di SensoUnico è invalido in quanto vi sono più sensi di marcia";
    END IF;
    
    IF NEW.SensoUnico IS NOT NULL AND NEW.SensiDiMarcia <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di SensoUnico è invalido in quanto vi sono più sensi di marcia";
    END IF;
END $$
DELIMITER ;


-- ---------------------------------
--  Triggers for Congiunzione
-- ---------------------------------

DROP TRIGGER IF EXISTS Congiunzione_Trigger_I;

DELIMITER $$
CREATE TRIGGER Congiunzione_Trigger_I
BEFORE INSERT ON Congiunzione
FOR EACH ROW
BEGIN
	IF NEW.IdentificativoPrimaStradaX = NEW.IdentificativoSecondaStradaX AND NEW.ChilometroPrimaStradaX <> NEW.ChilometroSecondaStradaX THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile inserire congiunzione che coinvolge una strada con sè stessa in un chilometro non identico";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Congiunzione_Trigger_U;

DELIMITER $$
CREATE TRIGGER Congiunzione_Trigger_U
BEFORE UPDATE ON Congiunzione
FOR EACH ROW
BEGIN
	IF NEW.IdentificativoPrimaStradaX = NEW.IdentificativoSecondaStradaX AND NEW.ChilometroPrimaStradaX <> NEW.ChilometroSecondaStradaX THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile inserire congiunzione che coinvolge una strada con sè stessa in un chilometro non identico";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Fruibilità
-- ---------------------------------
DROP TRIGGER IF EXISTS Fruibilita_Trigger_I;

DELIMITER $$
CREATE TRIGGER Fruibilita_Trigger_I
BEFORE INSERT ON Fruibilita
FOR EACH ROW
BEGIN
	IF NEW.Giorno > 6 OR NEW.Giorno < 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Giorno non è valido";
	END IF;
    
    IF NEW.OrarioInizio >= NEW.OrarioFine OR NEW.OrarioInizio > "23:59:59" OR NEW.OrarioFine > "23:59:59" OR NEW.OrarioInizio < "00:00:00" OR 
	   NEW.OrarioFine < "00:00:01" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di OrarioFine o OrarioInizio non valido";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Fruibilita_Trigger_U;

DELIMITER $$
CREATE TRIGGER Fruibilita_Trigger_U
BEFORE UPDATE ON Fruibilita
FOR EACH ROW
BEGIN
	IF NEW.Giorno > 6 OR NEW.Giorno < 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Giorno non è valido";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Optional
-- ---------------------------------

DROP TRIGGER IF EXISTS Optional_Trigger_I;

DELIMITER $$
CREATE TRIGGER Optional_Trigger_I
BEFORE INSERT ON Optional
FOR EACH ROW
BEGIN
	IF NEW.TavoliPosteriori <> 0 AND NEW.TavoliPosteriori <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tavoli Posteriori non permesso";
	END IF;
    
    IF NEW.TettoInVetro <> 0 AND NEW.TettoInVetro <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tetto in Vetro non permesso";
    END IF;
    
    IF NEW.DimensioniBagagliaio < 0 OR NEW.RumoreBordo < 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Dimensioni Bagagliaio o Rumore Bordo non è permesso";
	END IF;
    
    IF NEW.Connettivita <> 0 AND NEW.Connettivita <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Connettivita non permesso";
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Optional_Trigger_U;

DELIMITER $$
CREATE TRIGGER Optional_Trigger_U
BEFORE UPDATE ON Optional
FOR EACH ROW
BEGIN
	IF NEW.TavoliPosteriori <> 0 AND NEW.TavoliPosteriori <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tavoli Posteriori non permesso";
	END IF;
    
    IF NEW.TettoInVetro <> 0 AND NEW.TettoInVetro <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tetto in Vetro non permesso";
    END IF;
    
    IF NEW.DimensioniBagagliaio < 0 OR NEW.RumoreBordo < 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Dimensioni Bagagliaio o Rumore Bordo non è permesso";
	END IF;
    
    IF NEW.Connettivita <> 0 AND NEW.Connettivita <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Connettivita non permesso";
    END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Pool
-- ---------------------------------

DROP TRIGGER IF EXISTS Pool_Trigger_I;

DELIMITER $$
CREATE TRIGGER Pool_Trigger_I
BEFORE INSERT ON Pool
FOR EACH ROW
BEGIN
    
    IF NEW.Flessibilita IS NOT NULL AND NEW.Flessibilita <> "bassa" AND NEW.Flessibilita <> "media" AND NEW.Flessibilita <> "alta" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Flessibilità non permesso";
    END IF;
    
    IF NEW.StatoPool <> "aperto" AND NEW.StatoPool <> "chiuso" AND NEW.StatoPool <> "partito" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Stato Pool non è permesso";
	END IF;
    
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Pool_Trigger_U;

DELIMITER $$
CREATE TRIGGER Pool_Trigger_U
BEFORE UPDATE ON Pool
FOR EACH ROW
BEGIN
	IF NEW.GiornoDiArrivo IS NOT NULL AND NEW.GiornoDiArrivo < GiornoPartenza THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Giorno Di Arrivo non permesso";
	END IF;
    
    IF NEW.Flessibilita IS NOT NULL AND NEW.Flessibilita <> "bassa" AND NEW.Flessibilita <> "media" AND NEW.Flessibilita <> "alta" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Flessibilità non permesso";
    END IF;
    
    IF NEW.StatoPool <> "aperto" AND NEW.StatoPool <> "chiuso" AND NEW.StatoPool <> "partito" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Stato Pool non è permesso";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Prenotazione Di Noleggio
-- ---------------------------------
DROP TRIGGER IF EXISTS Prenotazione_Noleggio_Trigger_I;

DELIMITER $$
CREATE TRIGGER Prenotazione_Noleggio_Trigger_I
BEFORE INSERT ON Prenotazione_Noleggio
FOR EACH ROW
BEGIN
	IF NEW.DataFineNoleggio < NEW.DataInizioNoleggio THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di DataFineNoleggio non è valido";
	END IF;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS Prenotazione_Noleggio_Trigger_U;

DELIMITER $$
CREATE TRIGGER Prenotazione_Noleggio_Trigger_U
BEFORE UPDATE ON Prenotazione_Noleggio
FOR EACH ROW
BEGIN
	IF NEW.DataFineNoleggio < NEW.DataInizioNoleggio THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di DataFineNoleggio non è valido";
	END IF;
END $$
DELIMITER ;
-- ---------------------------------
--  Triggers for Riferimento Pool
-- ---------------------------------

DROP TRIGGER IF EXISTS Riferimento_Pool_Trigger_I;

DELIMITER $$
CREATE TRIGGER Riferimento_Pool_Trigger_I
BEFORE INSERT ON Riferimento_Pool
FOR EACH ROW
BEGIN
	IF NEW.RispostaPool IS NOT NULL AND NEW.RispostaPool <> 0 AND NEW.RispostaPool <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Risposta Pool non è valido";
	END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Riferimento_Pool_Trigger_U;

DELIMITER $$
CREATE TRIGGER Riferimento_Pool_Trigger_U
BEFORE UPDATE ON Riferimento_Pool
FOR EACH ROW
BEGIN
	IF NEW.RispostaPool IS NOT NULL AND NEW.RispostaPool <> 0 AND NEW.RispostaPool <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Risposta Pool non è valido";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Risposta Proponente Noleggio
-- ---------------------------------

DROP TRIGGER IF EXISTS Risposta_Proponente_Noleggio_Trigger_I;

DELIMITER $$
CREATE TRIGGER Risposta_Proponente_Noleggio_Trigger_I
BEFORE INSERT ON Risposta_Proponente_Noleggio
FOR EACH ROW
BEGIN
	IF NEW.RispostaNoleggio IS NOT NULL AND NEW.RispostaNoleggio <> 0 AND NEW.RispostaNoleggio <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Risposta Noleggio non è valido";
	END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Risposta_Proponente_Noleggio_Trigger_U;

DELIMITER $$
CREATE TRIGGER Risposta_Proponente_Noleggio_Trigger_U
BEFORE UPDATE ON Risposta_Proponente_Noleggio
FOR EACH ROW
BEGIN
	IF NEW.RispostaNoleggio IS NOT NULL AND NEW.RispostaNoleggio <> 0 AND NEW.RispostaNoleggio <> 1 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Risposta Noleggio non è valido";
	END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Strada
-- ---------------------------------

DROP TRIGGER IF EXISTS Strada_Trigger_I;

DELIMITER $$
CREATE TRIGGER Strada_Trigger_I
BEFORE INSERT ON Strada
FOR EACH ROW
BEGIN
	IF NEW.Tipologia <> "SS" AND NEW.Tipologia <> "SR" AND NEW.Tipologia <> "SP" AND NEW.Tipologia <> "SC" AND NEW.Tipologia <> "SV" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tipologia non permesso";
	END IF;
    
    IF NEW.Categorizzazione IS NOT NULL AND NEW.Categorizzazione <> "dir" AND NEW.Categorizzazione <> "racc" AND NEW.Categorizzazione <> "radd" AND 
    NEW.Categorizzazione <> "bis" AND NEW.Categorizzazione <> "ter" AND NEW.Categorizzazione <> "quater" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Categorizzazione non permesso";
    END IF;
    
    IF NEW.Categorizzazione = "SC" AND NEW.Nome IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Nome non è permesso (Strada Comunale non deve avere nome)";
	END IF;
    
    IF NEW.ClassificazioneTecnica <> "Autostrada" AND NEW.ClassificazioneTecnica <> "Extraurbana Principale" AND 
    NEW.ClassificazioneTecnica <> "Extraurbana Secondaria" AND NEW.ClassificazioneTecnica <> "Urbana" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Classificazione Tecnica non è permesso";
    END IF;
    
    IF NEW.ClassificazioneTecnica <> "Autostrada" AND NEW.Sigla IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sigla non è permesso";
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Strada_Trigger_U;

DELIMITER $$
CREATE TRIGGER Strada_Trigger_U
BEFORE UPDATE ON Strada
FOR EACH ROW
BEGIN
	IF NEW.Tipologia <> "SS" AND NEW.Tipologia <> "SR" AND NEW.Tipologia <> "SP" AND NEW.Tipologia <> "SC" AND NEW.Tipologia <> "SV" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Tipologia non permesso";
	END IF;
    
    IF NEW.Categorizzazione IS NOT NULL AND NEW.Categorizzazione <> "dir" AND NEW.Categorizzazione <> "racc" AND NEW.Categorizzazione <> "radd" AND 
    NEW.Categorizzazione <> "bis" AND NEW.Categorizzazione <> "ter" AND NEW.Categorizzazione <> "quater" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Categorizzazione non permesso";
    END IF;
    
    IF NEW.Categorizzazione = "SC" AND NEW.Nome IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Nome non è permesso (Strada Comunale non deve avere nome)";
	END IF;
    
    IF NEW.ClassificazioneTecnica <> "Autostrada" AND NEW.ClassificazioneTecnica <> "Extraurbana Principale" AND 
    NEW.ClassificazioneTecnica <> "Extraurbana Secondaria" AND NEW.ClassificazioneTecnica <> "Urbana" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Classificazione Tecnica non è permesso";
    END IF;
    
    IF NEW.ClassificazioneTecnica <> "Autostrada" AND NEW.Sigla IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Sigla non è permesso";
    END IF;
END $$
DELIMITER ;

-- ---------------------------------
--  Triggers for Valutazione
-- ---------------------------------

DROP TRIGGER IF EXISTS Valutazione_Trigger_I;

DELIMITER $$
CREATE TRIGGER Valutazione_Trigger_I
BEFORE INSERT ON Valutazione
FOR EACH ROW
BEGIN
	IF NEW.Servizio <> "Car Sharing" AND NEW.Servizio <> "Ride Sharing" AND NEW.Servizio <> "Car Pooling" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Servizio non permesso";
	END IF;
    
    IF NEW.NumStelle < 1 AND NEW.NumStelle > 5 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di NumStelle non permesso";
    END IF;
    
    IF NEW.RuoloRecensore <> "Proponente" AND NEW.RuoloRecensore <> "Fruitore" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Ruolo Recensore non è permesso";
	END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS Valutazione_Trigger_U;

DELIMITER $$
CREATE TRIGGER Valutazione_Trigger_U
BEFORE UPDATE ON Valutazione
FOR EACH ROW
BEGIN
	IF NEW.Servizio <> "Car Sharing" AND NEW.Servizio <> "Ride Sharing" AND NEW.Servizio <> "Car Pooling" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Servizio non permesso";
	END IF;
    
    IF NEW.NumStelle < 1 AND NEW.NumStelle > 5 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di NumStelle non permesso";
    END IF;
    
    IF NEW.RuoloRecensore <> "Proponente" AND NEW.RuoloRecensore <> "Fruitore" THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Valore inserito di Ruolo Recensore non è permesso";
	END IF;
END $$
DELIMITER ;
