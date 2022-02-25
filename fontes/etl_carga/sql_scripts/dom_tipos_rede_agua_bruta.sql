drop table if exists cadastro.dom_tipos_rede_agua_bruta;

create table if not exists cadastro.dom_tipos_rede_agua_bruta (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_tipos_rede_agua_bruta;

insert into cadastro.dom_tipos_rede_agua_bruta (id, descricao)
values
     (1, 'Por Gravidade'),
     (2, 'Recalque'),
     (3, 'Mista');