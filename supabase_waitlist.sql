-- Waitlist table for Align'd Wellness coming soon page
-- Run this in the Supabase SQL Editor

create table if not exists public.waitlist (
  id uuid default gen_random_uuid() primary key,
  first_name text,
  email text not null,
  source text default 'coming-soon-page',
  created_at timestamptz default now(),
  constraint waitlist_email_unique unique (email)
);

-- Enable RLS
alter table public.waitlist enable row level security;

-- Allow anonymous inserts (for the landing page form)
create policy "Allow anonymous waitlist signups"
  on public.waitlist
  for insert
  to anon
  with check (true);

-- No read policy on purpose: the app's users share this Supabase project, so
-- a read policy would expose every sign-up. View the list in the dashboard
-- (Table Editor / SQL Editor), which bypasses row-level security.
