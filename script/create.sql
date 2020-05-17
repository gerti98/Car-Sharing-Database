SET NAMES latin1;
SET FOREIGN_KEY_CHECKS = 0;

BEGIN;
CREATE DATABASE IF NOT EXISTS `Smart Mobility`;
COMMIT;

USE `Smart Mobility`;

-- ----------------------------
--  Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS Account;
CREATE TABLE Account (
  NomeUtente VARCHAR(100) NOT NULL,
  Password VARCHAR(100) NOT NULL,
  DomandaDiRiserva VARCHAR(100) NOT NULL,
  RispostaDiRiserva VARCHAR(100) NOT NULL,
  StatoUtente VARCHAR(100) NOT NULL,
  DataDiRegistrazione DATE,
  CodiceFiscale VARCHAR(100) NOT NULL,
  PRIMARY KEY (NomeUtente),
  CONSTRAINT FK_Account_Utente
	FOREIGN KEY (CodiceFiscale)
    REFERENCES Utente(CodiceFiscale)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Autovettura
-- ----------------------------

DROP TABLE IF EXISTS Autovettura;
CREATE TABLE Autovettura (
  Targa VARCHAR(100) NOT NULL,
  CostoOperativo DOUBLE,
  Modello VARCHAR(100) NOT NULL,
  CostoDiUsura DOUBLE,
  CasaProduttrice VARCHAR(100) NOT NULL,
  Disponibilita VARCHAR(100) NOT NULL,
  AnnoDiImmatricolazione INT NOT NULL,
  Cilindrata DOUBLE,
  VelocitaMassima DOUBLE,
  PRIMARY KEY (Targa)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Utente
-- ----------------------------
DROP TABLE IF EXISTS Utente;
CREATE TABLE Utente(
  CodiceFiscale VARCHAR(100) NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Cognome VARCHAR(100) NOT NULL,
  Telefono VARCHAR(100) NOT NULL,
  DataNascita DATE NOT NULL,
  Sesso CHAR(10) NOT NULL,
  PRIMARY KEY (CodiceFiscale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Variazione
-- ----------------------------
DROP TABLE IF EXISTS Variazione;
CREATE TABLE Variazione (
  CodiceVariazione VARCHAR(100) NOT NULL,
  KilometroUscita INT NOT NULL,
  KilometroEntrata INT NOT NULL,
  KilometriPiu INT,
  PRIMARY KEY (CodiceVariazione)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Strada
-- ----------------------------
DROP TABLE IF EXISTS Strada;
CREATE TABLE Strada (
  IdentificatoreStrada VARCHAR(100) NOT NULL,
  Nome VARCHAR(100),
  Tipologia VARCHAR(100) NOT NULL,
  Categorizzazione VARCHAR(100),
  Sigla VARCHAR(100),
  ClassificazioneTecnica VARCHAR(100) NOT NULL,
  Lunghezza INT NOT NULL,
  PRIMARY KEY (IdentificatoreStrada)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- ----------------------------
--  Table structure for Veicolo_Esterno
-- ----------------------------
DROP TABLE IF EXISTS Veicolo_Esterno;
CREATE TABLE Veicolo_Esterno(
  TargaEsterna VARCHAR(100) NOT NULL,
  Modello VARCHAR(100) NOT NULL,
  CasaAutomobilistica VARCHAR(100) NOT NULL,
  PRIMARY KEY (TargaEsterna)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Proponente
-- ----------------------------
DROP TABLE IF EXISTS Proponente;
CREATE TABLE Proponente(
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  Affidabilità DOUBLE,
  PRIMARY KEY (NomeUtenteProponente),
  CONSTRAINT FK_Proponente_Account
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Account(NomeUtente)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Tratto
-- ----------------------------
DROP TABLE IF EXISTS Tratto;
CREATE TABLE Tratto (
  Chilometro INT NOT NULL, 
  IdentificatoreStrada VARCHAR(100) NOT NULL,
  Latitudine DOUBLE NOT NULL,
  Longitudine DOUBLE NOT NULL,
  LimiteVelocità INT NOT NULL,
  Pedaggio DOUBLE,
  PRIMARY KEY (Chilometro, IdentificatoreStrada),
  CONSTRAINT FK_Tratto_Strada
	FOREIGN KEY (IdentificatoreStrada)
	REFERENCES Strada(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Valutazione
-- ----------------------------
DROP TABLE IF EXISTS Valutazione;
CREATE TABLE Valutazione (
  CodiceValutazione VARCHAR(100) NOT NULL,
  NumStelle INT NOT NULL,
  Servizio VARCHAR(100) NOT NULL,
  Recensione TEXT NOT NULL,
  RuoloRecensore CHAR(10) NOT NULL,
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  NomeUtenteFruitore VARCHAR(100) NOT NULL,
  PRIMARY KEY (CodiceValutazione),
  CONSTRAINT FK_Valutazione_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
 CONSTRAINT FK_Valutazione_Fruitore
	FOREIGN KEY (NomeUtenteFruitore)
	REFERENCES Fruitore(NomeUtenteFruitore)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Fruitore
-- ----------------------------
DROP TABLE IF EXISTS Fruitore;
CREATE TABLE Fruitore (
  NomeUtenteFruitore VARCHAR(100) NOT NULL,
  Affidabilità DOUBLE,
  PRIMARY KEY (NomeUtenteFruitore),
  CONSTRAINT FK_Fruitore_Account
	FOREIGN KEY (NomeUtenteFruitore)
	REFERENCES Account(NomeUtente)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Composizione_Strada
-- ----------------------------
DROP TABLE IF EXISTS Composizione_Strada;
CREATE TABLE Composizione_Strada(
  IdentificatoreStrada VARCHAR(100) NOT NULL,
  SensiDiMarcia INT NOT NULL,
  NumeroDiCarreggiate INT NOT NULL,
  NumeroCorsie INT NOT NULL,
  SensoUnico VARCHAR(100),
  PRIMARY KEY (IdentificatoreStrada),
  CONSTRAINT FK_Composizione_Strada
	FOREIGN KEY (IdentificatoreStrada)
	REFERENCES Strada(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Congiunzione
-- ----------------------------

DROP TABLE IF EXISTS Congiunzione;
CREATE TABLE Congiunzione (
  ChilometroPrimaStradaX INT NOT NULL,
  IdentificativoPrimaStradaX VARCHAR(100) NOT NULL,
  ChilometroSecondaStradaX INT NOT NULL,
  IdentificativoSecondaStradaX VARCHAR(100) NOT NULL,
  PRIMARY KEY (ChilometroPrimaStradaX, IdentificativoPrimaStradaX, ChilometroSecondaStradaX, IdentificativoSecondaStradaX),
  CONSTRAINT FK_Congiunzione_Tratto_1
	FOREIGN KEY (ChilometroPrimaStradaX, IdentificativoPrimaStradaX)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Congiunzione_Tratto_2
	FOREIGN KEY (ChilometroSecondaStradaX, IdentificativoSecondaStradaX)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure Tipologia_Congiunzione
-- ----------------------------
DROP TABLE IF EXISTS Tipologia_Congiunzione;
CREATE TABLE Tipologia_Congiunzione (
  IdentificativoPrimaStrada VARCHAR(100) NOT NULL,
  IdentificativoSecondaStrada VARCHAR(100) NOT NULL,
  Tipologia VARCHAR(100) NOT NULL,
  PRIMARY KEY (IdentificativoPrimaStrada, IdentificativoSecondaStrada),
  CONSTRAINT FK_Congiunzione_Strada_1
	FOREIGN KEY (IdentificativoPrimaStrada)
	REFERENCES Tratto(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Congiunzione_Strada_2
	FOREIGN KEY (IdentificativoSecondaStrada)
	REFERENCES Tratto(IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Chiamata
-- ----------------------------
DROP TABLE IF EXISTS Chiamata;
CREATE TABLE Chiamata(
	CodiceChiamata VARCHAR(100) NOT NULL,
    TimestampChiamata TIMESTAMP,
    TimestampFineCorsa TIMESTAMP,
    TimestampRisposta TIMESTAMP,
    StatoChiamata VARCHAR(100),
    NomeUtenteFruitore VARCHAR(100),
    PRIMARY KEY(CodiceChiamata)
)Engine = InnoDB Default Charset = latin1;

-- ----------------------------
--  Table structure for Consumo
-- ----------------------------
DROP TABLE IF EXISTS Consumo;
CREATE TABLE Consumo (
  Targa VARCHAR(100) NOT NULL,
  CapacitaSerbatoio DOUBLE NOT NULL,
  ConsumoMedioUrbano DOUBLE NOT NULL,
  ConsumoMedioMisto DOUBLE NOT NULL,
  TipoAlimentazione VARCHAR(100) NOT NULL,
  ConsumoMedioExtraurbano DOUBLE NOT NULL,
  PRIMARY KEY (Targa),
  CONSTRAINT FK_Consumo_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Destinazione
-- ----------------------------
DROP TABLE IF EXISTS Destinazione;
CREATE TABLE Destinazione (
  Chilometro INT NOT NULL,
  IdentificativoStrada VARCHAR(100) NOT NULL,
  CodiceChiamata VARCHAR(100) NOT NULL,
  PRIMARY KEY (Chilometro, IdentificativoStrada, CodiceChiamata),
  CONSTRAINT FK_Destinazione_Tratto_
	FOREIGN KEY (Chilometro, IdentificativoStrada)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Destinazione_Chiamata
	FOREIGN KEY (CodiceChiamata)
	REFERENCES Chiamata(CodiceChiamata)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Documento
-- ----------------------------
DROP TABLE IF EXISTS Documento;
CREATE TABLE Documento(
  CodiceFiscale VARCHAR(100) NOT NULL,
  Tipologia VARCHAR(100) NOT NULL,
  Numero VARCHAR(100) NOT NULL,
  Scadenza DATE NOT NULL,
  EnteDiRilascio VARCHAR(100) NOT NULL,
  PRIMARY KEY (CodiceFiscale),
  CONSTRAINT FK_Documento_Utente
	FOREIGN KEY (CodiceFiscale)
	REFERENCES Utente(CodiceFiscale)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Fruibilita
-- ----------------------------
DROP TABLE IF EXISTS Fruibilita;
CREATE TABLE Fruibilita(
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  Giorno INT,
  OrarioInizio TIME, 
  OrarioFine TIME,
  PRIMARY KEY (NomeUtenteProponente, Targa, Giorno, OrarioInizio, OrarioFine),
  CONSTRAINT FK_Fruibilita_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Fruibilita_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------
--  Table structure for Indirizzo
-- ----------------------------
DROP TABLE IF EXISTS Indirizzo;
CREATE TABLE Indirizzo (
  CodiceFiscale VARCHAR(100) NOT NULL, 
  Via VARCHAR(100) NOT NULL, 
  CodicePostale INT NOT NULL,
  NumeroCivico INT NOT NULL,
  Provincia VARCHAR(100) NOT NULL,
  PRIMARY KEY (CodiceFiscale),
  CONSTRAINT FK_Indirizzo_Account
	FOREIGN KEY (CodiceFiscale)
	REFERENCES Utente(CodiceFiscale)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Luogo_Servizio
-- ----------------------------
DROP TABLE IF EXISTS Luogo_Servizio;
CREATE TABLE Luogo_Servizio (
  CodiceValutazione VARCHAR(100) NOT NULL,
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  PRIMARY KEY (CodiceValutazione, IdentificativoTragitto),
  CONSTRAINT FK_LuogoServizio_Valutazione
	FOREIGN KEY (CodiceValutazione)
	REFERENCES Valutazione(CodiceValutazione)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Optional
-- ----------------------------
DROP TABLE IF EXISTS Optional;
CREATE TABLE Optional (
  Targa VARCHAR(100) NOT NULL,
  TavoliPosteriori TINYINT NOT NULL,
  TettoInVetro TINYINT NOT NULL,
  DimensioniBagagliaio DOUBLE NOT NULL,
  Connettivita TINYINT NOT NULL,
  RumoreBordo DOUBLE NOT NULL,
  PRIMARY KEY (Targa),
  CONSTRAINT FK_Optional_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Pool
-- ----------------------------
DROP TABLE IF EXISTS Pool;
CREATE TABLE Pool (
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  GiornoPartenza DATE NOT NULL,
  OrarioPartenza TIME NOT NULL,
  GiornoDiArrivo DATE,
  Flessibilita VARCHAR(100),
  PeriodoDiValidita TIMESTAMP NOT NULL,
  PercentualeAumentoKm DOUBLE,
  StatoPool VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  ChilometriCorrentiVariazione INT,
  PRIMARY KEY (NomeUtenteProponente, GiornoPartenza, OrarioPartenza),
  CONSTRAINT FK_Pool_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Pool_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Posizione_Attuale
-- ----------------------------
DROP TABLE IF EXISTS Posizione_Attuale;
CREATE TABLE Posizione_Attuale(
  ChilometroAttuale INT NOT NULL,
  IdentificativoStradaAttuale VARCHAR(100) NOT NULL,
  CodiceChiamata VARCHAR(100) NOT NULL,
  PRIMARY KEY (ChilometroAttuale, IdentificativoStradaAttuale, CodiceChiamata),
  CONSTRAINT FK_PosAttuale_Tratto_
	FOREIGN KEY (ChilometroAttuale, IdentificativoStradaAttuale)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_PosAttuale_Chiamata
	FOREIGN KEY (CodiceChiamata)
	REFERENCES Chiamata(CodiceChiamata)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Possesso
-- ----------------------------
DROP TABLE IF EXISTS Possesso;
CREATE TABLE Possesso (
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  PRIMARY KEY (NomeUtenteProponente, Targa),
  CONSTRAINT FK_Possesso_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Possesso_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Prenotazione_Noleggio
-- ----------------------------
DROP TABLE IF EXISTS Prenotazione_Noleggio;
CREATE TABLE Prenotazione_Noleggio (
  DataInizioNoleggio DATE NOT NULL,
  NomeUtenteFruitore VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  DataFineNoleggio DATE NOT NULL,
  PRIMARY KEY (DataInizioNoleggio, NomeUtenteFruitore, Targa),
  CONSTRAINT FK_Prenotazione_Fruitore
	FOREIGN KEY (NomeUtenteFruitore)
	REFERENCES Fruitore(NomeUtenteFruitore)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Prenotazione_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Carburante_Pre_Noleggio
-- ----------------------------
DROP TABLE IF EXISTS Carburante_Pre_Noleggio;
CREATE TABLE Carburante_Pre_Noleggio(
  Targa VARCHAR(100) NOT NULL,
  CarburanteSerbatoio DOUBLE NOT NULL,
  PRIMARY KEY (Targa),
  CONSTRAINT FK_Carburante_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Prenotazione_Pool
-- ----------------------------
DROP TABLE IF EXISTS Prenotazione_Pool;
CREATE TABLE Prenotazione_Pool (
  CodicePrenotazione VARCHAR(100) NOT NULL,
  Spesa DOUBLE,
  NomeUtenteFruitore VARCHAR(100) NOT NULL,
  CodiceVariazione VARCHAR(100),
  PRIMARY KEY (CodicePrenotazione),
  CONSTRAINT FK_Prenotazione_Fruitore_Pool
	FOREIGN KEY (NomeUtenteFruitore)
	REFERENCES Fruitore(NomeUtenteFruitore)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Riferimento_Pool
-- ----------------------------
DROP TABLE IF EXISTS Riferimento_Pool;
CREATE TABLE Riferimento_Pool(
  CodicePrenotazione VARCHAR(100) NOT NULL, 
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  GiornoPartenza DATE NOT NULL,
  OrarioPartenza TIME NOT NULL,
  RispostaPool VARCHAR(100),
  PRIMARY KEY (CodicePrenotazione, NomeUtenteProponente, GiornoPartenza, OrarioPartenza),
  CONSTRAINT FK_Riferimento_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
 CONSTRAINT FK_RiferimentoPool_Prenotazione
	FOREIGN KEY (CodicePrenotazione)
	REFERENCES Prenotazione_Pool(CodicePrenotazione)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Riferimento_Tragitto_Noleggio
-- ----------------------------
DROP TABLE IF EXISTS Riferimento_Tragitto_Noleggio;
CREATE TABLE Riferimento_Tragitto_Noleggio(
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  GiornoPartenza DATE NOT NULL,
  OrarioPartenza TIME NOT NULL,
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  PRIMARY KEY (NomeUtenteProponente, GiornoPartenza, OrarioPartenza, IdentificativoTragitto),
  CONSTRAINT FK_RiferimentoTragittoNoleggio_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Riferimento_Tragitto_Pool
-- ----------------------------
DROP TABLE IF EXISTS Riferimento_Tragitto_Pool;
CREATE TABLE Riferimento_Tragitto_Pool(
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  GiornoPartenza DATE NOT NULL,
  OrarioPartenza TIME NOT NULL,
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  PRIMARY KEY (NomeUtenteProponente, GiornoPartenza, OrarioPartenza, IdentificativoTragitto),
  CONSTRAINT FK_RiferimentoTragittoPool_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Risposta_Proponente_Noleggio
-- ----------------------------
DROP TABLE IF EXISTS Risposta_Proponente_Noleggio;
CREATE TABLE Risposta_Proponente_Noleggio(
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  DataInizioNoleggio DATE NOT NULL,
  NomeUtenteFruitore VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  RispostaNoleggio VARCHAR(100),
  PRIMARY KEY (NomeUtenteProponente, DataInizioNoleggio, NomeUtenteFruitore, Targa),
  CONSTRAINT FK_RispostaNoleggio_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_RispostaNoleggio_Fruitore
	FOREIGN KEY (NomeUtenteFruitore)
	REFERENCES Fruitore(NomeUtenteFruitore)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
 CONSTRAINT FK_RispostaNoleggio_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Sharing
-- ----------------------------
DROP TABLE IF EXISTS Sharing;
CREATE TABLE Sharing(
  OrarioPartenza TIMESTAMP NOT NULL,
  NomeUtenteProponente VARCHAR(100) NOT NULL,
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  PRIMARY KEY (OrarioPartenza, NomeUtenteProponente, IdentificativoTragitto),
  CONSTRAINT FK_Sharing_Proponente
	FOREIGN KEY (NomeUtenteProponente)
	REFERENCES Proponente(NomeUtenteProponente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Sharing_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Sinistro
-- ----------------------------
DROP TABLE IF EXISTS Sinistro;
CREATE TABLE Sinistro(
  Targa VARCHAR(100) NOT NULL,
  Orario TIME NOT NULL,
  Data DATE NOT NULL,
  Dinamica VARCHAR(100) NOT NULL,
  Chilometro INT NOT NULL,
  IdentificatoreStrada VARCHAR(100) NOT NULL,
  NomeUtenteCoinvolto VARCHAR(100) NOT NULL,
  PRIMARY KEY (Targa, Orario, Data),
  CONSTRAINT FK_Sinistro_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Sinistro_Account
	FOREIGN KEY (NomeUtenteCoinvolto)
	REFERENCES Account(NomeUtente)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Sinistro_Tratto
	FOREIGN KEY (Chilometro, IdentificatoreStrada)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Stato_Veicolo
-- ----------------------------
DROP TABLE IF EXISTS Stato_Veicolo;
CREATE TABLE Stato_Veicolo (
  Targa VARCHAR(100) NOT NULL,
  KmPercorsi INT NOT NULL,
  Carburante DOUBLE NOT NULL,
  PRIMARY KEY (Targa),
  CONSTRAINT FK_Stato_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



-- ----------------------------
--  Table structure for Tracking
-- ----------------------------

DROP TABLE IF EXISTS Tracking;
CREATE TABLE Tracking(
  Chilometro INT NOT NULL,
  ChilometroTragitto INT NOT NULL,
  IdentificatoreStrada VARCHAR(100) NOT NULL,
  Targa VARCHAR(100) NOT NULL,
  Istante TIMESTAMP NOT NULL,
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  PRIMARY KEY (Chilometro, IdentificatoreStrada, Targa, Istante, IdentificativoTragitto),
    CONSTRAINT FK_Tracking_Tratto
	FOREIGN KEY (Chilometro, IdentificatoreStrada)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Tracking_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Tragitto
-- ----------------------------
DROP TABLE IF EXISTS Tragitto;
CREATE TABLE Tragitto (
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  KilometroTragitto INT NOT NULL,
  ChilometroIniziale INT NOT NULL,
  IdentificatoreStradaIniziale VARCHAR(100) NOT NULL,
  ChilometroFinale INT NOT NULL,
  IdentificatoreStradaFinale VARCHAR(100),
  PRIMARY KEY (IdentificativoTragitto, KilometroTragitto),
  CONSTRAINT FK_Tragitto_Tratto_1
	FOREIGN KEY (ChilometroIniziale, IdentificatoreStradaIniziale)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_Tragitto_Tratto_2
	FOREIGN KEY (ChilometroFinale, IdentificatoreStradaFinale)
	REFERENCES Tratto(Chilometro, IdentificatoreStrada)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Tragitto_Variato
-- ----------------------------
DROP TABLE IF EXISTS Tragitto_Variato;
CREATE TABLE Tragitto_Variato(
  IdentificativoTragitto VARCHAR(100) NOT NULL,
  CodiceVariazione VARCHAR(100) NOT NULL,
  PRIMARY KEY (IdentificativoTragitto, CodiceVariazione),
  CONSTRAINT FK_TragittoV_Variazione
	FOREIGN KEY (CodiceVariazione)
	REFERENCES Variazione(CodiceVariazione)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for Coinvolgimento_Esterno
-- ----------------------------
DROP TABLE IF EXISTS Coinvolgimento_Esterno;
CREATE TABLE Coinvolgimento_Esterno(
  Targa VARCHAR(100) NOT NULL,
  TargaEsterna VARCHAR(100) NOT NULL,
  Data DATE NOT NULL,
  Orario TIME NOT NULL,
  PRIMARY KEY (Targa, TargaEsterna, Data, Orario),
  CONSTRAINT FK_CoinvolgimentoEsterno_Autovettura
	FOREIGN KEY (Targa)
	REFERENCES Autovettura(Targa)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
  CONSTRAINT FK_CoinvolgimentoEsterno_VeicoloEsterno
	FOREIGN KEY (TargaEsterna)
	REFERENCES Veicolo_Esterno(TargaEsterna)
	ON UPDATE CASCADE
	ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
