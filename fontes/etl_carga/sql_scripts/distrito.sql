drop table if exists cartografia.distrito;

create table if not exists cartografia.distrito (
    id serial primary key,
    nome varchar (40) not null,
    codigo_sap numeric (10, 0) not null,
    populacao numeric (10, 0) null,
    ano_referencia date null,
    data date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.distrito;

create index if not exists distrito_geometry_idx on cartografia.distrito using GIST(geometry);