drop table if exists cartografia.malha_10x10km;

create table if not exists cartografia.malha_10x10km (
    id serial primary key,
    coord_e numeric (10, 0) null,
    coord_n numeric (10, 0) null,
    data date null,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.malha_10x10km;

create index if not exists malha_10x10km_geometry_idx on cartografia.malha_10x10km using GIST(geometry);