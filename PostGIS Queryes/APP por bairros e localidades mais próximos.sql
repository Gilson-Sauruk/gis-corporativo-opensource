select 	ap.nome app_nome, ap.descricao app_descricao, ap.codigo app_codigo, 
		(
			select concat_ws(' - ', l.codigo, l.nome) 
			from public.localidades l
			order by ST_Distance(ap.geometry, l.geometry)
			limit 1
		) as localidade_proxima, 
		(
			select concat_ws(' - ', b.codigo , b.nome) 
			from public.bairros b
			order by ST_Distance(ap.geometry, b.geometry)
			limit 1
		) as bairro_proximo 
from public.areas_preservacao ap