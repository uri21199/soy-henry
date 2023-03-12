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

select avg(Fecha_Entrega - Fecha) as tiempo_transcurrido, date_format(Fecha, '%Y') as año
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
