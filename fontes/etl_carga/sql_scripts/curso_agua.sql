drop table if exists cartografia.curso_agua;

create table if not exists cartografia.curso_agua (
    id serial primary key,
    id_curso numeric (10, 0) not null,
    codigo varchar (40) not null,
    nome varchar (50) not null,
    regime varchar (15) not null,
    enabled boolean null default True,
    data date null,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.curso_agua;

create index if not exists curso_agua_geometry_idx on cartografia.curso_agua using GIST(geometry);