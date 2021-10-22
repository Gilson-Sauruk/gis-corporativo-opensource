create table if not exists cadastro.area_influencia_eta (
	id serial primary key,
	nome varchar(50) not null,
	data_inclusao date null,
	data_atualizacao date null,
	obs text null,
	num_ss varchar(20) null,
	usuario_ultima_interacao varchar(100) null,
    geometry geometry('MULTIPOLYGON', 31984)
);

truncate table cadastro.area_influencia_eta;

create index if not exists nome_idx on cadastro.area_influencia_eta(nome);
create index if not exists area_influencia_eta_geometry_idx on cadastro.area_influencia_eta using GIST (geometry);