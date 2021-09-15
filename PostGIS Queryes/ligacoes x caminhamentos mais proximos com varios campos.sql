select lc.matricula, 
		(select c.id_caminhamento 
         from caminhamentos c 
         where ST_DWithin(lc.geometry, c.geometry, 10)
         order by ST_Distance(c.geometry, lc.geometry) asc limit 1) as id_caminhamento
from public.ligacoes_clientes lc 
inner join public.localidades l 
	on ST_Intersects(lc.geometry, l.geometry)
where l.nome = 'DOMINGOS MARTINS'




select sub1.matricula, c2.id_caminhamento, c2.ciclo, c2.nome_ciclo 
from caminhamentos c2 
left join (
	select lc.matricula as matricula, 
			(select c.id_caminhamento 
	         from caminhamentos c 
	         where ST_DWithin(lc.geometry, c.geometry, 10)
	         order by ST_Distance(c.geometry, lc.geometry) asc limit 1) as id_caminhamento
	from public.ligacoes_clientes lc 
	inner join public.localidades l 
		on ST_Intersects(lc.geometry, l.geometry)
	where l.nome = 'DOMINGOS MARTINS'
	) sub1 on c2.id_caminhamento = sub1.id_caminhamento