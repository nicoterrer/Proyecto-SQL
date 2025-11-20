--1) Crea el esquema de la BBDD

--2) Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
select "title"
from film 
where "rating" = 'R';

--3) Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select "first_name", "last_name"
from "actor"
where "actor_id" between 30 and 40;

--4) Obtén las películas cuyo idioma coincide con el idioma original.
select "title"
from "film"
where "original_language_id" is null;

--5) Ordena las películas por duración de forma ascendente.
select "title", "length"
from "film"
order by "length" asc;

--6) Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select "first_name", "last_name"
from "actor"
where "last_name" = 'ALLEN';

--7)  Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
select "rating", COUNT(*) as total_peliculas
from "film"
group by "rating"
order by "total_peliculas" desc

--8)  Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
select "title", "rating", "length"
from "film"
where "rating" = 'PG-13' or "length" > '180'

--9) Encuentra la variabilidad de lo que costaría reemplazar las películas.
select  
    ROUND(VARIANCE("replacement_cost"), 2) as "varianza_coste",
    ROUND(STDDEV("replacement_cost"), 2) as "desviacion_estandar_coste"
from "film";

--10) Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MIN("length") as "duracion minima", MAX ("length") as "duracion maxima"
from "film";

--11)  Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select "amount", "payment_date"
from "payment"
ORDER by "payment_date" desc
offset 2
limit 1;

--12) Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
select "title"
from "film"
where "rating" not in ('NC-17', 'G');

--13) Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select 
    "rating", 
    round(avg("length"), 2) as "duracion_promedio"
from "film"
group by "rating";

--14) Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
select "title", "length"
from "film"
where "length">'180'

--15) ¿Cuánto dinero ha generado en total la empresa?
select round(sum("amount"), 2) as "total_generado"
from "payment"

--16) Muestra los 10 clientes con mayor valor de id.
select "customer_id" 
from "customer"
order by "customer_id" desc
limit 10

--17)  Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select "first_name", "last_name", "title"
from "actor" as a
inner join film_actor as fa on a."actor_id" = fa."actor_id"
inner join "film" as f on fa."film_id" = f."film_id"
where f."title" = 'EGG IGBY';

-- 18)  Selecciona todos los nombres de las películas únicos.
select distinct "title"
from "film";

--19) Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ
select f."title" as "titulo" , c."name" as "Genero", f."length" as "duracion"
from "film" as f
inner join "film_category" as fc on f."film_id" = fc."film_id"
inner join "category" as c on  c."category_id" = fc."category_id"
where f."length" > 180 and c."name" = 'Comedy';

-- 20) Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select 
    c."name", 
    round(avg(f."length"), 2) as "duracion_promedio"
from "film" as f
inner join "film_category" as fc on f."film_id" = fc."film_id"
inner join "category" as c on fc."category_id" = c."category_id"
group by c."name"
having avg(f."length") > 110;

--21) ¿Cuál es la media de duración del alquiler de las películas?
select 
    round(avg("rental_duration"), 2) as "media_dias_alquiler"
from "film";

--22) Crea una columna con el nombre y apellidos de todos los actores y actrices.
select 
    concat("first_name", ' ', "last_name") as "nombre_completo"
from "actor";

--23) Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select 
    date("rental_date") as "dia",
    count(*) as "cantidad_alquileres"
from "rental"
group by "dia"
order by "cantidad_alquileres" desc;

--24)  Encuentra las películas con una duración superior al promedio.
select "title", "length"
from "film"
where "length" > (
    select avg("length")
    from "film");

--25) Averigua el número de alquileres registrados por mes.
select 
    extract(year from "rental_date") as "año",
    extract(month from "rental_date") as "mes_numero",
    count(*) as "cantidad_alquileres"
from "rental"
group by "año", "mes_numero"
order by "año", "mes_numero";

--27) Encuentra el promedio, la desviación estándar y varianza del total pagado
select 
    round(avg("amount"), 2) as "promedio_pago",
    round(stddev("amount"), 2) as "desviacion_estandar",
    round(variance("amount"), 2) as "varianza_pago"
from "payment";

