drop table if exists cartografia.polo;

create table if not exists cartografia.polo (
    id serial primary key,
    nome varchar (50) null,
    sigla varchar (10) null,
    diretoria numeric (5, 0) null,
    gerencia numeric (5, 0) null,
    divisao numeric (5, 0) null,
    data date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.polo;

create index if not exists polo_geometry_idx on cartografia.polo using GIST(geometry);