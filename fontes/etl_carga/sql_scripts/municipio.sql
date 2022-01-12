drop table if exists cartografia.municipio;

create table if not exists cartografia.municipio (
    id bigserial primary key,
    nome varchar (30) null ,
    area_ibge numeric (38, 8) null ,
    data_criac date null ,
    populacao numeric (10, 0) null ,
    data date null ,
    codigo_sicat numeric (10, 0) null ,
    codigo_divisao numeric (10, 0) null ,
    codigo_sap numeric (10, 0) null ,
    tipo_servico varchar (30) null ,
    cod_uf numeric (38, 8) null ,
    codigo_ibge numeric (10, 0) null ,
    ano_ref date null ,
    geometry geometry('POLYGON', 31984)
);

truncate table cartografia.municipio;

create index if not exists municipio_geometry_idx on cartografia.municipio using GIST(geometry);