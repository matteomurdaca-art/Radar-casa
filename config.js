/* RADAR — configurazione
   L'unico file da modificare quando cambiano progetto o chiave.
   I due valori si trovano su Supabase in Project Settings > API.
   La chiave da usare e' quella PUBBLICA (anon public / publishable),
   mai quella secret o service_role. */

var SUPABASE_URL = 'https://niyotnrttnklpqyylfmq.supabase.co';
var SUPABASE_KEY = 'sb_publishable_xnZuoub2QFpYMtEMgdOmHg_I7_j4nHH';

/* Canone concordato indicativo in euro al metro quadro al mese, dall'accordo
   territoriale del comune (es. 5.5). Serve solo a precompilare il calcolatore
   per i proprietari. Lasciare null finché non si ha il valore reale. */
var CANONE_MQ_INDICATIVO = null;
