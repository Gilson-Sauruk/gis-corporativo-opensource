drop table if exists cartografia.gerencia;

create table if not exists cartografia.gerencia (
    id serial primary key,
    nome varchar (50) null,
    sigla varchar (10) null,
    cod_sap numeric (10, 0) null,
    diretoria numeric (5, 0) null,
    data date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.gerencia;

create index if not exists gerencia_geometry_idx on cartografia.gerencia using GIST(geometry);