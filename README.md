# RADAR CASA

**Case sfitte da una parte, famiglie che cercano casa dall'altra.**
RADAR CASA aiuta i comuni a rimettere in affitto le case vuote: raccoglie le disponibilità
dei proprietari e le richieste delle famiglie, propone gli abbinamenti compatibili e
accompagna il contratto a canone concordato con la garanzia del comune.

> Software proprietario. Vedi [LICENSE](LICENSE). Uso consentito solo con autorizzazione scritta.

---

## Come funziona

1. **Il proprietario** mette a disposizione la casa, dopo aver visto con il calcolatore quanto
   gli costa tenerla vuota rispetto ad affittarla a canone concordato.
2. **La famiglia** indica cosa cerca: comune, persone, locali minimi, affitto sostenibile.
3. **Il comune** verifica, vede le corrispondenze compatibili e abbina casa e famiglia.
   La scelta finale dell'inquilino resta al proprietario.
4. **Il contratto** è a canone concordato, con garanzia su canoni e danni e agevolazioni fiscali.

## Le pagine

| Pagina | Per chi | Cosa fa |
|---|---|---|
| `index.html` | Cittadini | "Ho una casa sfitta", "Cerco casa", calcolatore per il proprietario |
| `dashboard.html` | Operatori del comune | Radar delle pratiche, sintesi, elenco, dettaglio, abbinamenti, notifiche |
| `privacy.html` | Tutti | Informativa sul trattamento dei dati |

## Abbinamento

Casa e famiglia sono compatibili quando: stesso comune, pratiche entrambe aperte, casa non da
ristrutturare, locali sufficienti, arredo coerente con la richiesta. Il canone concordato va
verificato dall'operatore rispetto all'affitto massimo della famiglia.

## Struttura dei file

```
index.html                     app cittadini
dashboard.html                 dashboard del comune (accesso riservato)
privacy.html                   informativa privacy
config.js                      collegamento a Supabase e canone indicativo
supabase-casa.sql              tabella e funzione del database
manifest-app.webmanifest       installazione app cittadini
manifest-dashboard.webmanifest installazione dashboard
sw.js                          service worker
favicon.png, icon-*.png        icone
LICENSE                        licenza proprietaria
```

## Installazione

1. **Database**: su Supabase apri SQL Editor, incolla `supabase-casa.sql` ed esegui con Run.
2. **Configurazione**: in `config.js` inserisci URL e chiave pubblica del progetto Supabase.
   Facoltativo: `CANONE_MQ_INDICATIVO` con il valore in €/m² al mese dall'accordo
   territoriale del comune, per precompilare il calcolatore.
3. **Operatori**: crea gli utenti del comune in Supabase, sezione Authentication.
4. **Pubblicazione**: carica i file su GitHub e attiva GitHub Pages
   (Settings > Pages > branch `main`).
5. **Privacy**: completa in `privacy.html` i dati del comune titolare, i tempi di conservazione
   e il fornitore del database.

## Tecnologie

HTML, CSS e JavaScript senza dipendenze esterne, database Supabase (PostgreSQL con
Row Level Security), hosting statico. Funziona su telefono e computer e si può installare
come app.

## Sicurezza dei dati

- I cittadini possono solo inviare: non leggono i dati degli altri.
- Solo gli operatori autenticati del comune leggono e aggiornano le pratiche.
- Nessun documento d'identità o dato sanitario viene raccolto dal modulo online:
  i documenti si verificano al colloquio.

## Stato del progetto

Prototipo funzionante, pronto per un comune pilota.

## Contatti

Matteo Murdaca · [indirizzo email]
