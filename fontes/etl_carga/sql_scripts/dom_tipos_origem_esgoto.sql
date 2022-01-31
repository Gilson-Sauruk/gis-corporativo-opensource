drop table if exists cartografia.dom_tipos_origem_esgoto;

create table if not exists cartografia.dom_tipos_origem_esgoto (
    id smallint primary key,
    descricao varchar (30)
);

truncate table cartografia.dom_tipos_origem_esgoto;

insert into cartografia.dom_tipos_origem_esgoto (id, descricao)
values
     (1, 'Sistema Único'),
     (2, 'Sistema Separador Absoluto');