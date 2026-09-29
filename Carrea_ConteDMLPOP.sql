
INSERT INTO Reparto (Nome, Ubicazione, Telefono) VALUES 
('Cardiologia', 'Padiglione A - Piano 1', '02-111111'),
('Pneumologia', 'Padiglione A - Piano 2', '02-222222'),
('Medicina Generale', 'Padiglione B - Piano 0', '02-333333'),
('Ortopedia', 'Padiglione C - Piano 1', '02-444444'),
('Diabetologia', 'Padiglione B - Piano 1', '02-555555');


INSERT INTO Medico (MatricolaMedico, AlboNumero, Nome, Cognome, Specializzazione, Telefono, Email, Attivo, RepartoID) VALUES 
('MED-001', 1001, 'Mario', 'Rossi', 'Cardiologo', '333-1111111', 'mario.rossi@ospedale.it', 'Y', 1),
('MED-002', 1002, 'Giulia', 'Bianchi', 'Pneumologa', '333-2222222', 'giulia.bianchi@ospedale.it', 'Y', 2),
('MED-003', 1003, 'Luca', 'Verdi', 'Medico Internista', '333-3333333', 'luca.verdi@ospedale.it', 'Y', 3),
('MED-004', 1004, 'Anna', 'Neri', 'Ortopedico', '333-4444444', 'anna.neri@ospedale.it', 'Y', 4),
('MED-005', 1005, 'Paolo', 'Gialli', 'Diabetologo', '333-5555555', 'paolo.gialli@ospedale.it', 'N', 5);


UPDATE Reparto SET CapoMedicoID = 1 WHERE RepartoID = 1;
UPDATE Reparto SET CapoMedicoID = 2 WHERE RepartoID = 2;
UPDATE Reparto SET CapoMedicoID = 3 WHERE RepartoID = 3;
UPDATE Reparto SET CapoMedicoID = 4 WHERE RepartoID = 4;
UPDATE Reparto SET CapoMedicoID = 5 WHERE RepartoID = 5;


INSERT INTO Ambulatorio (Specialita, Sede, Nome, RepartoID) VALUES 
('Cardiologia', 'Stanza 101', 'Ambulatorio Cuore', 1),
('Pneumologia', 'Stanza 201', 'Ambulatorio Respiro', 2),
('Medicina Interna', 'Stanza 001', 'Ambulatorio Generale A', 3),
('Ortopedia', 'Stanza 105', 'Ambulatorio Articolazioni', 4),
('Diabetologia', 'Stanza 110', 'Ambulatorio Metabolico', 5);


INSERT INTO Paziente (CodiceFiscale, Nome, Cognome, DataNascita, Sesso, MedicoBase, NoteCliniche, Telefono, Email, Via, Citta, Provincia, CAP) VALUES 
('RSSMRA80A01H501A', 'Marco', 'Rossi', '1980-01-01', 'M', 'Dott. Ferrari', 'Nessuna', '340-1111111', 'marco@mail.it', 'Via Roma 1', 'Milano', 'MI', '20100'),
('BNCGLI85B42H501B', 'Giulia', 'Bianchi', '1985-02-12', 'F', 'Dott. Ferrari', 'Allergia penicillina', '340-2222222', 'giulia@mail.it', 'Via Milano 2', 'Torino', 'TO', '10100'),
('VRDLCU90C15H501C', 'Luca', 'Verdi', '1990-03-15', 'M', 'Dott. Russo', 'Iperteso', '340-3333333', 'luca@mail.it', 'Via Napoli 3', 'Roma', 'RM', '00100'),
('NRANNA95D44H501D', 'Anna', 'Neri', '1995-04-14', 'F', 'Dott. Colombo', 'Diabete Tipo 1', '340-4444444', 'anna@mail.it', 'Via Venezia 4', 'Venezia', 'VE', '30100'),
('GLLPLO70E10H501E', 'Paolo', 'Gialli', '1970-05-10', 'M', 'Dott. Conti', 'Asmatico', '340-5555555', 'paolo@mail.it', 'Via Firenze 5', 'Firenze', 'FI', '50100');


INSERT INTO ContattiEmergenza (Nome, Cognome, Telefono, Relazione) VALUES 
('Maria', 'Galli', '333-9999991', 'Madre'),     
('Luigi', 'Rossi', '333-9999992', 'Fratello'),  
('Giovanna', 'Neri', '333-9999993', 'Coniuge');


INSERT INTO Designa (ContattiID, PazienteID) VALUES 
(1, 1),
(2, 1),
(1, 2),
(3, 3);


INSERT INTO Consenso (Tipo, Stato, ValidoDal, PazienteID) VALUES 
('Privacy', 'Concesso', CURRENT_TIMESTAMP, 1),
('IA', 'Concesso', CURRENT_TIMESTAMP, 1),
('Privacy', 'Concesso', CURRENT_TIMESTAMP, 2),
('IA', 'Revocato', CURRENT_TIMESTAMP, 3),
('Privacy', 'Concesso', CURRENT_TIMESTAMP, 4);


INSERT INTO VisitaTipo (Specialita, Codice, Descrizione, DurataMinuti, ICD9Predef) VALUES 
('Cardiologia', 'VIS-CARD-01', 'Prima visita cardiologica', 30, '401.9'),
('Cardiologia', 'ECG-01', 'Elettrocardiogramma', 15, '427.31'),
('Pneumologia', 'VIS-PNEU-01', 'Visita pneumologica', 30, '493.90'),
('Diabetologia', 'VIS-DIAB-01', 'Controllo diabetologico', 20, '250.00'),
('Ortopedia', 'VIS-ORT-01', 'Visita ortopedica ginocchio', 30, '715.90');


