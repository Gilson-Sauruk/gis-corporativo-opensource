drop table if exists cartografia.sede_distrital;

create table if not exists cartografia.sede_distrital (
    id serial primary key,
    nome varchar (30) null ,
    data numeric (38, 8) null ,
    geometry geometry('POINT', 31984)
);

truncate table cartografia.sede_distrital;

create index if not exists sede_distrital_geometry_idx on cartografia.sede_distrital using GIST(geometry);
