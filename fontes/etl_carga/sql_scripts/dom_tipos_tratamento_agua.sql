drop table if exists cadastro.dom_tipos_tratamento_agua;

create table if not exists cadastro.dom_tipos_tratamento_agua (
    id smallint primary key,
    descricao varchar (20)
);

truncate table cadastro.dom_tipos_tratamento_agua;

insert into cadastro.dom_tipos_tratamento_agua (id, descricao)
values
     (1, 'Convencional'),
     (2, 'Filtração direta'),
     (3, 'Flotação');