drop table if exists cartografia.dom_tipo_poligono_auxiliar_1;

create table if not exists cartografia.dom_tipo_poligono_auxiliar_1 (
    id smallint primary key,
    descricao varchar (20)
);

truncate table cartografia.dom_tipo_poligono_auxiliar_1;

insert into cartografia.dom_tipo_poligono_auxiliar_1 (id, descricao)
values
     (1, 'Áreas Irregulares'),
     (2, 'Área de Proteção'),
     (3, 'Polígonos Outros'),
     (4, 'Polígono de Esgoto');