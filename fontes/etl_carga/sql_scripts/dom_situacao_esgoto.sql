create table if not exists cadastro.dom_situacao_esgoto (
	id smallint primary key,
	descricao varchar(50)
);

truncate table cadastro.dom_situacao_esgoto;