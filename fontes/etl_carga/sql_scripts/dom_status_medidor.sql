drop table if exists cadastro.dom_status_medidor;

create table if not exists cadastro.dom_status_medidor (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_status_medidor;

insert into cadastro.dom_status_medidor (id, descricao)
values
     (1, 'Temporário'),
     (2, 'Fixo');