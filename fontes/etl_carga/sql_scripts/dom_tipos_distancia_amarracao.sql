drop table if exists cadastro.dom_tipos_distancia_amarracao;

create table if not exists cadastro.dom_tipos_distancia_amarracao (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_tipos_distancia_amarracao;

insert into cadastro.dom_tipos_distancia_amarracao (id, descricao)
values
     (1, 'Edificação'),
     (2, 'Meio Fio'),
     (3, 'Quadra'),
     (4, 'Poste'),
     (5, 'Calçada');