--28) Muestra el id de los actores que hayan participado en más de 40 películas.
select 
    "actor_id", 
    count(*) as "total_peliculas"
from "film_actor"
group by "actor_id"
having count(*) > 40;

--29) Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select 
    f."title", 
    count(i."inventory_id") as "cantidad_en_inventario"
from "film" as f
left join "inventory" as i on f."film_id" = i."film_id"
group by f."title";

--30) Obtener los actores y el número de películas en las que ha actuado.
select 
    concat(a."first_name", ' ', a."last_name") as "nombre_actor",
    count(fa."film_id") as "numero_peliculas"
from "actor" as a
left join "film_actor" as fa on a."actor_id" = fa."actor_id"
group by a."actor_id", "nombre_actor"
order by "numero_peliculas" desc;

--31) Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select 
    f."title",
    concat(a."first_name", ' ', a."last_name") as "nombre_actor"
from "film" as f
left join "film_actor" as fa on f."film_id" = fa."film_id"
left join "actor" as a on fa."actor_id" = a."actor_id"
order by f."title";

--32) Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select 
    concat(a."first_name", ' ', a."last_name") as "nombre_actor",
    f."title"
from "actor" as a
left join "film_actor" as fa on a."actor_id" = fa."actor_id"
left join "film" as f on fa."film_id" = f."film_id"
order by "nombre_actor";

--33) Obtener todas las películas que tenemos y todos los registros de alquiler.
select 
    f."title",
    r."rental_date",
    r."return_date"
from "film" as f
full join "inventory" as i on f."film_id" = i."film_id"
full join "rental" as r on i."inventory_id" = r."inventory_id"
order by f."title";

--34) Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select 
    concat(c."first_name", ' ', c."last_name") as "nombre_cliente",
    sum(p."amount") as "total_gastado"
from "customer" as c
inner join "payment" as p on c."customer_id" = p."customer_id"
group by c."customer_id"
order by "total_gastado" desc
limit 5;

--35) Selecciona todos los actores cuyo primer nombre es 'Johnny'
select "first_name", "last_name"
from "actor"
where "first_name" = 'JOHNNY';

--36) Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido. 
select 
    "first_name" as "Nombre",
    "last_name" as "Apellido"
from "actor";

--37)  Encuentra el ID del actor más bajo y más alto en la tabla actor.
select 
    min("actor_id") as "id_mas_bajo",
    max("actor_id") as "id_mas_alto"
from "actor";

--38) Cuenta cuántos actores hay en la tabla “actorˮ.
select 
    count(*) as "total_actores"
from "actor";

--39)  Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select "first_name", "last_name"
from "actor"
order by "last_name" asc;

--40) Selecciona las primeras 5 películas de la tabla “filmˮ.
select *
from "film"
limit 5;

--41) Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select 
    "first_name", 
    count(*) as "cantidad"
from "actor"
group by "first_name"
order by "cantidad" desc;

-- Encontrar EL nombre más repetido
select 
    "first_name", 
    count(*) as "cantidad"
from "actor"
group by "first_name"
order by "cantidad" desc
limit 1;

--42)  Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select 
    r."rental_id",
    r."rental_date",
    concat(c."first_name", ' ', c."last_name") as "nombre_cliente"
from "rental" as r
inner join "customer" as c on r."customer_id" = c."customer_id";

--43) Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select 
    concat(c."first_name", ' ', c."last_name") as "nombre_cliente",
    r."rental_id",
    r."rental_date"
from "customer" as c
left join "rental" as r on c."customer_id" = r."customer_id"
order by "nombre_cliente";

--44) Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select 
    f."title", 
    c."name" as "categoria"
from "film" as f
cross join "category" as c;

