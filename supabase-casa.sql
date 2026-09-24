-- RADAR Casa — da eseguire UNA volta su Supabase: SQL Editor > New query > incolla > Run.
-- Crea la tabella delle case sfitte offerte e delle famiglie che cercano casa,
-- e la funzione pubblica usata dal modulo casa.html per inviare i dati.

create sequence if not exists casa_seq;

create table if not exists casa_richieste (
  id          uuid primary key default gen_random_uuid(),
  codice      text unique not null,
  tipo        text not null check (tipo in ('offerta','richiesta')),
  comune      text not null,
  dati        jsonb not null default '{}'::jsonb,
  nome        text not null,
  contatto    text not null,
  stato       text not null default 'nuova'
              check (stato in ('nuova','in_verifica','abbinata','chiusa')),
  note_comune text,
  creata_il   timestamptz not null default now()
);

alter table casa_richieste enable row level security;

-- I cittadini non leggono né modificano la tabella: scrivono solo tramite la funzione.
revoke all on casa_richieste from anon;

-- Gli operatori del comune (utenti con login, come per la dashboard segnalazioni)
drop policy if exists casa_lettura on casa_richieste;
create policy casa_lettura on casa_richieste
  for select to authenticated using (true);

drop policy if exists casa_modifica on casa_richieste;
create policy casa_modifica on casa_richieste
  for update to authenticated using (true) with check (true);

grant select, update on casa_richieste to authenticated;

create or replace function crea_richiesta_casa(
  p_tipo text, p_comune text, p_dati jsonb, p_nome text, p_contatto text
) returns text
language plpgsql security definer set search_path = public as $$
declare
  v_codice text;
begin
  if p_tipo not in ('offerta','richiesta') then raise exception 'Tipo non valido'; end if;
  if coalesce(trim(p_comune),'') = '' then raise exception 'Comune mancante'; end if;
  if length(coalesce(trim(p_nome),'')) < 2 then raise exception 'Nome mancante'; end if;
  if length(coalesce(trim(p_contatto),'')) < 6 then raise exception 'Recapito mancante'; end if;
  if pg_column_size(p_dati) > 8000 then raise exception 'Dati troppo lunghi'; end if;

  v_codice := 'CASA-' || to_char(now(),'YYYY') || '-' || lpad(nextval('casa_seq')::text, 5, '0');

  insert into casa_richieste (codice, tipo, comune, dati, nome, contatto)
  values (v_codice, p_tipo, initcap(trim(p_comune)), coalesce(p_dati,'{}'::jsonb),
          trim(p_nome), trim(p_contatto));

  return v_codice;
end $$;

revoke all on function crea_richiesta_casa(text,text,jsonb,text,text) from public;
grant execute on function crea_richiesta_casa(text,text,jsonb,text,text) to anon, authenticated;
