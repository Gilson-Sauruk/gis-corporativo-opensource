drop table if exists cartografia.marco;

create table if not exists cartografia.marco (
    id serial primary key,
    elevacao numeric (38, 8) null,
    tipo_elem varchar (50) null,
    nome varchar (20) null,
    data_impl date null,
    data date null,
    geometry geometry('POINTZM', 31984)
);

truncate table cartografia.marco;

create index if not exists marco_geometry_idx on cartografia.marco using GIST(geometry);