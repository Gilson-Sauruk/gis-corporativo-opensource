drop table if exists cartografia.quadra;

create table if not exists cartografia.quadra (
    id bigserial primary key,
    data date null ,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.quadra;

create index if not exists quadra_geometry_idx on cartografia.quadra using GIST(geometry);