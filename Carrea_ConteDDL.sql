CREATE TABLE Paziente (
    PazienteID SERIAL PRIMARY KEY,
    CodiceFiscale CHAR(16) UNIQUE NOT NULL, 
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    DataNascita DATE,
    Sesso CHAR(1) CHECK (Sesso IN ('M', 'F', 'X')), --RV1
    MedicoBase VARCHAR(50),
    NoteCliniche VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(50),
    Via VARCHAR(20),
    Citta VARCHAR(20),
    Provincia VARCHAR(2),
    CAP VARCHAR(5)
);

CREATE TABLE Medico (
    MedicoID SERIAL PRIMARY KEY,
    MatricolaMedico VARCHAR(20) UNIQUE,
    AlboNumero INT,
    Nome VARCHAR(30) NOT NULL,
    Cognome VARCHAR(30) NOT NULL,
    Specializzazione VARCHAR(50),
    Telefono VARCHAR(20),
    Email VARCHAR(50),
    Attivo VARCHAR(1) CHECK (Attivo IN ('Y', 'N')),--RV14
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    RepartoID INT
);

CREATE TABLE Reparto (
    RepartoID SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Ubicazione VARCHAR(100),
    Telefono VARCHAR(20),
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CapoMedicoID INT,
    CONSTRAINT fkRepartoMedico FOREIGN KEY (CapoMedicoID) REFERENCES Medico(MedicoID)
);

ALTER TABLE Medico
    ADD CONSTRAINT fkMedicoReparto FOREIGN KEY (RepartoID) REFERENCES Reparto(RepartoID);


CREATE TABLE Consenso (
    ConsensoID SERIAL PRIMARY KEY,
    Tipo VARCHAR(50) CHECK (Tipo IN ('IA', 'Privacy')), --RV2
    Stato VARCHAR(50) CHECK (Stato IN ('Concesso', 'Revocato')), --RV3
    ValidoDal TIMESTAMP,
    ValidoAl TIMESTAMP,
    PazienteID INT,
    CONSTRAINT fkConsensoPaziente FOREIGN KEY (PazienteID) REFERENCES Paziente(PazienteID)
);

CREATE TABLE ContattiEmergenza (
    ContattiID SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Relazione VARCHAR(50)
);

CREATE TABLE Designa (
    ContattiID INT,
    PazienteID INT,
    PRIMARY KEY (ContattiID, PazienteID),
    CONSTRAINT fkDesignaContatti FOREIGN KEY (ContattiID) REFERENCES ContattiEmergenza(ContattiID),
    CONSTRAINT fkDesignaPaziente FOREIGN KEY (PazienteID) REFERENCES Paziente(PazienteID)
);

CREATE TABLE Visita (
    VisitaID SERIAL PRIMARY KEY,
    VitaliTesto TEXT,
    EsameObbiettivo TEXT,
    Anamnesi TEXT,
    Sintomi TEXT,
    Stato VARCHAR(50) CHECK (Stato IN ('Aperta', 'Chiusa')),--RV8
    Started TIMESTAMP,
    Ended TIMESTAMP,
    MedicoID INT,
    AmbulatorioID INT,
    PrenotazioneID INT,
    CONSTRAINT fkVisitaMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID)
);

CREATE TABLE AllegatoVisita (
    AllegatoID SERIAL PRIMARY KEY,
    Descrizione VARCHAR(255),
    URI VARCHAR(500) CHECK (URI ~* '\.(pdf|img|jpg|docx|odt)$'), --RV31
    Tipo VARCHAR(50) Check (Tipo IN ('pdf', 'img', 'jpg', 'docx', 'odt')), --RV32
    VisitaID INT,
    CONSTRAINT fkAllegatoVisitaVisita FOREIGN KEY (VisitaID) REFERENCES Visita(VisitaID)
);

CREATE TABLE VisitaTipo (
    VisitaTipoID SERIAL PRIMARY KEY,
    Specialita VARCHAR(100),
    Codice VARCHAR(50),
    Descrizione VARCHAR(255),
    DurataMinuti INT,
    ICD9Predef VARCHAR(10)
);

CREATE TABLE Ambulatorio (
    AmbulatorioID SERIAL PRIMARY KEY,
    Specialita VARCHAR(100),
    Sede VARCHAR(100),
    Nome VARCHAR(100),
    Created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    RepartoID INT,
    CONSTRAINT fkAmbulatorioReparto FOREIGN KEY (RepartoID) REFERENCES Reparto(RepartoID)
);

CREATE TABLE Prenotazione (
    PrenotazioneID SERIAL PRIMARY KEY,
    Inizio TIMESTAMP,
    Fine TIMESTAMP,
    Motivo VARCHAR(255),
    Priorita VARCHAR(50) CHECK (Priorita IN ('Ordinaria', 'Urgente')),--RV5
    Note VARCHAR(50),
    Stato VARCHAR(50) CHECK (Stato IN ('Creata', 'Erogata', 'Confermata', 'Annullata')),--RV6
    VisitaTipoID INT,
    AmbulatorioID INT,
    PazienteID INT,
    CONSTRAINT fkPrenotazioneVisitaTipo FOREIGN KEY (VisitaTipoID) REFERENCES VisitaTipo(VisitaTipoID),
    CONSTRAINT fkPrenotazioneAmbulatorio FOREIGN KEY (AmbulatorioID) REFERENCES Ambulatorio(AmbulatorioID),
    CONSTRAINT fkPrenotazionePaziente FOREIGN KEY (PazienteID) REFERENCES Paziente(PazienteID)
);

