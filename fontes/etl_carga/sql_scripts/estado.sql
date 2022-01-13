drop table if exists cartografia.estado;

create table if not exists cartografia.estado (
    id serial primary key,
    cod_ibge numeric (38, 8) null ,
    nome varchar (20) null ,
    area_ibge numeric (38, 8) null ,
    cod_sap numeric (10, 0) null ,
    data date null ,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.estado;

create index if not exists estado_geometry_idx on cartografia.estado using GIST(geometry);