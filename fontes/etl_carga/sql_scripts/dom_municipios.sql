drop table if exists cadastro.dom_municipios;

create table if not exists cadastro.dom_municipios (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cadastro.dom_municipios;

insert into cadastro.dom_municipios (id, descricao)
values
     (1, 'SANTA TERESA'),
     (2, 'VIANA'),
     (3, 'PINHEIROS'),
     (4, 'VILA VELHA'),
     (5, 'VENDA NOVA DO IMIGRANTE'),
     (6, 'IUNA'),
     (7, 'CARIACICA'),
     (8, 'PANCAS'),
     (9, 'CONCEICAO DO CASTELO'),
     (10, 'CONCEICAO DA BARRA'),
     (11, 'MUQUI'),
     (12, 'VILA PAVAO'),
     (13, 'ARACRUZ'),
     (14, 'AFONSO CLAUDIO'),
     (15, 'PIUMA'),
     (16, 'SERRA'),
     (17, 'BARRA DE SAO FRANCISCO'),
     (18, 'DORES DO RIO PRETO'),
     (19, 'APIACA'),
     (20, 'AGUIA BRANCA'),
     (21, 'DOMINGOS MARTINS'),
     (22, 'SAO JOSE DO CALCADO'),
     (23, 'MONTANHA'),
     (24, 'NOVA VENECIA'),
     (25, 'VITORIA'),
     (26, 'IBATIBA'),
     (27, 'FUNDAO'),
     (28, 'BOA ESPERANCA'),
     (29, 'DIVINO DE SAO LOURENCO'),
     (30, 'ATILIO VIVACQUA'),
     (31, 'SAO GABRIEL DA PALHA'),
     (32, 'ANCHIETA'),
     (33, 'ALTO RIO NOVO'),
     (34, 'PEDRO CANARIO'),
     (35, 'BOM JESUS DO NORTE'),
     (36, 'SANTA LEOPOLDINA'),
     (37, 'GUARAPARI'),
     (38, 'PRESIDENTE KENNEDY'),
     (39, 'LARANJA DA TERRA'),
     (40, 'ECOPORANGA'),
     (41, 'RIO NOVO DO SUL'),
     (42, 'MUNIZ FREIRE'),
     (43, 'CASTELO'),
     (44, 'MUCURICI'),
     (45, 'MANTENOPOLIS'),
     (46, 'AGUA DOCE DO NORTE'),
     (47, 'SANTA MARIA DE JETIBA');