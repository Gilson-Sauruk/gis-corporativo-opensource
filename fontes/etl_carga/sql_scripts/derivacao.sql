drop table if exists cadastro.derivacao, cadastro.derivacao_anexos;

create table if not exists cadastro.derivacao (
    id serial primary key,
    id_diam_mat numeric (10, 0) not null,
    id_status smallint not null,
    enabled boolean null default True,
    obs text null,
    oid_origen numeric (10, 0) null,
    usuario varchar (100) null,
    dt_criacao date null,
    matricula numeric (10, 0) null,
    excluida varchar (1) null,
    geometry geometry('MULTILINESTRING', 31984),
    constraint fk_dom_status_derivacao_derivacao foreign key ("id_status") references cadastro.dom_status_derivacao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.derivacao_anexos (
     id serial primary key,
     id_derivacao integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_derivacao_derivacaoanexos foreign key ("id_derivacao") references cadastro.derivacao (id) match simple on update no action on delete no action
);

truncate table cadastro.derivacao, cadastro.derivacao_anexos;

create index if not exists derivacao_geometry_idx on cadastro.derivacao using GIST(geometry);
create index if not exists id_derivacao_anexo_idx on cadastro.derivacao_anexos(id_derivacao);