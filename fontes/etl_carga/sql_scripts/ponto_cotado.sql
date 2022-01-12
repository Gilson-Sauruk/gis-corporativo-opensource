drop table if exists cartografia.ponto_cotado;

create table if not exists cartografia.ponto_cotado (
    id serial primary key,
    elevacao numeric (38, 8) null ,
    data date null ,
    geometry geometry('POINT', 31984)
);

truncate table cartografia.ponto_cotado;

create index if not exists ponto_cotado_geometry_idx on cartografia.ponto_cotado using GIST(geometry);