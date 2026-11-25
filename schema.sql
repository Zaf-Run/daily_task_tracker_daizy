-- Run this once in the Supabase SQL editor.
create table tasks (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null,
  descr text default '',
  sched_date date not null,
  sched_time text,
  dur int default 0,
  pri text default 'Medium' check (pri in ('High','Medium','Low')),
  status text default 'Pending' check (status in ('Pending','Ongoing','Done')),
  cat text default '',
  deadline date,
  remind text,
  notified boolean default false,
  created_at timestamptz default now()
);
create table task_resources (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  task_id text not null references tasks(id) on delete cascade,
  title text default '', url text default '', type text default 'Other', note text default ''
);
create table pomodoro_sessions (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  task_id text references tasks(id) on delete set null,
  mins int not null, sess_date date not null, ts bigint not null, kind text default 'pomodoro'
);
create table notifications (
  id text primary key,
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  ts bigint not null, title text, body text default ''
);
create table user_settings (
  user_id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  data jsonb not null default '{}'
);
create index on tasks (user_id, sched_date);
create index on pomodoro_sessions (user_id, sess_date);
create index on task_resources (task_id);

do $$ declare t text; begin
  foreach t in array array['tasks','task_resources','pomodoro_sessions','notifications','user_settings'] loop
    execute format('alter table %I enable row level security', t);
    execute format('create policy "own rows" on %I for all using (user_id = auth.uid()) with check (user_id = auth.uid())', t);
  end loop;
end $$;
