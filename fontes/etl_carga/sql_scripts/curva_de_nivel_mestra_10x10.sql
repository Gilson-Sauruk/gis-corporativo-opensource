drop table if exists cartografia.curva_de_nivel_mestra_10x10;

create table if not exists cartografia.curva_de_nivel_mestra_10x10 (
    id serial primary key,
    data date null ,
    elevacao numeric (38, 8) null ,
    geometry geometry('MULTILINESTRINGZM', 31984)
);

truncate table cartografia.curva_de_nivel_mestra_10x10;

create index if not exists curva_de_nivel_mestra_10x10_geometry_idx on cartografia.curva_de_nivel_mestra_10x10 using GIST(geometry);
