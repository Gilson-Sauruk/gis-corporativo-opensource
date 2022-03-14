drop table if exists cadastro.dom_origem_hidrante;

create table if not exists cadastro.dom_origem_hidrante (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cadastro.dom_origem_hidrante;

insert into cadastro.dom_origem_hidrante (id, descricao)
values
     (1, 'Crescimento Vegetativo'),
     (2, 'Empreendimento'),
     (3, 'Outro');