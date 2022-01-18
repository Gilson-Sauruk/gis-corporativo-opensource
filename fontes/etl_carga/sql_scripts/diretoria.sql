drop table if exists cartografia.diretoria;

create table if not exists cartografia.diretoria (
    id serial primary key,
    nome varchar (50) not null,
    sigla varchar (4) not null,
    codigo_sap numeric (10, 0) not null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.diretoria;

create index if not exists diretoria_geometry_idx on cartografia.diretoria using GIST(geometry);