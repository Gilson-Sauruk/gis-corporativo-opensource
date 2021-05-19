select 	c.id_apontam as id_apontamento,
        (select l.matricula 
         from ligacoes l 
         where ST_DWithin(l.geometry, c.geometry, 50)
         order by ST_Distance(c.geometry, l.geometry) asc limit 1) as matricula_proxima, 
        (select ST_Distance(c.geometry, l2.geometry) 
         from ligacoes l2 
         where ST_DWithin(l2.geometry, c.geometry, 50)
         order by ST_Distance(c.geometry, l2.geometry) asc limit 1) as distancia
from clandestinos c
where c.matricula = 0