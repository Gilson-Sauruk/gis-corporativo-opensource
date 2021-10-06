create table if not exists cadastro.dom_status_elevacao (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_status_elevacao;

insert into cadastro.dom_status_elevacao (id, descricao)
values
    (1, 'Medido'),
    (2, 'Aproximado'),
    (3, 'Sem dado')