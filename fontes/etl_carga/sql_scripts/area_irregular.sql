drop table if exists cartografia.area_irregular;

create table if not exists cartografia.area_irregular (
    id serial primary key,
    dtinclusao date null,
    dtatualizacao date null,
    usuario varchar (50) null,
    id_tipo smallint null,
    nome varchar (100) not null,
    descricao varchar (200) null,
    id_registro smallint null,
    codigo varchar (20) null,
    geometry geometry('MULTIPOLYGON', 31984),
    constraint fk_dom_tipo_poligono_auxiliar_1_area_irregular foreign key ("id_tipo") references cartografia.dom_tipo_poligono_auxiliar_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_status_registro_area_irregular_area_irregular foreign key ("id_registro") references cartografia.dom_status_registro_area_irregular (id) match simple on update no action on delete no action
);

truncate table cartografia.area_irregular;

create index if not exists area_irregular_geometry_idx on cartografia.area_irregular using GIST(geometry);