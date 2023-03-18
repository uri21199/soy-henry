/*11) ¿Cuál es el año con la mayor cantidad de productos vendidos? Responder con número de año. Ejemplo: 2024*/
use checkpoint_m2;
select * from venta;
select year(Fecha) as anio, count(Cantidad) as total
from venta
group by anio
order by total;

/*¿Cuál es el canal de venta que tiene la segunda posición en cantidad de ventas en 2020?*/
select count(Cantidad) as total, IdCanal
from venta
where year(Fecha) = 2020
group by IdCanal
order by total;
select * from canal_venta;

/*13) ¿Cuál es el Id del empleado que menor cantidad de productos vendió en el histórico de ventas de la empresa?*/
select * from venta;
select count(Cantidad) as total, IdEmpleado
from venta
group by IdEmpleado
order by total;

/*14) Se define el tiempo de entrega como el tiempo en días transcurrido entre que se realiza la compra y se efectua la entrega. 
Para analizar mejoras en el servicio, la dirección desea saber: cuál es el año con el promedio más alto de este tiempo de entrega. 
(Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)*/
select * from venta;
select year(Fecha) as anio, avg(datediff(Fecha_Entrega, Fecha)) as promedio
from venta
group by anio
order by promedio desc;

/*15) ¿Cuál es el promedio de precio de los productos cuyo concepto comienza con la letra C?*/
select * from venta;
select * from producto;
select avg(Precio) as promedio
from producto
where Concepto like 'C%';

/*16) ¿Cuantos productos tienen la palabra " CD " (mayúsculas o minúsculas) en alguna parte de su descripción (Concepto = Descripción del Producto) 
y su precio es mayor a 500?*/
select * from producto;
select count(*) as total
from producto
where UPPER(Concepto) like '%CD%' and Precio > 500;

/*17) ¿Cuál es el id del Producto cuyo nombre es EPSON COPYFAX 2000?*/
select IdProducto, Concepto
from producto
where Concepto = "EPSON COPYFAX 2000";

/*18) Cual fue el mes (Fecha = Fecha de Venta) con menor venta (Venta = Precio*Cantidad) de la sucursal 13 para el año 2015 ?*/
select * from venta;
select month(Fecha) as mes, SUM(Precio * Cantidad) as venta
from venta
where IdSucursal = 13 and year(Fecha) = 2015
group by mes
order by venta;