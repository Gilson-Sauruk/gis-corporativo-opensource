drop table if exists cadastro.dom_tipos_hidrante;

create table if not exists cadastro.dom_tipos_hidrante (
    id smallint primary key,
    descricao varchar (15)
);

truncate table cadastro.dom_tipos_hidrante;

insert into cadastro.dom_tipos_hidrante (id, descricao)
values
     (1, 'De coluna'),
     (2, 'Subterrâneo');