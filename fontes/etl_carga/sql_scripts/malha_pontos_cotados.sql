drop table if exists cartografia.malha_pontos_cotados;

create table if not exists cartografia.malha_pontos_cotados (
    id serial primary key,
    elevacao numeric (38, 8) not null,
    data date null,
    geometry geometry('POINTZM', 31984)
);

truncate table cartografia.malha_pontos_cotados;

create index if not exists malha_pontos_cotados_geometry_idx on cartografia.malha_pontos_cotados using GIST(geometry);