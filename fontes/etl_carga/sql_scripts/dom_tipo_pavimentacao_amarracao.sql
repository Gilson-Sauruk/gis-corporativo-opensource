drop table if exists cadastro.dom_tipo_pavimentacao_amarracao;

create table if not exists cadastro.dom_tipo_pavimentacao_amarracao (
    id smallint primary key,
    descricao varchar (20)
);

truncate table cadastro.dom_tipo_pavimentacao_amarracao;

insert into cadastro.dom_tipo_pavimentacao_amarracao (id, descricao)
values
     (1, 'Asfalto'),
     (2, 'Bloket'),
     (3, 'Concreto'),
     (4, 'Pavi-S'),
     (5, 'Paralelepípedo'),
     (6, 'Pedra Decorativa'),
     (7, 'Sem Pavimentação'),
     (8, 'Outros'),
     (9, 'Não Informado');