drop table if exists cartografia.sede_municipal;

create table if not exists cartografia.sede_municipal (
    id bigserial primary key,
    nome varchar (30) null ,
    data date null ,
    geometry geometry('POINT', 31984)
);

truncate table cartografia.sede_municipal;

create index if not exists sede_municipal_geometry_idx on cartografia.sede_municipal using GIST(geometry);