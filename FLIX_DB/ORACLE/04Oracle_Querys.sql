--Selects

--SELECT FOR INDEXES
select *
from user_indexes
where index_name = 'CUSTOMERS_LAST_NAME_I';
/*where table_name in ('CUSTOMERS','MOVIES', 'MEDIA', 'STAR_BILLINGS', 'ACTORS', 'RENTAL_HISTORY')
ORDER BY table_name;*/

--REVISAR CONSTRAINTS
SELECT CONSTRAINT_NAME, SEARCH_CONDITION AS CONSTRAINT_TYPE 
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME IN ('CUSTOMERS', 'MOVIES', 'MEDIA', 'RENTAL_HISTORY', 'ACTORS', 'STAR_BILLINGS')
ORDER BY CONSTRAINT_NAME;


--SELECT FOR VIEW
SELECT * FROM title_unavail;

--SELECT FOR SEQUENCES
SELECT * FROM USER_SEQUENCES;

--SELECT FOR EACH TABLE
SELECT * FROM CUSTOMERS;
SELECT * FROM MOVIES;
SELECT * FROM MEDIA;
SELECT * FROM RENTAL_HISTORY;
SELECT * FROM ACTORS;
SELECT * FROM STAR_BILLINGS;

--SELECT FOR SYNONYM
SELECT * FROM user_synonyms;


/*
Cree una "Nota de recepción" en la que se incluya el nombre completo del cliente, empezando
por el nombre de pila; la película alquilada; en qué formato se alquiló; cuándo fue alquilada
la(s) película(s) por el cliente; cuándo va a devolver la película el cliente. Si el cliente no
definió una fecha específica para devolver la película, añada 45 días a la fecha de alquiler.
*/

select (first_name || ' ' || last_name) as "Customer's Name",
	 title, format, rental_date, NVL(return_date,
	 rental_date+45) as return_date
from customers natural join rental_history
		   natural join media
               natural join movies
order by "Customer's Name", rental_date;


/*
Muestra el número de formatos de las películas que ofrece la tienda.
*/

with aux as (select title_id, count(*) "Stock (All formats)"
from media
group by title_id)
select p.title, aux."Stock (All formats)"
from movies p, aux
where p.title_id = aux.title_id;


/*
Muestra cuántas películas, utilizando el title_id, ofrece la tienda para cada formato y también
muestra el total de todos los formatos para cada película.
*/

select title_id, NVL(format,'Total stock:') format, count(*) qty
from media
GROUP BY ROLLUP(title_id, format)
order by title_id;


/*
Muestra la edad actual de los actores.
/*

SELECT stage_name, TRUNC((SYSDATE - birth_date)/365) age
FROM actors;