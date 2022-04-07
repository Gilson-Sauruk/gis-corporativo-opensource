drop table if exists cadastro.ponto_intervencao, cadastro.ponto_intervencao_anexos;

create table if not exists cadastro.ponto_intervencao (
    id serial primary key,
    enabled boolean null default True,
    profundidade numeric (38, 8) null,
    obs text null,
    rede_exposta boolean null,
    pavimentacao varchar (50) null,
    reincidencia boolean null,
    nome_rede varchar (50) null,
    id_rede varchar (50) null,
    oid_origen numeric (10, 0) null,
    geometry geometry('POINT', 31984)
);

create table if not exists cadastro.ponto_intervencao_anexos (
     id serial primary key,
     id_ponto_intervencao integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_ponto_intervencao_ponto_intervencaoanexos foreign key ("id_ponto_intervencao") references cadastro.ponto_intervencao (id) match simple on update no action on delete no action
);

truncate table cadastro.ponto_intervencao, cadastro.ponto_intervencao_anexos;

create index if not exists ponto_intervencao_geometry_idx on cadastro.ponto_intervencao using GIST(geometry);
create index if not exists id_ponto_intervencao_anexo_idx on cadastro.ponto_intervencao_anexos(id_ponto_intervencao);