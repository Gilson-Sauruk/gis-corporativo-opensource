drop table if exists cartografia.lote;

create table if not exists cartografia.lote (
    id serial primary key,
    data date null ,
    origem varchar (100) null ,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.lote;

create index if not exists lote_geometry_idx on cartografia.lote using GIST(geometry);