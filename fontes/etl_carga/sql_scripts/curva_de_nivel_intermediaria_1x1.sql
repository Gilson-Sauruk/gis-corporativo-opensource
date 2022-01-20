drop table if exists cartografia.curva_de_nivel_intermediaria_1x1;

create table if not exists cartografia.curva_de_nivel_intermediaria_1x1 (
    id serial primary key,
    elevacao numeric (10, 0) null,
    data date null,
    geometry geometry('MULTILINESTRINGZM', 31984)
);

truncate table cartografia.curva_de_nivel_intermediaria_1x1;

create index if not exists curva_de_nivel_intermediaria_1x1_geometry_idx on cartografia.curva_de_nivel_intermediaria_1x1 using GIST(geometry);