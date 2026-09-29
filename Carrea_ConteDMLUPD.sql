
INSERT INTO Diagnosi (VersioneDiagnosi, Descrizione, Stato, Codice, VisitaID, MedicoID)
VALUES (1, 'Sospetta asma, in attesa di spirometria', 'Provvisoria', '493.90', 2, 2);


INSERT INTO Log (Entita, EntitaID, Azione, IP, DiffTesto, UtenteID)
VALUES ('Diagnosi', 1, 'Create', '192.168.1.55', 'Inserita diagnosi provvisoria 493.90', 3);


INSERT INTO Consenso (Tipo, Stato, ValidoDal, ValidoAl, PazienteID)
VALUES ('Privacy', 'Concesso', CURRENT_TIMESTAMP, '2026-12-31 23:59:59', 2);


UPDATE Referto
SET Versione = Versione + 1,
    DatiStrutturali = 'Referto validato definitivamente: nessuna anomalia di rilievo.'
WHERE RefertoID = 1;


UPDATE Visita
SET Stato = 'Chiusa',
    Ended = CURRENT_TIMESTAMP
WHERE VisitaID = 2;


UPDATE UtenteSistema
SET Attivo = 'N'
WHERE UtenteID = 3;


UPDATE Esame
SET Stato = 'Eseguito',
    Eseguito = CURRENT_TIMESTAMP,
    Note = 'Prelievo effettuato correttamente'
WHERE EsameID = 1;


INSERT INTO UtenteSistema (Username, Ruolo, Attivo, MedicoID) 
VALUES ('admin_it_02', 'Tecnico', 'Y', NULL);