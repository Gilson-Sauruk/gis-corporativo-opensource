drop table if exists cadastro.rede_agua_tratada, cadastro.rede_agua_tratada_anexos;

create table if not exists cadastro.rede_agua_tratada (
    id serial primary key,
    id_diam_mat numeric (10, 0) null,
    data_inst date null,
    id_status_cad smallint not null,
    id_status_op smallint not null,
    enabled boolean null default True,
    comprimento_real numeric (38, 8) null,
    obs text null,
    cod_meridian varchar (50) null,
    inconsistente numeric (5, 0) null,
    oid_origen numeric (10, 0) null,
    diametro varchar (100) null,
    material varchar (100) null,
    ss_instalacao varchar (30) null,
    processo varchar (50) null,
    id_contrato numeric (10, 0) null,
    id_medicao numeric (10, 0) null,
    id_tipos_origem smallint null,
    data_inst_geo date null,
    id_rede numeric (10, 0) null,
    geometry geometry('MULTILINESTRING', 31984),
    constraint fk_dom_status_cadastro_rede_agua_tratada foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_rede_agua_tratada foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_origem_rede_agua_esgoto_rede_agua_tratada foreign key ("id_tipos_origem") references cadastro.dom_tipos_origem_rede_agua_esgoto (id) match simple on update no action on delete no action
);

create table if not exists cadastro.rede_agua_tratada_anexos (
     id serial primary key,
     id_rede_agua_tratada integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_rede_agua_tratada_rede_agua_tratadaanexos foreign key ("id_rede_agua_tratada") references cadastro.rede_agua_tratada (id) match simple on update no action on delete no action
);

truncate table cadastro.rede_agua_tratada, cadastro.rede_agua_tratada_anexos;

create index if not exists rede_agua_tratada_geometry_idx on cadastro.rede_agua_tratada using GIST(geometry);
create index if not exists id_rede_agua_tratada_anexo_idx on cadastro.rede_agua_tratada_anexos(id_rede_agua_tratada);