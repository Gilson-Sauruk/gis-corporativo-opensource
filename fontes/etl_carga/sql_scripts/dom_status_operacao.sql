create table if not exists cadastro.dom_status_operacao (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_status_operacao;

insert into cadastro.dom_status_operacao (id, descricao)
values
    (1, 'Em operação'),
    (2, 'Em execução'),
    (3, 'Em projeto'),
    (4, 'Desativado'),
    (5, 'Inoperante'),
    (6, 'Sem demanda')