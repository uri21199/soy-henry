## Introducción a DML y ORM. Interacción con bases de datos.

En la clase anterior aprendimos como modelar un negocio para poder crear la estructura de una base de datos, siendo estas una de las fuentes de datos a consultar cuando sea necesario obtener información para la toma de decisiones.

SQL no solo permite interactuar con las bases de datos para crear sus objetos, sino que además nos permite escribir y recuperar datos. Esto es posible gracias al DML.

**DML (INSERT, UPDATE, DROP, SELECT, WHERE):**

Son sentencias que permiten administrar la información de una base de datos a partir de las tablas que la conforman. Las acciones que se pueden ejecutar son 

INSERTAR, 

MODIFICAR, 

ELIMINAR

CONSULTAR.

Insertar Datos

El tipo de datos a ingresar en el campo siempre debe coincidir con el definido al momento de crear la tabla.  

**Opción 1**: Se detallan en orden los campos y los registros a ingresar en cada uno ellos. Por cada sentencia **INSERT INTO** se puede declarar un **VALUES**. Es la opción menos eficiente para insertar datos en una tabla.
```sql
INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad)
VALUES('Maria ','Becerra','2000-4-1','Rosario',,'Argentina',38564122)

INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad)
VALUES('El ','Duki','1998-9-8','Santa Fé','Colombia',39874156)
```

**Opción 2**: Al igual que en la opción anterior, se detallan en orden los campos y los datos a ingresar en cada uno ellos. Solo se declara una sentencia **INSERT INTO** y luego se listan en **VALUES** cada uno de los registros separados por coma.

```sql
INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad) 
VALUES('Jeronimo','Gonzales','1988-8-9','Córdoba','Argentina',33687456),
('Ricardo','Lorenzo','1975-2-10','La Paz','Bolivia',20856147),
('Carlos','Principe','1985-6-11','Montevideo','Montevideo','Uruguay',25478369)
```

**Opción 3** : Se declara la sentencia **INSERT INTO** y el nombre de la tabla, luego se repite el **VALUES** de la opción 2. La diferencia con las anteriores es que se deben insertar datos para todos los campos que forman parte de la tabla.

```sql
INSERT INTO alumnos
VALUES('Ernesto','Corvalan','1993-12-12','Caleta Olivia','Argentina',35879145),
('Roberto','Carlos','1997-1-13','Cuidad de México','México',37854698),
('Luis','Rodriguez','1976-3-14','Montevideo','Uruguay',20896369),
('Hernan','Crespo','1999-9-15','Santiago de Chile','Chile',39546178)
```

Es importante aclarar que la inserción de datos no se da desde la interacción directa de un usuario con el gestor de la base de datos (PgAdmin o Workbench), sino que se hace a por medio del código en el cual se desarrolla una aplicación.

En este ejemplo, puedes observar un script de PHP en donde se solicitan datos a un usuario mediante una aplicación:


**Modificar Datos:**

Las sentencias de inserción no pueden utilizarse para modificar datos. Ya que en ese caso, deberíamos obtener advertencias por parte del gestor debido a el ingreso de datos duplicados. En caso de tener que reemplazar el valor de un registro utilizaremos **UPDATE**. Para utilizar esta sentencia, deberemos utilizar además **SET** y **WHERE**.

**UPDATE** - Especifica la tabla que vamos a modificar 

**SET** = - Especifica el campo a modificar y el nuevo valor a guardar. 

**WHERE** = - Declara una ruta de entrada al registro que vamos a modificar.

Como se menciono en el punto anterior, este tipo de procesos corren principalmente sobre aplicaciones.

**Opción 1**:

```sql
UPDATE alumnos
SET nombre = 'Carlos' 
WHERE cedulaIdentidad = 35879145;
```

**Opción 2**:

```sql
UPDATE alumnos
SET nombre = 'Juan', ciudad='Santa Fé' 
WHERE cedulaIdentidad = 33687456;
```

Será importante establecer cuidadosamente el campo a modificar, si no lo hacemos corremos el riesgo de modificar varios registros. Ese campo u otros pueden ser “filtrados” mediante la sentencia **WHERE**.


**Eliminar Datos:**

Cuando utilizamos **DELETE**, lo que se están borrando son registros y no datos de manera aislada. Si por ejemplo verificamos un error, no se debería eliminar el registro, sino realizar un **UPDATE** por el valor correcto.

```sql
DELETE FROM alumnos WHERE idPerfil=1 

DELETE FROM alumnos WHERE fechaInscripcion>'2021-01-08'
```


**Consultar Datos:**

