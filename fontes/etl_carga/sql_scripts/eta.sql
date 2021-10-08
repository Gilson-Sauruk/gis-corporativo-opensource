create table if not exists cadastro.eta (
	id serial primary key,
	nome varchar(50) not null,
	id_tipo_tratamento smallint null,
    id_telemetria smallint null,
    id_status_operacao smallint not null,
    id_status_cadastro smallint null,
    id_status_elevacao smallint null,
    id_acionamento smallint null,
	cod_progen varchar(40) null,
	cod_meridian varchar(50) null,
	cod_sap int null,
	cod_unilims int null,
    cod_simp varchar(20) null,
    cod_sincop varchar(5) null,
	cod_unificado varchar(15) null,
	data_instalacao date null,
	capacidade numeric(38, 8) null,
	tag_sap varchar(50) null,
	obs text null,
	num_ss varchar(20) null,
	data_atualizacao date null,
	data_inclusao date null,
	data_desativacao date null,
	data_inicio_operacao date null,
	usuario_ultima_interacao varchar(50) null,
	numero_instalacao int null,
	endereco varchar(250) null,
    geometry geometry('MULTIPOLYGON', 31984)
);

create table if not exists cadastro.eta_anexos (
	id serial primary key,
	id_eta integer,
	anexo_nome varchar(250),
	anexo_dados bytea
);

truncate table cadastro.eta;
truncate table cadastro.eta_anexos;

create index if not exists nome_idx on cadastro.eta(nome);
create index if not exists id_eta_anexo_idx on cadastro.eta_anexos(id_eta);
create index if not exists eta_geometry_idx on cadastro.eta using GIST (geometry);

