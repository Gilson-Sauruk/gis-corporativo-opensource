drop table if exists cadastro.dom_status_cadastro_1;

create table if not exists cadastro.dom_status_cadastro_1 (
    id smallint primary key,
    descricao varchar (20)
);

truncate table cadastro.dom_status_cadastro_1;

insert into cadastro.dom_status_cadastro_1 (id, descricao)
values
     (1, 'Não validado'),
     (2, 'Validado');