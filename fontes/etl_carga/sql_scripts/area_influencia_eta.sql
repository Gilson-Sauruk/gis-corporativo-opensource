drop table if exists cadastro.area_influencia_eta, cadastro.area_influencia_eta_anexos;

create table if not exists cadastro.area_influencia_eta (
    id serial primary key,
    nome varchar (50) not null,
    populacao numeric (10, 0) null,
    obs text null,
    oid_origen numeric (10, 0) null,
    dtatualizacao date null,
    dtinclusao date null,
    usuario varchar (100) null,
    num_ss varchar (50) null,
    geometry geometry('MULTIPOLYGON', 31984)
);

create table if not exists cadastro.area_influencia_eta_anexos (
     id serial primary key,
     id_area_influencia_eta integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_area_influencia_eta_area_influencia_etaanexos foreign key ("id_area_influencia_eta") references cadastro.area_influencia_eta (id) match simple on update no action on delete no action
);

truncate table cadastro.area_influencia_eta, cadastro.area_influencia_eta_anexos;

create index if not exists area_influencia_eta_geometry_idx on cadastro.area_influencia_eta using GIST(geometry);
create index if not exists id_area_influencia_eta_anexo_idx on cadastro.area_influencia_eta_anexos(id_area_influencia_eta);