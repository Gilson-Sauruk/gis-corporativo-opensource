create table if not exists cadastro.dom_status_cadastro (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_status_cadastro;

insert into cadastro.dom_status_cadastro (id, descricao)
values
    (1, 'Validado'),
    (2, 'Não validado')