drop table if exists cadastro.dom_classificacao_bomba_agua;

create table if not exists cadastro.dom_classificacao_bomba_agua (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_classificacao_bomba_agua;

insert into cadastro.dom_classificacao_bomba_agua (id, descricao)
values
     (1, 'Fluxo Axial'),
     (2, 'Fluxo Radial'),
     (3, 'Fluxo Misto');