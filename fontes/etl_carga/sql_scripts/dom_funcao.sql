drop table if exists cadastro.dom_funcao;

create table if not exists cadastro.dom_funcao (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_funcao;

insert into cadastro.dom_funcao (id, descricao)
values
     (1, 'Booster'),
     (2, 'Elevatória');