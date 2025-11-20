# Proyecto-SQL

# Proyecto SQL: Análisis de Base de Datos de Videoclub 🎬
Este repositorio contiene el proyecto final del módulo de SQL. El objetivo principal ha sido actuar como analista de datos para una empresa de alquiler de películas, resolviendo una serie de preguntas de negocio mediante consultas a una base de datos relacional (basada en Sakila/ThePowerDB).

## 🛠️ Tecnologías utilizadas
* **Lenguaje:** SQL (PostgreSQL)
* **Herramienta de Gestión de BBDD:** DBeaver
* **Entorno:** Repositorio local y remoto (GitHub)

## 📂 Estructura del Repositorio
El proyecto consta de los siguientes archivos:
1.  **`PROYECTO CONSULTAS.sql`**: Archivo principal que contiene las **64 consultas** resueltas. Cada consulta está debidamente numerada y comentada con su enunciado original.
2.  **`Proyecto ThePower Diagrama.png`**: Diagrama Entidad-Relación (ERD) diseñado para visualizar la estructura de la base de datos, las tablas y sus relaciones (PK/FK).
3.  **`README.md`**: Este archivo, que sirve como documentación e informe del proyecto.

## 🚀 Pasos seguidos durante el proyecto
Para la realización de este análisis, se ha seguido una metodología estructurada:

1.  **Comprensión del Modelo de Datos:**
    * Se analizó el script de creación de la base de datos y se generó un **Diagrama Entidad-Relación (ERD)** para comprender las tablas principales (`film`, `actor`, `customer`, `rental`, `payment`, etc.) y cómo se relacionan entre sí.

2.  **Consultas Básicas y Filtrado:**
    * Se realizaron consultas de exploración a una sola tabla (`SELECT`, `FROM`) aplicando filtros específicos (`WHERE`) para segmentar películas por clasificación ('R', 'PG-13'), idioma y duración.

3.  **Agregación y Análisis Estadístico:**
    * Se utilizaron funciones de agregación (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `STDDEV`, `VARIANCE`) para extraer métricas clave, como la duración media de alquileres, ingresos totales y variabilidad de costos.

4.  **Relaciones entre Tablas (Joins):**
    * Se aplicaron cruces de tablas (`INNER JOIN`, `LEFT JOIN`, `CROSS JOIN`) para responder preguntas complejas que involucraban múltiples entidades (ej. *actores que participan en una categoría específica* o *clientes y sus alquileres*).

5.  **Consultas Avanzadas:**
    * Implementación de **Subconsultas** (en `WHERE` y `SELECT`) para filtros dinámicos.
    * Uso de **Vistas** (`CREATE VIEW`) para almacenar lógicas de consulta recurrentes.
    * Creación de **Tablas Temporales** para análisis intermedios y almacenamiento volátil de datos procesados.

## 📊 Informe de Análisis
A través de las 64 consultas realizadas, se han extraído los siguientes "insights" o conclusiones sobre el negocio:

### 1. Catálogo de Películas
* Hemos identificado películas con características específicas, como aquellas con clasificación 'R' o duraciones superiores a 3 horas, lo que permite segmentar el catálogo para diferentes públicos.
* Se analizaron los costos de reemplazo, calculando su variabilidad y desviación estándar para entender el riesgo financiero del inventario.

### 2. Actores y Participación
* Se ha rankeado a los actores según su nivel de actividad. Mediante la creación de vistas, identificamos a los actores más prolíficos y aquellos que trabajan en géneros específicos como 'Action' o 'Sci-Fi'.
* Detectamos actores que, a pesar de estar en la base de datos, no tienen películas asignadas (usando `LEFT JOIN` y filtrado de nulos).

### 3. Comportamiento de Clientes
* **Top Clientes:** Se identificaron los 5 clientes que más ingresos han generado para la empresa.
* **Frecuencia de Alquiler:** Se clasificaron los clientes según el volumen de alquileres (ej. clientes con más de 7 alquileres distintos) y se analizaron sus hábitos de consumo por fecha.

### 4. Operaciones y Alquileres
* Se monitorizaron los alquileres no devueltos (ej. caso 'Tammy Sanders'), lo cual es crítico para la gestión de pérdidas.
* Se calculó el volumen de negocio agrupado por categorías de películas (siendo 'Action' y 'Animation' categorías clave) y por periodos de tiempo (estrenos de 2006).

---
*Proyecto realizado como parte del Bootcamp de Data Analytics.*
