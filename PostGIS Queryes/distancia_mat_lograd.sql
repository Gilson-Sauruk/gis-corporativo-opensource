SELECT lig.matricula, log.nome_cesan, ST_Distance(lig.geom, log.geom) distancia
FROM public.ligacoes lig
LEFT JOIN public.logradouros log
    ON ST_DWithin(lig.geom, log.geom, 10)
WHERE lig.matricula IN (629308,27)
ORDER BY ST_Distance(lig.geom, log.geom)
--LIMIT 2;
