drop table if exists cadastro.dom_tipos_origem_rede_agua_esgoto;

create table if not exists cadastro.dom_tipos_origem_rede_agua_esgoto (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cadastro.dom_tipos_origem_rede_agua_esgoto;

insert into cadastro.dom_tipos_origem_rede_agua_esgoto (id, descricao)
values
     (1, 'Empreendimento'),
     (2, 'Contrato'),
     (3, 'Pesquisa de Vazamento'),
     (4, 'Ligação Água-Esgoto'),
     (5, 'Ponto Intervenção'),
     (6, 'Outras Fontes'),
     (7, 'Melhorias Operacionais'),
     (8, 'Ligação Clandestina'),
     (9, 'Obras'),
     (10, 'Plantão'),
     (11, 'Amarração'),
     (12, 'Equipamento'),
     (13, 'Crescimento Vegetativo');