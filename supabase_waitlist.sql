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

-- Allow authenticated reads (for admin)
create policy "Allow authenticated reads"
  on public.waitlist
  for select
  to authenticated
  using (true);
