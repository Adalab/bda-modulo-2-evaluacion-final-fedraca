
/* Para este ejerccio utilizaremos la BBDD Sakila que hemos estado utilizando durante el repaso de SQL. Es una base de datos de ejemplo que simula una tienda de alquiler de películas.
 Contiene tablas como `film` (películas), `actor` (actores), `customer` (clientes), `rental` (alquileres), `category` (categorías), entre otras.
 Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.*/
 
 USE sakila;
 
 /* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
 
 SELECT*
 FROM film;
 
 SELECT DISTINCT title      /*usamos distinct para seleccionar los valores unicos sin repeticion*/
 FROM film;
 
 
 
 /*2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/
 
 SELECT title, rating
 FROM film
 WHERE rating ="PG-13"; 
 
 
/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/


SELECT title, description
FROM film
WHERE description LIKE "%amazing%";   /*buscamos con el like el patron*/


/*4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

SELECT title, length
FROM film
WHERE length > 120;


/*5. Recupera los nombres de todos los actores.*/
SELECT *
FROM actor;

SELECT CONCAT(first_name, "  ", last_name)
FROM actor; 

/*6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

SELECT CONCAT(first_name, "  ", last_name)
FROM actor
WHERE last_name = "Gibson"; 


/*7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/
SELECT CONCAT(first_name, "  ", last_name), actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20; 


/*8. Encuentra el título de las películas en la tabla `film` que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/
SELECT title, rating
FROM film
WHERE rating NOT IN ("PG-13", "R" );


/*9. Encuentra la cantidad total de películas en cada clasificación de la tabla `film` y muestra la clasificación junto con el recuento.*/

SELECT rating, COUNT(*) AS cantidad_total        /*USAMOS EL COUNT PARA QUE CUENTE EL TOTAL DE PELICULAS EN CADA CLASIFICACION*/
FROM film
GROUP BY rating; 


/*10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/

SELECT CONCAT(first_name, "  ", last_name) AS nombre_completo, c.customer_id, COUNT(*) AS total_alquiladas
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY customer_id, nombre_completo;



/*11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/

/* NO HE PODIDO SOLUCIONAR ESTE EJERCICIO*/

SELECT *
FROM category;


SELECT ca.name AS nombre_category, COUNT(*) AS total_peliculas
FROM category AS ca
JOIN film AS f ON 
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY ca.name;





/*12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla `film` y muestra la clasificación junto con el promedio de duración.*/

SELECT rating, AVG(length)
FROM film
GROUP BY rating; 
/*AGRUPAMOS LA CLASIFICAICON PARA MOSTRARLA CON EL PROMEDIO*/


/*13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

SELECT film_id
FROM film
WHERE title= "Indian Love";
/* LA TABLA FILM_ACTOR TIENE LAS COLUMNAS DE ACTOR_ID Y FILM_ID , CON ESTA COLUMNAS CON LAS TABLAS DE ACTOR Y LA TABLA FILM */

SELECT a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
JOIN  film AS f      /*BUSCAMOS EN LA TABLA FILM EL TITULO DE INDIAN LOVE */
ON fa.film_id = f.film_id
WHERE  f.title = 'Indian Love';   



/*14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/

SELECT title, description
FROM film
WHERE description LIKE "%dog%" OR "%cat%"; 

/*15. Hay algún actor o actriz que no apareca en ninguna película en la tabla `film_actor`.*/ /*RESPUESTA ES NO */
SELECT *
FROM film_actor;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;  
 
 /*BUSCAMOS POR ACTOR_ID EN LA TABLA FILM_ACTOR Y ESTA HACE UNION CON LA TABLA DE ACTORES, 
                                SI EL ACTOR_ID EN LA TABLA DE FILM_aCTOR ES NULL, QUIERE DECIR QUE NO APARECE EN NIGUNA PELICULA*/


 /*16. el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
 
 SELECT title, release_year
 FROM film
 WHERE release_year BETWEEN 2005 AND 2010; 
 

/*17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
EXPLICACION: primero buscamos el titulo  en film, para despues BUSCAR CUALES SON DE categoria FAMILY
BUSCO LAS TABLAS CON COLUMNAS IGUALES , Y CON LAS CUALES PUEDA RELACIONAR EL TITULO DE LA PELICULA, 
Y LA CATEGORIA QUE ESTAMOS BUSCANDO, PONIENDO LA CONDICION DE QUE EL NOMBRE DE LA CATEGORIA SEA FAMILIA  */

SELECT *
FROM category
WHERE name = "Family";


SELECT f.title
FROM film AS f
JOIN film_category AS fc 
ON f.film_id = fc.film_id
JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family';


/*18. Muestra el nombre y apellido de  actores que aparecen en más de 10 películas.*/

