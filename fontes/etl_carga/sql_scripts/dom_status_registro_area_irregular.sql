drop table if exists cartografia.dom_status_registro_area_irregular;

create table if not exists cartografia.dom_status_registro_area_irregular (
    id smallint primary key,
    descricao varchar (25)
);

truncate table cartografia.dom_status_registro_area_irregular;

insert into cartografia.dom_status_registro_area_irregular (id, descricao)
values
     (1, 'Sem Registro Municipal'),
     (2, 'Sem Registro CESAN'),
     (3, 'Restrição Judicial'),
     (4, 'Regularizado CESAN');