drop table if exists cartografia.divisao;

create table if not exists cartografia.divisao (
    id serial primary key,
    sigla varchar (10) not null,
    data date not null,
    nome varchar (30) not null,
    gerencia numeric (10, 0) not null,
    diretoria numeric (10, 0) not null,
    codigo_sap numeric (10, 0) not null,
    codigo numeric (10, 0) null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.divisao;

create index if not exists divisao_geometry_idx on cartografia.divisao using GIST(geometry);