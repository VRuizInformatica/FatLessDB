# FatLessDB

> Base de datos **abierta** de recetas saludables en Español, con macronutrientes por ingrediente y receta.

![FatLessDB banner](https://img.shields.io/badge/version-1.0-brightgreen)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)

---

## Tabla de contenidos

1. [¿Qué es FatLessDB?](#qué-es-fatlessdb)
2. [Características principales](#características-principales)
3. [Estructura de la base de datos](#estructura-de-la-base-de-datos)
4. [Procedimientos almacenados](#procedimientos-almacenados)
5. [Instalación y uso](#instalación-y-uso)
6. [Ejemplo rápido](#ejemplo-rápido)
7. [Licencia](#licencia)
8. [Contribuir](#contribuir)

---

## ¿Qué es FatLessDB?

**FatLessDB** es una base de datos relacional gratuita y de código abierto diseñada para almacenar recetas de alimentos saludables junto con sus valores nutricionales detallados (macros). Proporciona un esquema normalizado que facilita el cálculo y la consulta de calorías, proteínas, carbohidratos y grasas tanto a nivel de ingrediente como de receta.

Su objetivo es impulsar proyectos de nutrición, aplicaciones de seguimiento de dieta y análisis de datos alimentarios, eliminando las barreras de acceso a datasets completos y rigurosos.

---

## Características principales

* **Diseño relacional robusto**: tablas normalizadas que evitan duplicidad y refuerzan la integridad.
* **Macros por receta**: cálculo automático de calorías y macronutrientes sumando los ingredientes vinculados.
* **Clasificación flexible**: cada receta puede pertenecer a una *categoría* (p. ej. "Quesos", "Verduras") y a un *tipo* de plato (p. ej. "Entrante", "Principal").
* **Unidades estándar**: soporte para gramos, mililitros, cucharadas, etc., con posibilidad de conversión mediante `factor_gramos`.
* **Procedimientos almacenados seguros**: `InsertarIngredienteEnReceta` agiliza la carga y valida consistencia.
* **Dataset extensible**: añade nuevas recetas, ingredientes o campos nutricionales sin romper el modelo.

---

## Estructura de la base de datos

| Tabla                 | Descripción breve                                                   |
| --------------------- | ------------------------------------------------------------------- |
| `recetas`             | Cabecera de cada plato; guarda descripción y macros totales.        |
| `ingredientes`        | Diccionario maestro con valores nutricionales por 100 g.            |
| `categorias`          | Etiquetas amplias como **Setas**, **Carne**, **Quesos**.            |
| `tipos`               | Momento o formato: **Acompañamiento**, **Entrante**, **Principal**. |
| `unidades`            | Abreviatura + factor de conversión (g, kg, ml, l, unidad, etc.).    |
| `receta_ingredientes` | Relación N‑a‑N entre recetas e ingredientes, con cantidad y unidad. |

> **Nota**: el script incluye índices, claves foráneas y *triggers* opcionales para mantener la integridad y el rendimiento.

---

## Procedimientos almacenados

### `InsertarIngredienteEnReceta`

Inserta un ingrediente en una receta y actualiza automáticamente los macros. Valida:

1. Que la receta exista.
2. Que el ingrediente exista.
3. Que la unidad sea válida.

Si alguna condición falla lanza `SIGNAL SQLSTATE '45000'` con un mensaje descriptivo.

```sql
CALL InsertarIngredienteEnReceta(
  'Pizza de Cabrales, Pera y Jamón', -- nombre_receta
  'Queso Cabrales',                  -- nombre_ingrediente
  40,                                -- cantidad
  'g'                                -- unidad
);
```

---

## Instalación y uso

1. **Clona el repositorio**

   ```bash
   git clone https://github.com/VRuizInformatica/FatLessDB
   cd FatLessDB
   ```
2. **Ejecuta la creación de la base de datos** (MySQL 8 recomendado):

   ```bash
   mysql -u usuario -p < sql/Script.sql
   ```

---

## Ejemplo rápido

Supón que quieres almacenar *Ensalada de Quinoa* con quinoa y tomate:

```sql
-- 1️⃣ Insertamos la receta
INSERT INTO recetas (nombre, descripcion, categoria_id, tipo_id)
VALUES ('Ensalada de Quinoa', 'Ensalada fresca con quinoa y vegetales', 8, 2);

-- 2️⃣ Añadimos ingredientes (suponiendo IDs de unidad y de ingrediente definidos)
CALL InsertarIngredienteEnReceta('Ensalada de Quinoa', 'Quinoa', 100, 'g');
CALL InsertarIngredienteEnReceta('Ensalada de Quinoa', 'Tomate', 50, 'g');

-- 3️⃣ Consultamos macros totales
SELECT nombre, calorias, proteinas, carbohidratos, grasas
FROM recetas WHERE nombre = 'Ensalada de Quinoa';
```

---

## Licencia

Este proyecto está licenciado bajo la **MIT License**. Consulta el archivo [LICENSE](LICENSE) para más información.

## Contribuir

1. Haz un **fork** del repositorio.
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y envía un *pull request*.
4. Sigue la guía de estilo SQL incluida.

Los *issues* son bienvenidos para reportar errores o proponer mejoras.

---

> **FatLessDB**: Datos abiertos y saludables para proyectos que importan. 🍏
