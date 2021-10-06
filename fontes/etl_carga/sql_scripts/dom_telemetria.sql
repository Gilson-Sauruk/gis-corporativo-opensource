create table if not exists cadastro.dom_telemetria (
	id smallint primary key,
	descricao varchar(20)
);

truncate table cadastro.dom_telemetria;

insert into cadastro.dom_telemetria (id, descricao)
values
    (1, 'Sim'),
    (2, 'Não')