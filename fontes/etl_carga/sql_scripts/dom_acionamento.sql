create table if not exists cadastro.dom_acionamento (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_acionamento;

insert into cadastro.dom_acionamento (id, descricao)
values
    (1, 'Ativo'),
    (2, 'Inativo')