drop table if exists cartografia.curva_de_nivel_mestra_5x5;

create table if not exists cartografia.curva_de_nivel_mestra_5x5 (
    id serial primary key,
    elevacao numeric (10, 0) null ,
    data date null ,
    geometry geometry('MULTILINESTRINGZM', 31984)
);

truncate table cartografia.curva_de_nivel_mestra_5x5;

create index if not exists curva_de_nivel_mestra_5x5_geometry_idx on cartografia.curva_de_nivel_mestra_5x5 using GIST(geometry);
