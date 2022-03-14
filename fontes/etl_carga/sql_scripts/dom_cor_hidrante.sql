drop table if exists cadastro.dom_cor_hidrante;

create table if not exists cadastro.dom_cor_hidrante (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_cor_hidrante;

insert into cadastro.dom_cor_hidrante (id, descricao)
values
     (1, 'Verde'),
     (2, 'Vermelho'),
     (3, 'Amarelo');