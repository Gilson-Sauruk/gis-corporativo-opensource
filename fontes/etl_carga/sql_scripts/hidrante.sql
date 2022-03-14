drop table if exists cadastro.hidrante, cadastro.hidrante_anexos;

create table if not exists cadastro.hidrante (
    id serial primary key,
    id_tipo smallint null,
    id_status_elev smallint null,
    data_inst date null,
    id_status_cad smallint null,
    id_status_op smallint null,
    enabled boolean null default True,
    elevacao numeric (38, 8) null,
    angulo numeric (38, 8) null,
    obs text null,
    cod_meridian varchar (50) null,
    data_manutencao date null,
    id_status_funcionamento smallint null,
    oid_origen numeric (10, 0) null,
    id_hidrante varchar (9) null,
    num_cbmes varchar (50) null,
    mat_ref varchar (10) null,
    hd_ref varchar (20) null,
    ss_instalacao varchar (20) null,
    processo varchar (20) null,
    id_origem smallint null,
    id_classe_hidrante smallint null,
    id_cor_hidrante smallint null,
    id_cd_municipio smallint null,
    cd_localidade numeric (5, 0) null,
    cd_bairro numeric (5, 0) null,
    cd_logradouro numeric (5, 0) null,
    id_servico_exec smallint null,
    dt_atualizacao date null,
    dt_inclusao date null,
    usuario_ult_interacao varchar (50) null,
    geometry geometry('POINT', 31984),
    constraint fk_dom_tipos_hidrante_hidrante foreign key ("id_tipo") references cadastro.dom_tipos_hidrante (id) match simple on update no action on delete no action,
    constraint fk_dom_status_elevacao_1_hidrante foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_hidrante foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_hidrante_hidrante foreign key ("id_status_op") references cadastro.dom_status_operacao_hidrante (id) match simple on update no action on delete no action,
    constraint fk_dom_status_funcionamento_hidrante foreign key ("id_status_funcionamento") references cadastro.dom_status_funcionamento (id) match simple on update no action on delete no action,
    constraint fk_dom_origem_hidrante_hidrante foreign key ("id_origem") references cadastro.dom_origem_hidrante (id) match simple on update no action on delete no action,
    constraint fk_dom_classe_hidrante_hidrante foreign key ("id_classe_hidrante") references cadastro.dom_classe_hidrante (id) match simple on update no action on delete no action,
    constraint fk_dom_cor_hidrante_hidrante foreign key ("id_cor_hidrante") references cadastro.dom_cor_hidrante (id) match simple on update no action on delete no action,
    constraint fk_dom_municipios_hidrante foreign key ("id_cd_municipio") references cadastro.dom_municipios (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_serv_exec_hidrante_hidrante foreign key ("id_servico_exec") references cadastro.dom_tipos_serv_exec_hidrante (id) match simple on update no action on delete no action
);

create table if not exists cadastro.hidrante_anexos (
     id serial primary key,
     id_hidrante integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_hidrante_hidranteanexos foreign key ("id_hidrante") references cadastro.hidrante (id) match simple on update no action on delete no action
);

truncate table cadastro.hidrante, cadastro.hidrante_anexos;

create index if not exists hidrante_geometry_idx on cadastro.hidrante using GIST(geometry);
create index if not exists id_hidrante_anexo_idx on cadastro.hidrante_anexos(id_hidrante);