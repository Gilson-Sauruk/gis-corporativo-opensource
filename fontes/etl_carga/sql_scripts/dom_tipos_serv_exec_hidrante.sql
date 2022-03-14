drop table if exists cadastro.dom_tipos_serv_exec_hidrante;

create table if not exists cadastro.dom_tipos_serv_exec_hidrante (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cadastro.dom_tipos_serv_exec_hidrante;

insert into cadastro.dom_tipos_serv_exec_hidrante (id, descricao)
values
     (1, 'Vistoria'),
     (2, 'Manutenção'),
     (3, 'Última Inspeção Bombeiros');