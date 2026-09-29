# 🏥 Hospital AI Database System

Progetto universitario realizzato per il corso di **Basi di dati e Sistemi Informativi (A.A. 2025-2026)** presso l'Università del Piemonte Orientale.

Questo progetto consiste nella progettazione (concettuale e logica) e nell'implementazione SQL di un database relazionale per la gestione completa delle attività ambulatoriali e specialistiche di un ospedale. 

La particolarità del sistema è l'integrazione di un **motore di Intelligenza Artificiale** che supporta il medico nel percorso clinico, suggerendo diagnosi (basate sui codici ICD-9) con relativi punteggi di confidenza, mantenendo il medico come unico responsabile finale della validazione.

## 👥 Autori
* Matteo Conte
* Jacopo Carrea

## ⚙️ Funzionalità Principali
* **Gestione Pazienti e Consensi:** Anagrafica pazienti, contatti di emergenza multipli e storicizzazione dei consensi per la privacy e l'uso dell'IA.
* **Struttura Ospedaliera:** Organizzazione in Reparti, Ambulatori e gestione dell'équipe medica.
* **Iter Clinico:** Prenotazione degli slot a calendario, gestione delle visite, prescrizione di esami (codificati LOINC) e refertazione.
* **Supporto AI:** Entità dedicate per registrare i suggerimenti dell'algoritmo (`AISuggerimento`) e le decisioni prese in merito dal medico (`AIAzioneMedico`).
* **Sicurezza e Tracciamento:** Gestione degli utenti di sistema (Operatore Clinico, Amministrativo, Tecnico, Auditor) e tabella di `Log` per tracciare ogni operazione CRUD effettuata.

## 📂 Struttura della Repository
La repository contiene la documentazione completa e gli script SQL per replicare il database:

1. **`CarreaConte.pdf`**: Relazione completa contenente l'analisi dei requisiti, glossario, schema E-R concettuale, ristrutturazioni logiche e regole aziendali.
2. **`Carrea_ConteDDL.sql`**: Script per la creazione dello schema fisico del database (tabelle, chiavi primarie/esterne, vincoli `CHECK` e integrità referenziale).
3. **`Carrea_ConteDMLPOP.sql`**: Script per il popolamento iniziale del database con dati mock realistici (inserimento di reparti, medici, pazienti, dizionario ICD-9, prenotazioni e visite).
4. **`Carrea_ConteDMLUPD.sql`**: Script contenente le query di aggiornamento e simulazione delle operazioni quotidiane (es. inserimento diagnosi, aggiornamento referti, chiusura visite e revoca permessi).

## 🚀 Come testare il database
Per ricreare l'ambiente, eseguire gli script nel seguente ordine rigoroso su un server PostgreSQL o DBMS compatibile:
1. Eseguire `Carrea_ConteDDL.sql` per costruire lo scheletro.
2. Eseguire `Carrea_ConteDMLPOP.sql` per caricare i dati base.
3. Eseguire `Carrea_ConteDMLUPD.sql` per testare le logiche di aggiornamento.
