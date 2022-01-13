drop table if exists cartografia.ferrovia;

create table if not exists cartografia.ferrovia (
    id serial primary key,
    descricao varchar (50) null ,
    nome varchar (50) null ,
    data date null ,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.ferrovia;

create index if not exists ferrovia_geometry_idx on cartografia.ferrovia using GIST(geometry);