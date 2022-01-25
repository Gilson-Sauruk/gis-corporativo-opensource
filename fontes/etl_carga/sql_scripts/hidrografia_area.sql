drop table if exists cartografia.hidrografia_area;

create table if not exists cartografia.hidrografia_area (
    id serial primary key,
    tipo varchar (50) null,
    nome varchar (50) null,
    data date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.hidrografia_area;

create index if not exists hidrografia_area_geometry_idx on cartografia.hidrografia_area using GIST(geometry);