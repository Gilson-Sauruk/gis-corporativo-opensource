drop table if exists cadastro.macromedidor, cadastro.macromedidor_anexos;

create table if not exists cadastro.macromedidor (
    id serial primary key,
    cod_sap numeric (10, 0) null,
    id_status_elev smallint null,
    data_inst date null,
    id_status_cad smallint null,
    id_status_op smallint not null,
    enabled boolean null default True,
    elevacao numeric (38, 8) null,
    profundidade numeric (38, 8) null,
    angulo numeric (38, 8) null,
    obs text null,
    cod_meridian varchar (50) null,
    tag varchar (50) null,
    telemetria boolean null,
    oid_origen numeric (10, 0) null,
    cod_simp varchar (20) null,
    num_ss varchar (50) null,
    dt_atualizacao date null,
    dt_inclusao date null,
    usuario_ult_interacao varchar (50) null,
    num_instalacao numeric (10, 0) null,
    id_acionamento smallint null,
    geometry geometry('POINT', 31984),
    constraint fk_dom_status_elevacao_1_macromedidor foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_macromedidor foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_macromedidor foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_status_acionamento_uo_macromedidor foreign key ("id_acionamento") references cadastro.dom_status_acionamento_uo (id) match simple on update no action on delete no action
);

create table if not exists cadastro.macromedidor_anexos (
     id serial primary key,
     id_macromedidor integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_macromedidor_macromedidoranexos foreign key ("id_macromedidor") references cadastro.macromedidor (id) match simple on update no action on delete no action
);

truncate table cadastro.macromedidor, cadastro.macromedidor_anexos;

create index if not exists macromedidor_geometry_idx on cadastro.macromedidor using GIST(geometry);
create index if not exists id_macromedidor_anexo_idx on cadastro.macromedidor_anexos(id_macromedidor);