drop table if exists cadastro.dom_status_acionamento_uo;

create table if not exists cadastro.dom_status_acionamento_uo (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_status_acionamento_uo;

insert into cadastro.dom_status_acionamento_uo (id, descricao)
values
     (1, 'Ativo'),
     (2, 'Inativo');