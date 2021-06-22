SELECT a.id, a.nome, b.id, b.nome, 
	st_area(st_intersection(a.geometry, b.geometry))
FROM areas_vulnerabilidade_social a, areas_vulnerabilidade_social b
WHERE a.id < b.id 
AND ST_INTERSECTS(a.geometry, b.geometry)
and st_area(st_intersection(a.geometry, b.geometry)) > 0