INSERT INTO CalendarioSlot (Fonte, Stato, Inizio, Fine, AmbulatorioID) VALUES 
('Generato', 'Libero', '2026-10-01 09:00:00', '2026-10-01 09:30:00', 1),
('Generato', 'Occupato', '2026-10-01 09:30:00', '2026-10-01 10:00:00', 1),
('Manuale', 'Bloccato', '2026-10-01 10:00:00', '2026-10-01 10:30:00', 1),
('Generato', 'Occupato', '2026-10-02 11:00:00', '2026-10-02 11:30:00', 2),
('Generato', 'Libero', '2026-10-02 11:30:00', '2026-10-02 12:00:00', 2);


INSERT INTO Prenotazione (Inizio, Fine, Motivo, Priorita, Stato, VisitaTipoID, AmbulatorioID, PazienteID) VALUES 
('2026-10-01 09:30:00', '2026-10-01 10:00:00', 'Controllo pressione', 'Ordinaria', 'Erogata', 1, 1, 1),
('2026-10-02 11:00:00', '2026-10-02 11:30:00', 'Tosse persistente', 'Urgente', 'Confermata', 3, 2, 2),
('2026-10-03 09:00:00', '2026-10-03 09:30:00', 'Dolore petto', 'Urgente', 'Annullata', 1, 1, 3),
('2026-10-04 10:00:00', '2026-10-04 10:20:00', 'Controllo glicemia', 'Ordinaria', 'Creata', 4, 5, 4),
('2026-10-05 14:00:00', '2026-10-05 14:30:00', 'Dolore ginocchio', 'Ordinaria', 'Confermata', 5, 4, 5);


INSERT INTO Visita (VitaliTesto, EsameObbiettivo, Anamnesi, Sintomi, Stato, MedicoID, AmbulatorioID, PrenotazioneID) VALUES 
('PA 130/80', 'Cuore ritmico', 'Paziente iperteso', 'Lieve affaticamento', 'Chiusa', 1, 1, 1),
('PA 120/70, Sat 95%', 'Murmure ridotto', 'Fumatrice', 'Tosse stizzosa', 'Aperta', 2, 2, 2),
('PA 140/90', 'Ritmo irregolare', 'Nessuna', 'Palpitazioni', 'Chiusa', 1, 1, NULL),
('PA 110/70', 'Glicemia 150', 'Diabete da 5 anni', 'Nessuno', 'Aperta', 5, 5, 4),
('PA 125/80', 'Gonfiore articolare', 'Trauma pregresso', 'Dolore sotto carico', 'Chiusa', 4, 4, 5);


INSERT INTO UtenteSistema (Username, Ruolo, Attivo, MedicoID) VALUES 
('admin', 'Tecnico', 'Y', NULL),
('mrossi_doc', 'OperatoreClinico', 'Y', 1),
('gbianchi_doc', 'OperatoreClinico', 'Y', 2),
('lverdi_doc', 'OperatoreClinico', 'Y', 3),
('aneri_doc', 'OperatoreClinico', 'Y', 4),
('pgialli_doc', 'OperatoreClinico', 'N', 5),
('auditor_01', 'Auditor', 'Y', NULL),
('segreteria', 'Amministrativo', 'Y', NULL);


INSERT INTO AISuggerimento (ModelloVersione, CandidatoCodice, CandidatoDescr, Confidenza, Spiegazione, VisitaID) VALUES 
('v1.5', '401.9', 'Ipertensione essenziale', 0.9500, 'Valori pressori elevati storici', 1),
('v1.5', '493.90', 'Asma', 0.8200, 'Saturazione e sintomi compatibili', 2);

--popolato il dizionario diagnosi con tutte le diagnosi date
INSERT INTO DizionarioDiagnosi (Codice, Descrizione, Sistema, Attivo) VALUES 
('401.9', 'Ipertensione essenziale, non specificata', 'ICD-9', 'Y'),
('250.00', 'Diabete mellito tipo II, senza complicanze, non specificato come non controllato', 'ICD-9', 'Y'),
('414.01', 'Aterosclerosi coronarica del vaso nativo', 'ICD-9', 'Y'),
('428.0', 'Scompenso cardiaco congestizio, non specificato', 'ICD-9', 'Y'),
('427.31', 'Fibrillazione atriale', 'ICD-9', 'Y'),
('272.4', 'Iperlipidemia, non specificata', 'ICD-9', 'Y'),
('493.90', 'Asma, non specificata, senza menzione di stato asmatico', 'ICD-9', 'Y'),
('486', 'Polmonite, agente non specificato', 'ICD-9', 'Y'),
('599.0', 'Infezione delle vie urinarie, sede non specificata', 'ICD-9', 'Y'),
('530.81', 'Reflusso gastroesofageo (GERD)', 'ICD-9', 'Y'),
('784.0', 'Cefalea', 'ICD-9', 'Y'),
('724.2', 'Lombalgia', 'ICD-9', 'Y'),
('715.90', 'Osteoartrosi, sede non specificata', 'ICD-9', 'Y'),
('311', 'Disturbo depressivo, non altrimenti specificato', 'ICD-9', 'Y'),
('278.00', 'Obesità, non specificata', 'ICD-9', 'Y'),
('244.9', 'Ipotiroidismo, non specificato', 'ICD-9', 'Y'),
('285.9', 'Anemia, non specificata', 'ICD-9', 'Y'),
('780.2', 'Sincope e collasso', 'ICD-9', 'Y'),
('780.79', 'Altra astenia e affaticamento', 'ICD-9', 'Y'),
('789.00', 'Dolore addominale, sede non specificata', 'ICD-9', 'Y');