SELECT * FROM CUSTOMERS;
SELECT * FROM MOVIES;
SELECT * FROM MEDIA;
SELECT * FROM RENTAL_HISTORY;
SELECT * FROM ACTORS;
SELECT * FROM STAR_BILLINGS;
SELECT * FROM TITLE_UNAVAIL;


/*
Cree una "Nota de recepción" en la que se incluya el nombre completo del cliente, empezando
por el nombre de pila; la película alquilada; en qué formato se alquiló; cuándo fue alquilada
la(s) película(s) por el cliente; cuándo va a devolver la película el cliente. Si el cliente no
definió una fecha específica para devolver la película, añada 45 días a la fecha de alquiler.
*/

select concat(first_name, ' ', last_name) as "Customer's Name",
title, format, rental_date, NVL(return_date, rental_date+45) as return_date
from customers natural join rental_history
natural join media
natural join movies
order by "Customer's Name", rental_date;

/*
Muestra el número de formatos de las películas que ofrece la tienda.
*/

with aux as (select title_id, count(*) Stock
from media
group by title_id)
select p.title, aux.Stock
from movies p, aux
where p.title_id = aux.title_id;

/*
Muestra cuántas películas, utilizando el title_id, ofrece la tienda para cada formato y también
muestra el total de todos los formatos para cada película.
*/

select title_id, NVL(format,'Total stock:') format, count(*) qty
from media
GROUP BY title_id, format WITH ROLLUP;


/*
Muestra la edad actual de los actores.
*/

SELECT stage_name, TIMESTAMPDIFF(YEAR,birth_date,sysdate()) age
FROM actors;