create table if not exists cartografia.bairro (
	id serial primary key,
	nome varchar(30) not null,
	codigo bigint null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cartografia.bairro;

create index if not exists nome_idx on cartografia.bairro(nome);
create index if not exists bairro_geometry_idx on cartografia.bairro using GIST (geometry);