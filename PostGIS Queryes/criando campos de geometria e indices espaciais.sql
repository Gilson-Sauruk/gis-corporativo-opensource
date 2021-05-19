SELECT AddGeometryColumn ('public','caminhamentos','geom',31984,'LINESTRING',2);

UPDATE public.caminhamentos 
SET geom = ST_LineMerge(geometry)

CREATE INDEX caminhamentos_geom_idx
  ON public.caminhamentos
  USING GIST (geom);