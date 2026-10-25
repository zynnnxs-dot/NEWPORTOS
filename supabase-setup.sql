-- Jalankan seluruh SQL ini di Supabase > SQL Editor > New query.
create table if not exists public.site_content (
  id integer primary key default 1 check (id = 1),
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.site_content enable row level security;

-- Pengunjung boleh membaca konten portofolio.
drop policy if exists "Public can read portfolio content" on public.site_content;
create policy "Public can read portfolio content"
on public.site_content for select to anon, authenticated using (true);

-- Hanya pengguna yang login dapat mengubah konten.
drop policy if exists "Authenticated admins can insert portfolio content" on public.site_content;
create policy "Authenticated admins can insert portfolio content"
on public.site_content for insert to authenticated with check (true);

drop policy if exists "Authenticated admins can update portfolio content" on public.site_content;
create policy "Authenticated admins can update portfolio content"
on public.site_content for update to authenticated using (true) with check (true);

insert into public.site_content (id, content)
values (1, '{
  "name":"",
  "eyebrow":"PORTOFOLIO KREATIF · 2026",
  "tagline":"Fotografi, desain visual, dan kreativitas dalam satu ruang.",
  "location":"INDONESIA",
  "aboutHeading":"Mengenal saya.",
  "aboutText":"Bagian ini bisa kamu isi melalui admin panel.",
  "aboutExtra":"",
  "education":[{"year":"","title":"","detail":""}],
  "skills":["Fotografi","Desain visual"],
  "heroImage":"",
  "works":[],
  "email":"",
  "whatsapp":"",
  "instagram":"",
  "tiktok":""
}'::jsonb)
on conflict (id) do nothing;

-- Bucket publik untuk gambar karya/foto utama.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('portfolio-images', 'portfolio-images', true, 8388608, array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true;

drop policy if exists "Public can view portfolio images" on storage.objects;
create policy "Public can view portfolio images"
on storage.objects for select to public using (bucket_id = 'portfolio-images');

drop policy if exists "Authenticated admins can upload portfolio images" on storage.objects;
create policy "Authenticated admins can upload portfolio images"
on storage.objects for insert to authenticated with check (bucket_id = 'portfolio-images');

drop policy if exists "Authenticated admins can update portfolio images" on storage.objects;
create policy "Authenticated admins can update portfolio images"
on storage.objects for update to authenticated using (bucket_id = 'portfolio-images') with check (bucket_id = 'portfolio-images');

drop policy if exists "Authenticated admins can delete portfolio images" on storage.objects;
create policy "Authenticated admins can delete portfolio images"
on storage.objects for delete to authenticated using (bucket_id = 'portfolio-images');
