drop table if exists cadastro.dom_tipos_prof_amarracao;

create table if not exists cadastro.dom_tipos_prof_amarracao (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_tipos_prof_amarracao;

insert into cadastro.dom_tipos_prof_amarracao (id, descricao)
values
     (1, 'Exposta'),
     (2, 'Aérea');