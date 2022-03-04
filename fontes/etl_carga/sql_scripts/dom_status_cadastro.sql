drop table if exists cadastro.dom_status_cadastro;

create table if not exists cadastro.dom_status_cadastro (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_status_cadastro;

insert into cadastro.dom_status_cadastro (id, descricao)
values
     (1, 'Não validado'),
     (2, 'Validado');