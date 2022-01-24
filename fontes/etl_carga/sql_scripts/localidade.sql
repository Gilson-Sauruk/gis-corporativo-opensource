drop table if exists cartografia.localidade;

create table if not exists cartografia.localidade (
    id serial primary key,
    nome varchar (30) null,
    data date null,
    codigo numeric (10, 0) null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.localidade;

create index if not exists localidade_geometry_idx on cartografia.localidade using GIST(geometry);