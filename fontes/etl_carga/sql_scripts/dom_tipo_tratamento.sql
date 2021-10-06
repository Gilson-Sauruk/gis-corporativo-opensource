create table if not exists cadastro.dom_tipo_tratamento (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_tipo_tratamento;

insert into cadastro.dom_tipo_tratamento (id, descricao)
values
    (1, 'Convencional'),
    (2, 'Filtração direta'),
    (3, 'Flotação')