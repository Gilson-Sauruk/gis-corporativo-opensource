drop table if exists cadastro.dom_status_funcionamento;

create table if not exists cadastro.dom_status_funcionamento (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_status_funcionamento;

insert into cadastro.dom_status_funcionamento (id, descricao)
values
     (1, 'Ativo'),
     (2, 'Inativo');