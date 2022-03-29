drop table if exists cadastro.medidor_pressao, cadastro.medidor_pressao_anexos;

create table if not exists cadastro.medidor_pressao (
    id serial primary key,
    cod_sap numeric (10, 0) null,
    id_status_elev smallint null,
    id_status_medidor smallint not null,
    data_inst date null,
    id_status_cad smallint not null,
    id_status_op smallint not null,
    enabled boolean null default True,
    elevacao numeric (38, 8) null,
    profundidade numeric (38, 8) null,
    angulo numeric (38, 8) null,
    obs text null,
    cod_meridian varchar (50) null,
    tag varchar (50) null,
    oid_origen numeric (10, 0) null,
    cod_simp varchar (20) null,
    num_ss varchar (50) null,
    geometry geometry('POINT', 31984),
    constraint fk_dom_status_elevacao_1_medidor_pressao foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_medidor_medidor_pressao foreign key ("id_status_medidor") references cadastro.dom_status_medidor (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_medidor_pressao foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_medidor_pressao foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.medidor_pressao_anexos (
     id serial primary key,
     id_medidor_pressao integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_medidor_pressao_medidor_pressaoanexos foreign key ("id_medidor_pressao") references cadastro.medidor_pressao (id) match simple on update no action on delete no action
);

truncate table cadastro.medidor_pressao, cadastro.medidor_pressao_anexos;

create index if not exists medidor_pressao_geometry_idx on cadastro.medidor_pressao using GIST(geometry);
create index if not exists id_medidor_pressao_anexo_idx on cadastro.medidor_pressao_anexos(id_medidor_pressao);