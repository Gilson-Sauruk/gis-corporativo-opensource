drop table if exists cadastro.dom_status_operacao_hidrante;

create table if not exists cadastro.dom_status_operacao_hidrante (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cadastro.dom_status_operacao_hidrante;

insert into cadastro.dom_status_operacao_hidrante (id, descricao)
values
     (1, 'Em operação'),
     (2, 'Em projeto'),
     (3, 'Desativado'),
     (4, 'Não interligado a rede'),
     (5, 'Inoperante');