drop table if exists cadastro.dom_intrumento;

create table if not exists cadastro.dom_intrumento (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_intrumento;

insert into cadastro.dom_intrumento (id, descricao)
values
     (1, 'Outros'),
     (2, 'Trena'),
     (3, 'GPS');