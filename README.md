# RADAR CASA

Case sfitte da una parte, famiglie che cercano casa dall'altra: il Comune le mette in contatto
con contratti a canone concordato e garanzie.

## File
- `index.html` — app per i cittadini: "Ho una casa sfitta", "Cerco casa" e il calcolatore
  "Quanto mi costa tenerla vuota?" per i proprietari.
- `dashboard.html` — dashboard del Comune: radar con le case, sintesi, elenco, dettaglio,
  abbinamenti, avvisi e notifiche.
- `config.js` — collegamento a Supabase e canone indicativo per il calcolatore.
- `supabase-casa.sql` — tabella e funzione da creare una volta su Supabase.
- `manifest-*.webmanifest`, `sw.js`, icone — per installare le pagine come app.

## Messa online
1. Crea su GitHub un nuovo repository `Radar-Casa` e carica tutti i file.
2. Settings > Pages > Branch `main` > Save.
3. Se non l'hai già fatto per Radar, esegui `supabase-casa.sql` nel SQL Editor di Supabase.
4. App cittadini: `https://<account>.github.io/Radar-Casa/`
   Dashboard: `https://<account>.github.io/Radar-Casa/dashboard.html`

## Da completare
- `CANONE_MQ_INDICATIVO` in `config.js` con il valore dell'accordo territoriale del comune pilota.
- Pagina privacy.
