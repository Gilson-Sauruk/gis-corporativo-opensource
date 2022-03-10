drop table if exists cadastro.amarracao_agua, cadastro.amarracao_agua_anexos;

create table if not exists cadastro.amarracao_agua (
    id serial primary key,
    dimlength numeric (38, 8) not null,
    beginx numeric (38, 8) null,
    beginy numeric (38, 8) null,
    endx numeric (38, 8) null,
    endy numeric (38, 8) null,
    dimx numeric (38, 8) null,
    dimy numeric (38, 8) null,
    textx numeric (38, 8) null,
    texty numeric (38, 8) null,
    dimtype numeric (38, 8) null,
    extangle numeric (38, 8) null,
    styleid numeric (10, 0) null,
    usecustomlength numeric (5, 0) not null,
    customlength numeric (38, 8) not null,
    dimdisplay numeric (5, 0) null,
    extdisplay numeric (5, 0) null,
    markerdisplay numeric (5, 0) null,
    textangle numeric (38, 8) null,
    id_origem smallint null,
    obs text null,
    id_instrumento smallint null,
    data_origem date null,
    id_descrip_prof smallint null,
    id_descrip_distancia smallint null,
    profundidade numeric (38, 8) null,
    codigo varchar (40) null,
    inconsistente numeric (5, 0) null,
    oid_origen numeric (10, 0) null,
    num_ss varchar (50) null,
    id_status_operacao smallint null,
    id_pavimentacao smallint null,
    geometry geometry('MULTIPOLYGON', 31984),
    constraint fk_dom_tipos_origem_amarracao_1_amarracao_agua foreign key ("id_origem") references cadastro.dom_tipos_origem_amarracao_1 (id) match simple on update no action on delete no action,
    constraint fk_dom_intrumento_amarracao_agua foreign key ("id_instrumento") references cadastro.dom_intrumento (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_prof_amarracao_amarracao_agua foreign key ("id_descrip_prof") references cadastro.dom_tipos_prof_amarracao (id) match simple on update no action on delete no action,
    constraint fk_dom_tipos_distancia_amarracao_amarracao_agua foreign key ("id_descrip_distancia") references cadastro.dom_tipos_distancia_amarracao (id) match simple on update no action on delete no action,
    constraint fk_dom_status_operacao_amarracao_agua foreign key ("id_status_operacao") references cadastro.dom_status_operacao (id) match simple on update no action on delete no action,
    constraint fk_dom_tipo_pavimentacao_amarracao_amarracao_agua foreign key ("id_pavimentacao") references cadastro.dom_tipo_pavimentacao_amarracao (id) match simple on update no action on delete no action
);

create table if not exists cadastro.amarracao_agua_anexos (
     id serial primary key,
     id_amarracao_agua integer,
     anexo_nome varchar(250),
     anexo_dados bytea,
     constraint fk_amarracao_agua_amarracao_aguaanexos foreign key ("id_amarracao_agua") references cadastro.amarracao_agua (id) match simple on update no action on delete no action
);

truncate table cadastro.amarracao_agua, cadastro.amarracao_agua_anexos;

create index if not exists amarracao_agua_geometry_idx on cadastro.amarracao_agua using GIST(geometry);
create index if not exists id_amarracao_agua_anexo_idx on cadastro.amarracao_agua_anexos(id_amarracao_agua);