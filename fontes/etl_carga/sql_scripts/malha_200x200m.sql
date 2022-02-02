drop table if exists cartografia.malha_200x200m;

create table if not exists cartografia.malha_200x200m (
    id serial primary key,
    coord_e numeric (10, 0) null,
    coord_n numeric (10, 0) null,
    data date null,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.malha_200x200m;

create index if not exists malha_200x200m_geometry_idx on cartografia.malha_200x200m using GIST(geometry);