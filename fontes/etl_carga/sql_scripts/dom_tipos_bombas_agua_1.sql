drop table if exists cadastro.dom_tipos_bombas_agua_1;

create table if not exists cadastro.dom_tipos_bombas_agua_1 (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_tipos_bombas_agua_1;

insert into cadastro.dom_tipos_bombas_agua_1 (id, descricao)
values
     (1, 'Centrífuga'),
     (2, 'Volumétrica');