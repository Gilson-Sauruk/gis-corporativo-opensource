drop table if exists cartografia.margem_sistema_viario;

create table if not exists cartografia.margem_sistema_viario (
    id serial primary key,
    descricao varchar (50) null,
    data date null,
    geometry geometry('MULTILINESTRING', 31984)
);

truncate table cartografia.margem_sistema_viario;

create index if not exists margem_sistema_viario_geometry_idx on cartografia.margem_sistema_viario using GIST(geometry);