drop table if exists cadastro.dom_ancillaryroledomain;

create table if not exists cadastro.dom_ancillaryroledomain (
    id smallint primary key,
    descricao varchar (10)
);

truncate table cadastro.dom_ancillaryroledomain;

insert into cadastro.dom_ancillaryroledomain (id, descricao)
values
     (1, 'None'),
     (2, 'Source'),
     (3, 'Sink');