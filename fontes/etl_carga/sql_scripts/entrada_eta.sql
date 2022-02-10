drop table if exists cadastro.entrada_eta, cadastro.entrada_eta_anexos;

create table if not exists cadastro.entrada_eta (
    id serial primary key,
    id_status_elev smallint null,
    id_eta numeric (10, 0) not null,
    enabled boolean null default True,
    id_ancillaryrole smallint null,
    elevacao numeric (38, 8) null,
    profundidade numeric (38, 8) null,
    obs text null,
    oid_origen numeric (10, 0) null,
    num_ss varchar (50) null,
    geometry geometry('POINT', 31984),
    constraint fk_dom_status_elevacao_1_entrada_eta foreign key ("id_status_elev") references cadastro.dom_status_elevacao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_ancillaryroledomain_entrada_eta foreign key ("id_ancillaryrole") references cadastro.dom_ancillaryroledomain (id) match simple on update no action on delete no action
);

create table if not exists cadastro.entrada_eta_anexos (
     id serial primary key,
     id_entrada_eta integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_entrada_eta_entrada_etaanexos foreign key ("id_entrada_eta") references cadastro.entrada_eta (id) match simple on update no action on delete no action
);

truncate table cadastro.entrada_eta, cadastro.entrada_eta_anexos;

create index if not exists entrada_eta_geometry_idx on cadastro.entrada_eta using GIST(geometry);
create index if not exists id_entrada_eta_anexo_idx on cadastro.entrada_eta_anexos(id_entrada_eta);