/* En este contexto, NO aporta valor a nivel de análisis.

Según deficiión, el cross join "devuelve el producto cartesiano de dos tablas... combina cada fila de la primera tabla con cada fila de la segunda, sin ninguna condición que relacione las tablas" .

En este sentido, lo que hace es asignar todas las categorías a todas las películas. Si tienes 1000 películas y 16 categorías, se obtendrán 16,000 filas.

El problema es que nos devuelve que la película "ACADEMY DINOSAUR", por poner un ejemplo, es tanto de "Comedia", "Infantil", "Musical", "Terror", etc., todo a la vez. Crea asociaciones falsas porque ignora la relación real que está guardada en la tabla intermedia film_category.

Como bien hemos visto, "El CROSS JOIN, generalmente no se utiliza para relaciones entre datos, sino en situaciones donde queremos todas las combinaciones posibles" (por ejemplo, para generar una matriz teórica). 

Para saber la categoría real de una película, siempre debemos usar inner join con la tabla intermedia. */

--45) Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct 
    a."first_name", 
    a."last_name"
from "actor" as a
inner join "film_actor" as fa on a."actor_id" = fa."actor_id"
inner join "film_category" as fc on fa."film_id" = fc."film_id"
inner join "category" as c on fc."category_id" = c."category_id"
where c."name" = 'Action';

--46) Encuentra todos los actores que no han participado en películas.
select 
    a."first_name", 
    a."last_name"
from "actor" as a
left join "film_actor" as fa on a."actor_id" = fa."actor_id"
where fa."film_id" is null;

--47) Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select 
    a."first_name",
    a."last_name",
    count(fa."film_id") as "cantidad_peliculas"
from "actor" as a
inner join "film_actor" as fa on a."actor_id" = fa."actor_id"
group by a."actor_id"
order by "cantidad_peliculas" desc;

--48) Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
create view "actor_num_peliculas" as
select 
    a."first_name", 
    a."last_name", 
    count(fa."film_id") as "numero_peliculas"
from "actor" as a
inner join "film_actor" as fa on a."actor_id" = fa."actor_id"
group by a."actor_id", a."first_name", a."last_name";


select * from "actor_num_peliculas"
order by "numero_peliculas" desc;

--49) Calcula el número total de alquileres realizados por cada cliente.
select 
    c."first_name",
    c."last_name",
    count(r."rental_id") as "total_alquileres"
from "customer" as c
left join "rental" as r on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by "total_alquileres" desc;

--50) Calcula la duración total de las películas en la categoría 'Action'.
select 
    sum(f."length") as "duracion_total_action"
from "film" as f
inner join "film_category" as fc on f."film_id" = fc."film_id"
inner join "category" as c on fc."category_id" = c."category_id"
where c."name" = 'Action';

--51) Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temporary table "cliente_rentas_temporal" as
select 
    c."customer_id",
    concat(c."first_name", ' ', c."last_name") as "nombre_cliente",
    count(r."rental_id") as "total_alquileres"
from "customer" as c
left join "rental" as r on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name";

-- consultar la tabla temporal
select * from "cliente_rentas_temporal"
order by "total_alquileres" desc;

--52) Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table "peliculas_alquiladas" as
select 
    f."title",
    count(r."rental_id") as "total_alquileres"
from "film" as f
inner join "inventory" as i on f."film_id" = i."film_id"
inner join "rental" as r on i."inventory_id" = r."inventory_id"
group by f."film_id", f."title"
having count(r."rental_id") >= 10;

-- consultar la tabla temporal
select * from "peliculas_alquiladas"
order by "total_alquileres" desc;

--53)  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select 
    f."title"
from "customer" as c
inner join "rental" as r on c."customer_id" = r."customer_id"
inner join "inventory" as i on r."inventory_id" = i."inventory_id"
inner join "film" as f on i."film_id" = f."film_id"
where 
    c."first_name" = 'TAMMY' 
    and c."last_name" = 'SANDERS'
    and r."return_date" is null
order by f."title" asc;

--54) Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
select distinct
    a."first_name", 
    a."last_name"
from "actor" as a
inner join "film_actor" as fa on a."actor_id" = fa."actor_id"
inner join "film_category" as fc on fa."film_id" = fc."film_id"
inner join "category" as c on fc."category_id" = c."category_id"
where c."name" = 'Sci-Fi'
order by a."last_name" asc;

--55) Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select distinct
    a."first_name",
    a."last_name"
