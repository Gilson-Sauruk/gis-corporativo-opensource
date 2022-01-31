drop table if exists cartografia.dom_tratamento_esgoto;

create table if not exists cartografia.dom_tratamento_esgoto (
    id smallint primary key,
    descricao varchar (5)
);

truncate table cartografia.dom_tratamento_esgoto;

insert into cartografia.dom_tratamento_esgoto (id, descricao)
values
     (1, 'NAO'),
     (2, 'SIM');