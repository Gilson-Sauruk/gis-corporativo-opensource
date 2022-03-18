drop table if exists cadastro.ramal_hidrante, cadastro.ramal_hidrante_anexos;

create table if not exists cadastro.ramal_hidrante (
    id serial primary key,
    id_diam_mat numeric (10, 0) null,
    id_status_cad smallint null,
    id_status_op smallint null,
    enabled boolean null default True,
    cod_meridian varchar (50) null,
    obs text null,
    oid_origen numeric (10, 0) null,
    num_ss varchar (50) null,
    geometry geometry('MULTILINESTRING', 31984),
    constraint fk_dom_status_cadastro_ramal_hidrante foreign key ("id_status_cad") references cadastro.dom_status_cadastro (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_ramal_hidrante foreign key ("id_status_op") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.ramal_hidrante_anexos (
     id serial primary key,
     id_ramal_hidrante integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_ramal_hidrante_ramal_hidranteanexos foreign key ("id_ramal_hidrante") references cadastro.ramal_hidrante (id) match simple on update no action on delete no action
);

truncate table cadastro.ramal_hidrante, cadastro.ramal_hidrante_anexos;

create index if not exists ramal_hidrante_geometry_idx on cadastro.ramal_hidrante using GIST(geometry);
create index if not exists id_ramal_hidrante_anexo_idx on cadastro.ramal_hidrante_anexos(id_ramal_hidrante);