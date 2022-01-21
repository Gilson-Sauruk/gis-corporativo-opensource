drop table if exists cartografia.logradouro;

create table if not exists cartografia.logradouro (
    id serial primary key,
    nome_rua varchar (75) null,
    natureza numeric (5, 0) null,
    nome_cesan varchar (50) null,
    codigo numeric (10, 0) null,
    lei varchar (50) null,
    data date null,
    oid_carga numeric (10, 0) null,
    status varchar (1) null,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.logradouro;

create index if not exists logradouro_geometry_idx on cartografia.logradouro using GIST(geometry);