from "actor" as a
inner join "film_actor" as fa on a."actor_id" = fa."actor_id"
where fa."film_id" in (
    -- Subconsulta 2 (Intermedia): Obtener los ID de las películas que se alquilaron DESPUÉS de la fecha límite
    select i."film_id"
    from "rental" as r
    inner join "inventory" as i on r."inventory_id" = i."inventory_id"
    where r."rental_date" > (
        -- Subconsulta 1 (Interior): Encontrar la fecha del PRIMER alquiler de 'SPARTACUS CHEAPER'
        select min(r2."rental_date")
        from "film" as f
        inner join "inventory" as i2 on f."film_id" = i2."film_id"
        inner join "rental" as r2 on i2."inventory_id" = r2."inventory_id"
        where f."title" = 'SPARTACUS CHEAPER'))
order by a."last_name" asc;

--56)  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ
select 
    a."first_name", 
    a."last_name"
from "actor" as a
where a."actor_id" not in (
    -- Subconsulta: Obtener la lista de ID de actores en películas 'Music'
    select fa."actor_id"
    from "film_actor" as fa
    inner join "film_category" as fc on fa."film_id" = fc."film_id"
    inner join "category" as c on fc."category_id" = c."category_id"
    where c."name" = 'Music')
order by a."last_name" asc;

--57)  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct
    f."title"
from "film" as f
inner join "inventory" as i on f."film_id" = i."film_id"
inner join "rental" as r on i."inventory_id" = r."inventory_id"
where 
    -- 1. Aseguramos que la película ha sido devuelta (para calcular la duración)
    r."return_date" is not null 
    -- 2. La resta de las fechas (en días) es mayor a 8
    and (date(r."return_date") - date(r."rental_date")) > 8
order by f."title" asc;

--58)  Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.
select 
    f."title"
from "film" as f
where f."film_id" in (
    -- Subconsulta: encuentra los ID de las películas en la categoría 'Animation'
    select fc."film_id"
    from "film_category" as fc
    inner join "category" as c on fc."category_id" = c."category_id"
    where c."name" = 'Animation')
order by f."title" asc;

--59)  Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película.
select 
    "title", 
    "length"
from "film"
where 
    "length" = (
        -- Subconsulta: Obtener la duración de 'DANCING FEVER'
        select "length"
        from "film"
        where "title" = 'DANCING FEVER')
    -- Excluyo la película original para no tenerla en la lista de resultados
    and "title" <> 'DANCING FEVER'
order by "title" asc;

--60) Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select 
    c."first_name", 
    c."last_name",
    count(distinct i."film_id") as "peliculas_distintas_alquiladas"
from "customer" as c
inner join "rental" as r on c."customer_id" = r."customer_id"
inner join "inventory" as i on r."inventory_id" = i."inventory_id"
group by c."customer_id", c."first_name", c."last_name"
having count(distinct i."film_id") >= 7
order by c."last_name" asc;

--61) Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select 
    c."name" as "categoria",
    count(r."rental_id") as "total_alquileres"
from "category" as c
inner join "film_category" as fc on c."category_id" = fc."category_id"
inner join "inventory" as i on fc."film_id" = i."film_id"
inner join "rental" as r on i."inventory_id" = r."inventory_id"
group by c."name"
order by "total_alquileres" desc;

--62) Encuentra el número de películas por categoría estrenadas en 2006.
select 
    c."name" as "categoria",
    count(f."film_id") as "total_peliculas"
from "category" as c
inner join "film_category" as fc on c."category_id" = fc."category_id"
inner join "film" as f on fc."film_id" = f."film_id"
where f."release_year" = 2006
group by c."name"
order by "total_peliculas" desc;

--63) Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select 
    s."first_name" as "nombre_empleado",
    s."last_name" as "apellido_empleado",
    st."store_id" as "id_tienda"
from "staff" as s
cross join "store" as st;

--64) Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select 
    c."customer_id",
    concat(c."first_name", ' ', c."last_name") as "nombre_cliente",
    count(r."rental_id") as "total_alquileres"
from "customer" as c
left join "rental" as r on c."customer_id" = r."customer_id"
group by c."customer_id", c."first_name", c."last_name"
order by "total_alquileres" desc;