/*RESPUESTA--JUNTAMOS LA TABLA DE ACTORES DONDE SE ENCUENTRA EL NOMBRE Y EL iD DE LOS ACTORES CON LA DE FILM_ACTOR, 
AQUI SE ENCUENTRA EL TAMBIEN EL ID ACTORES Y TAMBIEN EL FILM_ID QUE NOS SERVIRA PARA CONTAR LAS PELICULAS Y SABER SI EL ACTOR APARECE EN ENMAS DE 10 PELIS*/

SELECT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS f ON f.actor_id= a.actor_id
GROUP BY a.actor_id
HAVING COUNT(film_id) > 10;



/*19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla `film`.*/

SELECT title, rating, length     /*agrego rating y length en el select para que me muestre tambien la informacion de clasficicacion y duracion, solo para comprobacion*/
FROM film
WHERE rating= "R"
AND length >= 120; 


/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.

RESPUESTA-- JUNTAS TABLAS DE CATEGORIA, FILM Y FILM_CATEGORY PARA RELACIONAR LAS PELICULAS CON SU CATEGORIA Y OBTENER LA DURACION. 
DESPUES SE AGRUPAN LOS RESULTADO POR EL NOMBRE DE LA CATEGORIA TENIENDO EL CUENTA QUE EL PROMEDIO DE ESTAS SEAN SUPERIO A 120  */


SELECT c.name AS nombre_categoria, AVG(f.length) AS promedio_duracion
FROM category AS c
JOIN  film_category AS fc 
ON c.category_id = fc.category_id
JOIN film AS f 
ON fc.film_id = f.film_id
GROUP BY c.name
HAVING promedio_duracion > 120;


/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/
/*EN LA TABLA DE ACTOR, SACAMOS NOMBRE , AQUI TAMBIEN SE ENCUENTRA  EL ACTOR_ID QUE ES VALOR POR EL QUE VAMOS AGRUPAR (PARA SABER SI LA CANTIDAD DE PELIS EN LAS QUE HA ACTUADO ES MAYOR A 5 )
Y CON EL CUAL SE UNE A LA TABLA DE FILM_aCTOR*/


SELECT a.first_name, a.last_name, COUNT(*) AS cantidad_peliculas   /*COUNT NOS CUENTA LA CANTIDAD DE LINEAS EN LAS QUE APARECE EL NOMBRE TAL*/
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING COUNT(*) >= 5;


/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
EL PRIMER SELECT NOS MUESTRA EL TITULO DE LAS PELICULAS, (DE LA TABLA DE FILM). EL ID_INVENTARIO NOS VA SERVIR PARA UNIR LA TABLA INVENTARIO CON LA TABLA DE RENTAS, Y EL FLIM_ID PARA UNIR RENTAS CON FILM */ 

SELECT title
FROM film
WHERE film_id IN(SELECT inventory.film_id                         /*la subconsulta nos muestra el id_inventario para peliculas que se alquilan pormas de 5 dias */
                  FROM rental
                  JOIN inventory ON rental.inventory_id = inventory.inventory_id
                  WHERE DATEDIFF(return_date, rental_date)> 5);      /* DATEDIFF SE UTILIZA PARA CALCULAR LA DIFERENCIA ENTRE DOS FECHAS*/
			

/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.*/


SELECT first_name, 
	   last_name          
	FROM actor        /*los actores que no han actuado en pelicula de horror*/        
	WHERE actor_id NOT IN (SELECT actor_id       /* para sacar los actores que han actuado en pelis de horror*/ /*LO BUSCAMOS POR ACTOR_ID, Y QUE ESTE A SU VEZ TENGA SU FILM_ID EN LA CATEGORIA HORROR*/
							FROM film_actor   
							WHERE film_id IN(SELECT film_id   /* BUSCAMOS EL FILM_ID EN CATEGORY(HORROR)*/
											 FROM film_category
											 WHERE category_id =(SELECT category_id         /*para sacar la categoría "Horror*/  
																 FROM category
																 WHERE name = 'Horror')));

## BONUS

/*24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla `film`.*/ 

SELECT title   /*BUSCAMOS EL TITULO DE LAS PELIS CON DURACION MAYOR A 180 MINUTOS*/
	FROM film
	WHERE length > 180
	  AND film_id IN (SELECT film_id /*BUSCAMOS EL FILM_ID  DONDE EL CATEGORY_ID DE ENCUENTRE EN LA CATEGORIA DE COMEDIA*/
						FROM film_category
						WHERE category_id = (SELECT category_id     /*ID DE LA CATEGORIA COMEDIA*/
											 FROM category
											WHERE name = 'Comedy'));



/*25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/









