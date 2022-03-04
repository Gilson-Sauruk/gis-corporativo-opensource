drop table if exists cadastro.eta, cadastro.eta_anexos;

create table if not exists cadastro.eta (
    id serial primary key,
    nome varchar (50) not null,
    id_tipo_tratamento smallint null,
    cod_progen varchar (40) null,
    cod_meridian varchar (50) null,
    cod_sap numeric (10, 0) null,
    cod_unilims numeric (10, 0) null,
    telemetria boolean null,
    data_inst date null,
    id_status_op smallint not null,
    capacidade numeric (38, 8) null,
    tag varchar (50) null,
    obs text null,
    oid_origen numeric (10, 0) null,
    cod_simp varchar (20) null,
    num_ss varchar (50) null,
    cod_sincop varchar (5) null,
    cod_unificado varchar (15) null,
    dt_atualizacao date null,
    dt_inclusao date null,
    dt_desativacao date null,
    dt_inicio_operacao date null,
    usuario_ult_interacao varchar (50) null,
    num_instalacao numeric (10, 0) null,
    id_acionamento smallint null,
    endereco varchar (250) null,
    id_status_cad smallint null,
    geometry geometry('MULTIPOLYGON', 31984),
    constraint fk_dom_tipos_tratamento_agua_eta foreign key ("id_tipo_tratamento") references cadastro.dom_tipos_tratamento_agua (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_eta foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_status_acionamento_uo_eta foreign key ("id_acionamento") references cadastro.dom_status_acionamento_uo (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_eta foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action
);

create table if not exists cadastro.eta_anexos (
     id serial primary key,
     id_eta integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_eta_etaanexos foreign key ("id_eta") references cadastro.eta (id) match simple on update no action on delete no action
);

truncate table cadastro.eta, cadastro.eta_anexos;

create index if not exists eta_geometry_idx on cadastro.eta using GIST(geometry);
create index if not exists id_eta_anexo_idx on cadastro.eta_anexos(id_eta);