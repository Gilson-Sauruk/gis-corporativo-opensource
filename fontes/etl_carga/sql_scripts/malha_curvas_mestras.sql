drop table if exists cartografia.malha_curvas_mestras;

create table if not exists cartografia.malha_curvas_mestras (
    id serial primary key,
    elevacao numeric (38, 8) null,
    data date null,
    geometry geometry('MULTILINESTRINGZM', 31984)
);

truncate table cartografia.malha_curvas_mestras;

create index if not exists malha_curvas_mestras_geometry_idx on cartografia.malha_curvas_mestras using GIST(geometry);