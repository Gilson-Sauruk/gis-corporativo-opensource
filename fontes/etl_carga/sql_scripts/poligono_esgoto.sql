drop table if exists cartografia.poligono_esgoto;

create table if not exists cartografia.poligono_esgoto (
    id serial primary key,
    dtinclusao date null,
    dtatualizacao date null,
    usuario varchar (50) null,
    id_tipo smallint null,
    nome varchar (100) not null,
    descricao varchar (200) null,
    id_tratesgoto smallint null,
    id_origem smallint null,
    geometry geometry('MULTIPOLYGON', 31984),
    constraint fk_dom_tipo_poligono_auxiliar_1_poligono_esgoto foreign key ("id_tipo") references cartografia.dom_tipo_poligono_auxiliar_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_tratamento_esgoto_poligono_esgoto foreign key ("id_tratesgoto") references cartografia.dom_tratamento_esgoto (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_origem_esgoto_poligono_esgoto foreign key ("id_origem") references cartografia.dom_tipos_origem_esgoto (id) match simple on update no action on delete no action
);

truncate table cartografia.poligono_esgoto;

create index if not exists poligono_esgoto_geometry_idx on cartografia.poligono_esgoto using GIST(geometry);