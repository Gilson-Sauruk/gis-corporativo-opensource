drop table if exists cartografia.malha_curvas_intermediarias;

create table if not exists cartografia.malha_curvas_intermediarias (
    id serial primary key,
    elevacao numeric (38, 8) null,
    data date null,
    geometry geometry('MULTILINESTRINGZM', 31984)
);

truncate table cartografia.malha_curvas_intermediarias;

create index if not exists malha_curvas_intermediarias_geometry_idx on cartografia.malha_curvas_intermediarias using GIST(geometry);