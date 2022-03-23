drop table if exists cadastro.bomba_agua, cadastro.bomba_agua_anexos;

create table if not exists cadastro.bomba_agua (
    id serial primary key,
    id_tipo smallint null,
    id_status_elev smallint null,
    data_inst date null,
    id_status_cad smallint null,
    id_status_op smallint null,
    cod_sap numeric (10, 0) null,
    cod_intouch numeric (10, 0) null,
    id_elevatoria numeric (10, 0) null,
    enabled boolean null default True,
    elevacao numeric (38, 8) null,
    profundidade numeric (38, 8) null,
    angulo numeric (38, 8) null,
    obs text null,
    tag varchar (50) null,
    id_classificacao smallint null,
    id_funcao smallint null,
    alturananometrica numeric (38, 8) null,
    cod_meridian varchar (50) null,
    oid_origen numeric (10, 0) null,
    cod_simp varchar (20) null,
    num_ss varchar (50) null,
    geometry geometry('POINT', 31984),
    constraint fk_dom_tipos_bombas_agua_1_bomba_agua foreign key ("id_tipo") references cadastro.dom_tipos_bombas_agua_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_elevacao_1_bomba_agua foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_bomba_agua foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_bomba_agua foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_classificacao_bomba_agua_bomba_agua foreign key ("id_classificacao") references cadastro.dom_classificacao_bomba_agua (id) match simple on update no action on delete no action,
    constraint fk_dom_funcao_bomba_agua foreign key ("id_funcao") references cadastro.dom_funcao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.bomba_agua_anexos (
     id serial primary key,
     id_bomba_agua integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_bomba_agua_bomba_aguaanexos foreign key ("id_bomba_agua") references cadastro.bomba_agua (id) match simple on update no action on delete no action
);

truncate table cadastro.bomba_agua, cadastro.bomba_agua_anexos;

create index if not exists bomba_agua_geometry_idx on cadastro.bomba_agua using GIST(geometry);
create index if not exists id_bomba_agua_anexo_idx on cadastro.bomba_agua_anexos(id_bomba_agua);