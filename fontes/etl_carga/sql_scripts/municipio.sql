create table if not exists cartografia.municipio (
	id serial primary key,
	nome varchar(30) not null,
	area_ibge numeric(38,8) null,
	data_criacao date null,
	populacao bigint null,
	codigo_sicat int null,
	codigo_ibge int null,
	data_referencia date null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.municipio;

create index if not exists nome_idx on cartografia.municipio(nome);
create index if not exists municipio_geometry_idx on cartografia.municipio using GIST (geometry);