ALTER TABLE Visita
    ADD CONSTRAINT fkVisitaAmbulatorio FOREIGN KEY (AmbulatorioID) REFERENCES Ambulatorio(AmbulatorioID),
    ADD CONSTRAINT fkVisitaPrenotazione FOREIGN KEY (PrenotazioneID) REFERENCES Prenotazione(PrenotazioneID);

CREATE TABLE CalendarioSlot (
    SlotID SERIAL PRIMARY KEY,
    Fonte VARCHAR(50) CHECK (Fonte IN ('Manuale', 'Generato')),--RV24
    Stato VARCHAR(50) CHECK (Stato IN ('Libero', 'Occupato', 'Bloccato')),--RV23
    Note VARCHAR(50),
    Inizio TIMESTAMP,
    Fine TIMESTAMP,
    AmbulatorioID INT,
    CONSTRAINT fkCalendarioSlotAmbulatorio FOREIGN KEY (AmbulatorioID) REFERENCES Ambulatorio(AmbulatorioID)
);

CREATE TABLE Abilitato (
    MedicoID INT,
    AmbulatorioID INT,
    DataInizio DATE,
    DataFine DATE,
    PRIMARY KEY (MedicoID, AmbulatorioID),
    CONSTRAINT fkAbilitatoMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID),
    CONSTRAINT fkAbilitatoAmbulatorio FOREIGN KEY (AmbulatorioID) REFERENCES Ambulatorio(AmbulatorioID)
);

CREATE TABLE AISuggerimento (
    SuggerimentoID SERIAL PRIMARY KEY,
    ModelloVersione VARCHAR(50),
    CandidatoCodice VARCHAR(50),
    CandidatoDescr TEXT,
    Confidenza DECIMAL(5,4) CHECK (Confidenza BETWEEN 0 AND 1),--RV16
    Spiegazione TEXT,
    VisitaID INT,
    CONSTRAINT fkSuggerimentoVisita FOREIGN KEY (VisitaID) REFERENCES Visita(VisitaID)
);

CREATE TABLE AIAzioneMedico (
    AzioneID SERIAL PRIMARY KEY,
    Azione VARCHAR(50) CHECK (Azione IN ('Accetta', 'Rigetta', 'Modifica')),--RV18
    Nota TEXT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SuggerimentoID INT,
    MedicoID INT,
    CONSTRAINT fkAzioneSuggerimento FOREIGN KEY (SuggerimentoID) REFERENCES AISuggerimento(SuggerimentoID),
    CONSTRAINT fkAzioneMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID)
);

CREATE TABLE Esame (
    EsameID SERIAL PRIMARY KEY,
    Tipo VARCHAR(100),
    Programmato TIMESTAMP,
    Eseguito TIMESTAMP,
    Stato VARCHAR(50) CHECK (Stato IN ('Prescritto', 'Programmato', 'Eseguito', 'Annullato')),--RV11
    Note TEXT,
    CodiceLOINC VARCHAR(50),
    VisitaID INT,
    CONSTRAINT fkEsameVisita FOREIGN KEY (VisitaID) REFERENCES Visita(VisitaID)
);

CREATE TABLE Referto (
    RefertoID SERIAL PRIMARY KEY,
    DatiStrutturali TEXT,
    AllegatoURI VARCHAR(500) CHECK (AllegatoURI ~* '\.(pdf|img|jpg|docx|odt)$'),--RV13
    Versione INT DEFAULT 1,
    MedicoID INT,
    EsameID INT,
    CONSTRAINT fkRefertoMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID),
    CONSTRAINT fkRefertoEsame FOREIGN KEY (EsameID) REFERENCES Esame(EsameID)
);

CREATE TABLE DizionarioDiagnosi (
    Codice VARCHAR(10) PRIMARY KEY, --ICD9
    Descrizione TEXT,
    Sistema VARCHAR(50),
    Attivo CHAR(1) CHECK (Attivo IN ('Y', 'N'))--Rv30
);

CREATE TABLE Diagnosi (
    DiagnosiID SERIAL PRIMARY KEY,
    VersioneDiagnosi INT DEFAULT 1,
    Descrizione TEXT,
    ValidataIl TIMESTAMP,
    Stato VARCHAR(50) CHECK (Stato IN ('Provvisoria', 'Finale')),--RV25
    Codice VARCHAR(10), --ICD9
    VisitaID INT,
    MedicoID INT,
    CONSTRAINT fkDiagnosiDizionarioDiagnosi FOREIGN KEY (Codice) REFERENCES DizionarioDiagnosi(Codice),
    CONSTRAINT fkDiagnosiVisita FOREIGN KEY (VisitaID) REFERENCES Visita(VisitaID),
    CONSTRAINT fkDiagnosiMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID)
);

CREATE TABLE UtenteSistema (
    UtenteID SERIAL PRIMARY KEY,
    Username VARCHAR(100) UNIQUE NOT NULL,
    Ruolo VARCHAR(50) CHECK (Ruolo IN ('OperatoreClinico', 'Amministrativo', 'Tecnico', 'Auditor')),--RV27
    Attivo CHAR(1) CHECK (Attivo IN ('Y', 'N')),--RV28
    MedicoID INT,
    CONSTRAINT fkUtenteSistemaMedico FOREIGN KEY (MedicoID) REFERENCES Medico(MedicoID)
);

CREATE TABLE Log (
    LogID SERIAL PRIMARY KEY,
    Entita VARCHAR(50),
    EntitaID INT,
    Azione VARCHAR(50) CHECK (Azione IN ('Create', 'Read', 'Update', 'Delete')),--RV29
    IP VARCHAR(45),
    DiffTesto TEXT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UtenteID INT,
    CONSTRAINT fkLogUtenteSistema FOREIGN KEY (UtenteID) REFERENCES UtenteSistema(UtenteID)
);