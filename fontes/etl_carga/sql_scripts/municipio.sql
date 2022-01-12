drop table if exists cartografia.municipio;
create table if not exists cartografia.municipio (
	id bigserial primary key,
	nome varchar(30) not null,
	area_ibge numeric(38,8) null,
	data_criac date null,
	populacao bigint null,
	data date null,
	codigo_sicat int null,
	codigo_divisao int null,
	codigo_sap int null,
	tipo_servico varchar(30),
	cod_uf  int null,
	codigo_ibge int null,
	ano_ref date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.municipio;

create index if not exists nome_idx on cartografia.municipio(nome);
create index if not exists municipio_geometry_idx on cartografia.municipio using GIST (geometry);
