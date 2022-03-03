drop table if exists cadastro.rede_agua_bruta, cadastro.rede_agua_bruta_anexos;

create table if not exists cadastro.rede_agua_bruta (
    id serial primary key,
    id_diam_mat numeric (10, 0) not null,
    data_inst date null,
    id_status_cad smallint null,
    id_status_op smallint not null,
    enabled boolean null default True,
    comprimento_real numeric (38, 8) null,
    obs text null,
    id_tipo smallint null,
    cod_meridian varchar (50) null,
    inconsistente numeric (5, 0) null,
    oid_origen numeric (10, 0) null,
    diametro varchar (100) null,
    material varchar (100) null,
    num_ss varchar (50) null,
    data_inst_geo date null,
    id_rede numeric (10, 0) null,
    geometry geometry('MULTILINESTRING', 31984),
    constraint fk_dom_status_cadastro_rede_agua_bruta foreign key ("id_status_cad") references cadastro.dom_status_cadastro_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_rede_agua_bruta foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_rede_agua_bruta_rede_agua_bruta foreign key ("id_tipo") references cadastro.dom_tipos_rede_agua_bruta (id) match simple on update no action on delete no action
);

create table if not exists cadastro.rede_agua_bruta_anexos (
     id serial primary key,
     id_rede_agua_bruta integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_rede_agua_bruta_rede_agua_brutaanexos foreign key ("id_rede_agua_bruta") references cadastro.rede_agua_bruta (id) match simple on update no action on delete no action
);

truncate table cadastro.rede_agua_bruta, cadastro.rede_agua_bruta_anexos;

create index if not exists rede_agua_bruta_geometry_idx on cadastro.rede_agua_bruta using GIST(geometry);
create index if not exists id_rede_agua_bruta_anexo_idx on cadastro.rede_agua_bruta_anexos(id_rede_agua_bruta);
