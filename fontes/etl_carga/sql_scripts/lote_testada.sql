drop table if exists cartografia.lote_testada;

create table if not exists cartografia.lote_testada (
    id bigserial primary key,
    data date null ,
    descricao varchar (200) null ,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.lote_testada;

create index if not exists lote_testada_geometry_idx on cartografia.lote_testada using GIST(geometry);