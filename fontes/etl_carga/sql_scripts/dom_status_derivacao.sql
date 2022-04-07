drop table if exists cadastro.dom_status_derivacao;

create table if not exists cadastro.dom_status_derivacao (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_status_derivacao;

insert into cadastro.dom_status_derivacao (id, descricao)
values
     (1, 'Validado'),
     (2, 'Não validado'),
     (3, 'Não validado'),
     (4, 'Validado');