Para consultar los datos que se encuentran guardados en una tabla, se debe utilizar la sentencia **SELECT**, esta sentencia debe estar acompañada de manera obligatoria por **FROM**, se presentará en diversas variantes más adelante.  
**SELECT** es una sentencia de proyección, donde puedes “solicitar” los campos a consultar. En **FROM** se debe especificar cual será la tabla a consultar.  

Es muy común que a la hora de consultar, debas hacerlo según ciertas condiciones vinculadas a una problema de negocios, para poder incorporarlas a la lógica de la consulta, se utiliza la cláusula **WHERE**. Esta clausula además se acompañan por operadores que permiten establecer los criterios de segmentación.  


**Operadores:**

Aritméticos

-   " + " : Sumar.
-   " - " : Restar.
-   " * " : Multiplicar.
-   " / " : Dividir.

```sql
SELECT nombreProducto, subtotal + impuestos AS Total
FROM productos

SELECT nombreColaborador, sueldo - retenciones AS SueldoNeto
FROM staff

SELECT nombreProducto, precio * cantidad AS Total
FROM productos
```


Relacionales

-   " = " : Igual.
-   "!= ": Distinto.
-   " > ": Mayor que, se puede agregar = para obtener >= mayor o igual.
-   " < " : Menor que, se puede agregar = para obtener >= menor o igual.
-   BETWEEN : Entre.
-   IN : Define conjuntos.
-   LIKE : Como. Para comparar textos.


```sql
SELECT *
FROM productos
WHERE fechaVenta = '2022-03-28'

SELECT *
FROM productos
WHERE fechaVenta != '2021-12-25'

SELECT *
FROM productos
WHERE fechaVenta > '2021-12-31'

SELECT *
FROM productos
WHERE fechaVenta < '2022-1-1'

SELECT *
FROM alumnos
WHERE fechaIngreso BETWEEN '2022-01-01' AND '2022-05-31'

SELECT *
FROM alumnos
WHERE pais IN ('Colombia','Mexico')

SELECT *
FROM alumnos
WHERE nombreModulo LIKE '%datos%'
```


Lógicos

-   NOT : No. Se puede vincular con IN.
-   AND : Y.
-   OR : O.

```sql
SELECT *
FROM alumnos
WHERE carrera IS NOT 'Full Stack' 

SELECT *
FROM alumnos
WHERE pais = 'Colombia' AND pais = 'Mexico'

SELECT *
FROM alumnos
WHERE pais = 'Colombia' OR pais = 'Mexico'
```


**ORM . Conceptos:**

[SQLAlchemy - The Database Toolkit for](https://www.sqlalchemy.org/)

Un ORM es un modelo de programación que permite interactuar con las estructuras de una base de datos relacional (SQL Server, MySQL, PostgreSQL, etc.), lo que ayuda a simplificar y acelerar el desarrollo de aplicaciones. Anteriormente habíamos mencionado que a través de las aplicaciones es como habitualmente se realizan los procesos de inserción, actualización, eliminación y consulta en una base de datos, el ORM permite a los desarrolladores simplificar esos procesos.  
Esta interacción es posible gracias a que las estructuras de la base de datos relacional se vinculan con las entidades lógicas del ORM, de tal modo que las acciones CRUD (Create, Read, Update, Delete) a ejecutar sobre la base de datos física se realizan de forma indirecta por medio del ORM. Lo anterior permite al desarrollador no generar de manera manual el código SQL, debido a que los objetos o entidades de la base de datos serán manipulados mediante el leguaje de programación en el cual se este desarrollado (Python, javascript, PHP, ect.) a través de métodos desarrollados en el ORM.  

-   Ejemplo para crear una tabla en ORM de Python.
```python
class Producto(db.Base):
  __tablename__ = 'producto'
    id = Column(Integer, primary_key=True)
    nombre = Column(String, nullable=False)
    precio = Column(Float)
  def __init__(self, nombre, precio):
    self.nombre = nombre
    self.precio = precio
  def __repr__(self):
    return f'Producto({self.nombre}, {self.precio})'
  def __str__(self):
    return self.nombre
```

- Ejemplo para agregar datos a una tabla en ORM de Python.

```python
def run():
arroz = Producto('Arroz', 1.25)
db.session.add(arroz)
print(arroz.id)
agua = Producto('Agua', 0.3)
db.session.add(agua)
db.session.commit()
print(arroz.id)
consulta = db.session.query(Producto)
ob = db.session.query(Producto).get(1)
productos = db.session.query(Producto).all()
num_productos = db.session.query(Producto).count()
agua = db.session.query(Producto).filter_by(nombre='Agua').first()
menos_de_1 = db.session.query(Producto).filter(Producto.precio < 1).all()
```