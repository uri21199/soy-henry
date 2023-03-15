use checkpoint_m2;
select * from canal_venta;
select * from producto;
select * from venta;

# ¿Cuál es el canal id del Producto cuyo nombre es EPSON COPYFAX 2000? 

select IDProducto, Concepto 
from producto
where Concepto = "EPSON COPYFAX 2000";

/*
¿Cuál es el canal de ventas con menor cantidad de ventas registradas?
Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX/COUNT
*/

select sum(Cantidad) as cantidad, IdCanal
from venta
group by (IdCanal)
order by cantidad
limit 1;

/*
¿Cual fue el mes con mayor venta de la sucursal 13 para el año 2015?
Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM 
*/

select count(cantidad) as cantidad, date_format(Fecha, '%m') as mes
from venta
where idSucursal = 13 and date_format(Fecha, '%Y') = 2015
group by mes
order by cantidad desc
limit 1;

/*
9) Se define el tiempo de entrega como el tiempo en días transcurrido entre que se realiza la compra y se efectua la entrega. 
Para analizar mejoras en el servicio, la dirección desea saber: cuál es el año con el promedio más alto de este tiempo de entrega. 
(Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)
Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX
*/
use checkpoint_m2;
select avg(datediff(Fecha_Entrega, Fecha)) as tiempo_transcurrido, date_format(Fecha, '%Y') as año
from venta
group by año
order by año desc
limit 1;


/*
10) La dirección desea saber que tipo de producto tiene la mayor venta en 2020 (Tabla 'producto', campo Tipo = Tipo de producto)
Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX
*/

SELECT p.Tipo, SUM(v.Cantidad) AS TotalVentas
FROM producto p
INNER JOIN venta v ON p.idProducto = v.idProducto
WHERE YEAR(v.Fecha) = 2020
GROUP BY p.Tipo
ORDER BY TotalVentas DESC
LIMIT 1;

/*
11) ¿Cuál es el año y mes con la mayor cantidad de productos vendidos?
Informar la respuesta con 4 digitos para el año y 2 para el mes
Por ejemplo 201506 seria Junio 2015
Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM
*/

select date_format(Fecha, '%Y%m') as fecha_nueva, sum(cantidad) as total
from venta
group by fecha_nueva
order by total desc
limit 1;

# 12) ¿Cuantos productos tienen la palabra DVD en alguna parte de su nombre/concepto?

select count(*) as total
from producto
where Concepto like '%DVD%';

#13) ¿Cual de estos tipos de producto, tiene la menor diferencia de precio entre sus minimos y maximos? (gabinetes, gaming, impresion)

select (max(Precio) - min(Precio)) as diferencia, Tipo
from producto
group by Tipo
order by diferencia
limit 1;

/*
14) Teniendo en cuenta que Fecha es la fecha real de compra, y Fecha_Entrega es la fecha real que se entrego el producto. 
¿Cuantas ventas NO se entregaron el mismo mes en que fueron compradas?
Ejemplo
Venta |Fecha      | Fecha_Entrega
 1    |2018-03-09 | 2018-03-25 --> Se entrego el mismo mes que fue hecha la venta
 2    |2020-06-29 | 2020-07-01 --> No se entrego el mismo mes que la venta
*/

select count(*) as total
from venta
where month (Fecha) != month(Fecha_Entrega) and year(Fecha) = year(Fecha_Entrega);

#15) Cual es el Id del empleado que mayor cantidad de productos vendio en toda la historia de las ventas?

select IdEmpleado, sum(cantidad) as total
from venta
group by IdEmpleado
order by total desc
limit 1;

#¿Cuál es el producto con mayor venta en la sucursal 7 en el año 2019?

select count(v.cantidad) as total, v.IdSucursal, v.IdProducto, p.Concepto
from venta v
join producto p on v.IdProducto = p.IDProducto
where IdSucursal = 7 and year(Fecha) = 2019
group by IdProducto
order by total DESC
limit 1;

#¿Cuál es la cantidad total de productos vendidos por cada sucursal en el mes de agosto de 2018?



select count(cantidad) as cantidad, IdSucursal
from venta
where date_format(Fecha, '%Y') = 2018
group by IdSucursal 
order by IdSucursal;

#¿Cuál es el promedio de ventas por día en la sucursal 3 durante el mes de mayo de 2018?
select avg(cantidad) as promedio, IdSucursal
from venta
where month(Fecha) = 05 and year(Fecha) = 2018
group by IdSucursal 
order by IdSucursal;

#¿Cuál es el producto con menor venta en la sucursal 5 en el año 2017?

SELECT p.Concepto, MIN(v.Cantidad) AS VentaMinima
FROM venta v
JOIN producto p ON v.IdProducto = p.IDProducto
WHERE v.IdSucursal = 5 AND YEAR(v.Fecha) = 2017
GROUP BY p.Concepto
ORDER BY VentaMinima ASC
LIMIT 1;

#¿Cuál es el año con mayor cantidad de productos vendidos en la sucursal 12?
select year(Fecha) as anio, count(*) as total
from venta
where IdSucursal = 12
group by anio
order by total desc
limit 1;

#¿Cuál es el promedio de ventas por día en todas las sucursales durante el mes de enero de 2018?
select avg(Cantidad) as promedio, IdSucursal
from venta
where year(Fecha) = 2018 and month(Fecha) = 01
group by IdSucursal
order by IdSucursal;

SELECT AVG(total/dias) as promedio_ventas_dia
FROM (
  SELECT SUM(Cantidad) as total, COUNT(DISTINCT DATE(Fecha)) as dias
  FROM venta
  WHERE Fecha BETWEEN '2018-01-01' AND '2018-01-31'
) t; #Ejemplo de ChatGPT
