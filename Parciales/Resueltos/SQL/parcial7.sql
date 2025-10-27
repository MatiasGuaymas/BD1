/* 2da Fecha 4/12: MySQL
1. Considerando las propiedades ACID de las transacciones y priorizando que 
esto se cumpla, ¿es necesario usar transacciones cuando se ejecuta una 
sentencia UPDATE? Justifique su respuesta.

2. Explique 2 motivos por los cuales necesitaría definir una vista.

3. En una base de datos con las siguientes tablas:
CONTENIDO (#id_contenido, título, sinopsis)
VISUALIZACION (#id, timestamp, #id_contenido)
Hace falta crear un usuario para el frontend de la aplicación que sea capaz de 
obtener información sobre los contenidos y registrar visualizaciones (pero no 
consultarlas). ¿Qué permisos le asignaría a cada tabla, para maximizar 
la seguridad de la BD? */

/* 1. 
No es necesario usar transacciones explícitas para una única sentencia UPDATE, ya que por sí misma cumple las propiedades ACID.
Sin embargo, si forma parte de un conjunto de operaciones que deben mantenerse coherentes entre sí, entonces sí debe incluirse dentro de una transacción explícita.

2. 
- Abstracción y simplificación de consultas complejas: Usar una vista para ocultar la complejidad de consultas frecuentes (joins, agregaciones, filtros) y presentar una tabla virtual fácil de usar.
- Seguridad / control de acceso a los datos: Usar una vista para exponer solo las columnas o filas permitidas a ciertos usuarios, restringiendo el acceso a datos sensibles.

3.
-- Quitar todos los permisos
REVOKE ALL PRIVILEGES ON plataforma.VISUALIZACION FROM 'frontend_user'@'localhost';
REVOKE ALL PRIVILEGES ON plataforma.CONTENIDO FROM 'frontend_user'@'localhost';

-- Contenido -> SELECT | Visualizacion -> INSERT
GRANT SELECT ON plataforma.CONTENIDO TO 'frontend_user'@'localhost';
GRANT INSERT ON plataforma.VISUALIZACION TO 'frontend_user'@'localhost'; */
