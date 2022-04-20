drop table if exists cadastro.cap, cadastro.cap_anexos;

create table if not exists cadastro.cap (
    id serial primary key,
    id_status_elev smallint null,
    data_inst date null,
    id_status_cad smallint not null,
    id_status_op smallint not null,
    id_diam_mat numeric (10, 0) not null,
    enabled boolean null default True,
    elevacao numeric (38, 8) null,
    profundidade numeric (38, 8) null,
    angulo numeric (38, 8) null,
    obs text null,
    cod_meridian varchar (50) null,
    oid_origen numeric (10, 0) null,
    num_ss varchar (50) null,
    geometry geometry('POINTZM', 31984),
    constraint fk_dom_status_elevacao_1_cap foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_cadastro_cap foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_cap foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.cap_anexos (
     id serial primary key,
     id_cap integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_cap_capanexos foreign key ("id_cap") references cadastro.cap (id) match simple on update no action on delete no action
);

truncate table cadastro.cap, cadastro.cap_anexos;

create index if not exists cap_geometry_idx on cadastro.cap using GIST(geometry);
create index if not exists id_cap_anexo_idx on cadastro.cap_anexos(id_cap);