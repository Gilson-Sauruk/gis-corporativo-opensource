drop table if exists cadastro.dom_classe_hidrante;

create table if not exists cadastro.dom_classe_hidrante (
    id smallint primary key,
    descricao varchar (35)
);

truncate table cadastro.dom_classe_hidrante;

insert into cadastro.dom_classe_hidrante (id, descricao)
values
     (1, 'A - Vazão acima de 2.000 l/min'),
     (2, 'C - Vazão de 360 até 1.000 l/min'),
     (3, 'B - Vazão entre 1.000 e 2.000 l/min');