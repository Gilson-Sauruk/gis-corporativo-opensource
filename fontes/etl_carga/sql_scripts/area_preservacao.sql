drop table if exists cartografia.area_preservacao;

create table if not exists cartografia.area_preservacao (
    id serial primary key,
    dtinclusao date null,
    dtatualizacao date null,
    usuario varchar (50) null,
    id_tipo smallint null,
    nome varchar (100) not null,
    descricao varchar (200) null,
    codigo varchar (20) null,
    geometry geometry('MULTIPOLYGON', 31984),
    constraint fk_dom_tipo_poligono_auxiliar_1_area_preservacao foreign key ("id_tipo") references cartografia.dom_tipo_poligono_auxiliar_1 (id) match simple on update no action on delete no action
);

truncate table cartografia.area_preservacao;

create index if not exists area_preservacao_geometry_idx on cartografia.area_preservacao using GIST(geometry);