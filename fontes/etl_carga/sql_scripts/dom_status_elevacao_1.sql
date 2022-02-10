drop table if exists cadastro.dom_status_elevacao_1;

create table if not exists cadastro.dom_status_elevacao_1 (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_status_elevacao_1;

insert into cadastro.dom_status_elevacao_1 (id, descricao)
values
     (1, 'Aproximado'),
     (2, 'Sem Dado'),
     (3, 'Medido');