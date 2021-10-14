create table if not exists cadastro.ligacao_cliente (
	id serial primary key,
	matricula int not null,
	data_instalacao date null,
	hidrometro varchar(15) null,
	ciclo_sicat smallint null,
	id_situacao_agua smallint null,
	id_situacao_esgoto smallint null,
	observacoes text null, 
	geometry geometry('POINT', 31984)
);

create table if not exists cadastro.ligacao_cliente_anexos (
	id serial primary key,
	id_ligacao_cliente integer,
	anexo_nome varchar(250),
	anexo_dados bytea
);

truncate table cadastro.ligacao_cliente;
truncate table cadastro.eta_anexos;

create index if not exists matricula_idx on cadastro.ligacao_cliente(matricula);
create index if not exists id_ligacao_cliente_anexo_idx on cadastro.ligacao_cliente_anexos(id_ligacao_cliente);
create index if not exists ligacao_cliente_geometry_idx on cadastro.ligacao_cliente using GIST (geometry);
