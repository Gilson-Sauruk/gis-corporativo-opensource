SELECT ST_LineLocatePoint(
	(SELECT ST_LineMerge(geom) FROM public.caminhamento
    WHERE id = '49886'),
    (SELECT geom FROM public.ligacao
    WHERE matricula = 5411173)
)

SELECT l.matricula, ST_LineLocatePoint(
	(SELECT ST_LineMerge(geom) FROM public.caminhamento
    WHERE id = '49886'),
    (SELECT geom FROM public.ligacao
    WHERE matricula = l.matricula)
)*100 as ordem
FROM public.ligacao l
WHERE l.matricula IN (3630234,5411173,3670295,3607470,3628523,3678865,3936481,3936490,3629910,3678881,3629945,3645649,3595757,3670333,3684890,3645630,3588688,3799875,3645835,3645401,3607500,3664082,3635546,3650251,3670503,3632733)
ORDER BY ordem

SELECT ST_AsText(ST_StartPoint((SELECT ST_LineMerge(geom) FROM public.caminhamento
    WHERE id = '49886'))) AS INICIO,
    ST_AsText(ST_EndPoint((SELECT ST_LineMerge(geom) FROM public.caminhamento
    WHERE id = '49886'))) AS FIM;
    
    
SELECT l.matricula, ST_LineLocatePoint(
	(SELECT ST_LineMerge(geom) FROM public.caminhamento
    WHERE id = '61421'),
    (SELECT geom FROM public.ligacao
    WHERE matricula = l.matricula)
)*100 as ordem
FROM public.ligacao l
WHERE l.matricula IN (
    SELECT lig.matricula
	FROM public.ligacao lig
		LEFT JOIN public.caminhamento cam ON ST_DWithin(lig.geom, cam.geom, 10)
	WHERE cam.id = '61421'
)
ORDER BY ordem

SELECT l.matricula, ST_LineLocatePoint(
	(SELECT ST_LineMerge(geometry) FROM public.caminhamentos c 
    WHERE c.id = 1),
    (SELECT lc.geometry FROM public.ligacoes_clientes lc
    WHERE lc.matricula = l.matricula)
)*100 as ordem
FROM public.ligacoes_clientes l
WHERE l.matricula IN (
    SELECT lig.matricula
	FROM public.ligacoes_clientes lig
		LEFT JOIN public.caminhamentos cam ON ST_DWithin(lig.geometry, cam.geometry , 10)
	WHERE cam.id = 1
)
ORDER BY ordem