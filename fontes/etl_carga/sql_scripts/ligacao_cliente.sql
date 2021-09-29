create table if not exists cadastro.ligacao_cliente (
	id serial primary key,
	matricula int not null,
	data_instalacao date null,
	hidrometro varchar(15) not null,
	ciclo_sicat smallint not null,
	id_situacao_agua smallint not null,
	id_situacao_esgoto smallint not null,
	observacoes text null, 
	geometry geometry('POINT', 31984)
);

create table if not exists cadastro.dom_situacao_agua (
	id smallint primary key,
	descricao varchar(50)
);

create table if not exists cadastro.dom_situacao_esgoto (
	id smallint primary key,
	descricao varchar(50)
);

insert into cadastro.dom_situacao_agua 
	(id, descricao)
values 
	(1,'Ativa'),
	(2,'Cortada'),
	(3,'Inativa'),
	(4,'Potencial'),
	(5,'Pedido Ligação'),
	(6,'Clandestino'),
	(7,'Factível'),
	(8,'Extensão de Rede'),
	(9,'Excluída');

insert into cadastro.dom_situacao_esgoto 
	(id, descricao) 
values 
	(1,'Ativa'),
	(2,'Água Supr./Cort.'),
	(3,'Inativa'),
	(4,'Potencial'),
	(5,'Pedido Ligação'),
	(6,'Factível'),
	(7,'Factível ANR'),
	(8,'Factível ANR-E'),
	(9,'Excluída'),
	(10,'Sistema Próprio'),
	(11,'Não Gera Esgoto'),
	(12,'Factível sem PI'),
	(13,'Unidade da CESAN'),
	(14,'Factível com PI'),
	(15,'Factível ANR com PI'),
	(16,'Factível ANR-E com PI'),
	(17,'Factível sem PI - CSSA');

create index if not exists matricula_idx on cadastro.ligacao_cliente(matricula);
create index if not exists ligacao_cliente_geometry_idx on cadastro.ligacao_cliente using GIST (geometry);
