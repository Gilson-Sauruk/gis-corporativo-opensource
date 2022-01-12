drop table if exists cartografia.bairro;

create table if not exists cartografia.bairro (
    id serial primary key,
    nome varchar (30) null ,
    codigo numeric (38, 8) null ,
    data date null ,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.bairro;

create index if not exists bairro_geometry_idx on cartografia.bairro using GIST(geometry);