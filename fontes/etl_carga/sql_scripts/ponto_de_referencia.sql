drop table if exists cartografia.ponto_de_referencia;

create table if not exists cartografia.ponto_de_referencia (
    id serial primary key,
    nat_pto_rf numeric (10, 0) null,
    nome varchar (50) null,
    telefone varchar (20) null,
    email varchar (50) null,
    data date null,
    geometry geometry('POINT', 31984)
);

truncate table cartografia.ponto_de_referencia;

create index if not exists ponto_de_referencia_geometry_idx on cartografia.ponto_de_referencia using GIST(geometry);