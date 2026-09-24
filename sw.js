/* RADAR — service worker minimo.
   Serve solo a rendere le pagine installabili e ad aprirle anche senza rete.
   Strategia: prima la rete, la cache solo come riserva. Cosi' gli aggiornamenti
   si vedono subito e non resti mai con una versione vecchia bloccata. */

const CACHE = 'radarcasa-v1';
const BASE = [
  './', './index.html', './dashboard.html',
  './icon-192.png', './icon-512.png', './favicon.png'
];

self.addEventListener('install', ev => {
  self.skipWaiting();
  ev.waitUntil(caches.open(CACHE).then(c => c.addAll(BASE).catch(() => {})));
});

self.addEventListener('activate', ev => {
  ev.waitUntil(
    caches.keys()
      .then(nomi => Promise.all(nomi.filter(n => n !== CACHE).map(n => caches.delete(n))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', ev => {
  const url = new URL(ev.request.url);

  // Mai toccare le chiamate a Supabase: dati, allegati e login
  // devono sempre passare dalla rete e non finire in cache.
  if (ev.request.method !== 'GET' || url.origin !== location.origin) return;

  ev.respondWith(
    fetch(ev.request)
      .then(risposta => {
        const copia = risposta.clone();
        caches.open(CACHE).then(c => c.put(ev.request, copia)).catch(() => {});
        return risposta;
      })
      .catch(() => caches.match(ev.request))
  );
});
