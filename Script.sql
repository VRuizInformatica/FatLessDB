/*******************************************************************************
  1) CREAR BASE DE DATOS Y USARLA
*******************************************************************************/

CREATE DATABASE IF NOT EXISTS FatlessDB;
USE FatlessDB;


/*******************************************************************************
  2) CREAR TABLAS: categorias, tipos, ingredientes, recetas, receta_ingredientes
*******************************************************************************/

-- Tabla de categorías
CREATE TABLE IF NOT EXISTS categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (nombre)
);

-- Tabla de tipos
CREATE TABLE IF NOT EXISTS tipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (nombre)
);

-- Tabla de ingredientes
CREATE TABLE IF NOT EXISTS ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    calorias INT DEFAULT 0,
    proteinas DECIMAL(6,2) DEFAULT 0.00,
    fibra DECIMAL(6,2) DEFAULT 0.00,
    carbohidratos DECIMAL(6,2) DEFAULT 0.00,
    grasas DECIMAL(6,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY (nombre)
);

-- Tabla de recetas
CREATE TABLE IF NOT EXISTS recetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    calorias INT,
    proteinas DECIMAL(6,2),
    fibra DECIMAL(6,2),
    carbohidratos DECIMAL(6,2),
    grasas DECIMAL(6,2),
    categoria_id INT NOT NULL,
    tipo_id INT NOT NULL,
    porciones INT NOT NULL DEFAULT 1,
    tiempo_preparacion INT,
    dificultad ENUM('Fácil','Media','Difícil') NOT NULL DEFAULT 'Fácil',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (tipo_id) REFERENCES tipos(id)
);

-- Tabla intermedia para recetas vs ingredientes
CREATE TABLE IF NOT EXISTS receta_ingredientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receta_id INT NOT NULL,
    ingrediente_id INT NOT NULL,
    cantidad DECIMAL(10,2) DEFAULT 1.00,
    unidad VARCHAR(50) NOT NULL DEFAULT 'unidad',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (receta_id) REFERENCES recetas(id),
    FOREIGN KEY (ingrediente_id) REFERENCES ingredientes(id),
    UNIQUE KEY (receta_id, ingrediente_id)
);


/*******************************************************************************
  3) INSERCIÓN BÁSICA EN: categorias, tipos
     - Mapearemos: 
         • categoria_id = 1 => "Setas"
         • tipo_id = 1 => "Acompañamiento"
         • tipo_id = 2 => "Entrante"
         • tipo_id = 3 => "Principal"
*******************************************************************************/

/* Insertar la categoría "Setas" */
INSERT INTO categorias (nombre)
VALUES 
  ('Setas'),
  ('Carne'),
  ('Cordero'),
  ('Conejo'),
  ('Cerdo'),
  ('Aves'),
  ('Pescado'),
  ('Verduras'),
  ('Embutidos'),
  ('Frutas'),
  ('Quesos');


/* Insertar los tipos más comunes para estas recetas */
INSERT INTO tipos (nombre)
VALUES ('Acompañamiento'), ('Entrante'), ('Principal');



/*******************************************************************************
  4) INSERCIÓN DE RECETAS
     - Mapeamos:
       categoria_id:
         1 => Setas
         2 => Carne
         3 => Cordero
         4 => Conejo
         5 => Cerdo
         6 => Aves
         7 => Pescado
         8 => Verduras
         9 => Embutidos
        10 => Frutas
        11 => Quesos

       tipo_id:
         1 => Acompañamiento
         2 => Entrante
         3 => Principal
*******************************************************************************/

INSERT INTO recetas (
  nombre,
  descripcion,
  calorias,
  proteinas,
  fibra,
  carbohidratos,
  grasas,
  categoria_id,
  tipo_id
) VALUES

-- SETAS
  ('Setas Salteadas con Ajo y Perejil',
   'Setas salteadas con ajo fresco y perejil, perfectas como acompañamiento',
   90, 3, 2, 5, 4,
   1, 1),

  ('Crema de Setas Saludable',
   'Crema suave de setas sin nata, ideal para una comida ligera',
   120, 4, 3, 10, 5,
   1, 2),

  ('Pizza Integral de Setas y Espinacas',
   'Pizza con base integral, cubierta de setas, espinacas frescas y queso bajo en grasa',
   280, 12, 4, 30, 10,
   1, 3),

  ('Revuelto de Setas con Tofu',
   'Revuelto de tofu y setas con especias, alto en proteínas',
   150, 10, 3, 8, 7,
   1, 3),

  ('Ensalada de Setas y Espárragos',
   'Ensalada fresca de setas, espárragos y rúcula con aliño ligero',
   100, 3, 4, 8, 3,
   1, 2),

  ('Setas al Horno con Limón y Romero',
   'Setas horneadas con limón y romero, sin aceites añadidos',
   80, 2, 3, 6, 2,
   1, 1),

  ('Risotto de Setas y Espárragos',
   'Risotto cremoso con setas y espárragos, ideal para una cena elegante',
   250, 6, 3, 40, 8,
   1, 3),

  ('Setas en Salsa de Vino Blanco',
   'Setas cocinadas en salsa de vino blanco y hierbas frescas',
   110, 2, 2, 5, 6,
   1, 1),

  ('Brochetas de Setas y Verduras',
   'Brochetas de setas y verduras variadas a la parrilla',
   130, 4, 3, 12, 5,
   1, 3),

  ('Setas al Ajillo',
   'Setas frescas salteadas con ajo y perejil',
   90, 3, 2, 5, 4,
   1, 1),

-- (CARNE: categoria_id=2, tipo_id=3 = Principal)
  ('Filete de Ternera a la Parrilla con Espárragos',
   'Filete de ternera a la parrilla acompañado de espárragos frescos',
   250, 26, 2, 5, 12,
   2, 3),

  ('Stir Fry de Ternera con Verduras',
   'Salteado de ternera con pimientos, zanahorias y brócoli',
   220, 22, 4, 10, 9,
   2, 3),

  ('Hamburguesas de Ternera en Pan Integral',
   'Hamburguesas de ternera a la parrilla servidas en pan integral',
   300, 28, 3, 20, 15,
   2, 3),

  ('Carne de Ternera con Verduras al Horno',
   'Ternera al horno con mezcla de verduras frescas',
   280, 24, 5, 12, 14,
   2, 3),

  ('Guiso de Ternera con Champiñones',
   'Guiso caliente de ternera con champiñones y patatas',
   270, 25, 4, 12, 10,
   2, 3),

  ('Ternera en Salsa de Mostaza y Miel',
   'Ternera cocida en salsa de mostaza y miel',
   260, 24, 2, 8, 11,
   2, 3),

  ('Albóndigas de Ternera con Tomate',
   'Albóndigas de ternera en salsa de tomate casera',
   290, 23, 3, 15, 16,
   2, 3),

  ('Carne de Ternera a la Plancha con Ensalada',
   'Ternera a la plancha servida con ensalada fresca',
   240, 26, 3, 5, 9,
   2, 3),

  ('Estofado de Ternera con Verduras',
   'Estofado de ternera cocido lentamente con verduras',
   250, 22, 6, 10, 8,
   2, 3),

  ('Bistec de Ternera a la Parrilla',
   'Bistec de ternera a la parrilla con sal, pimienta y romero',
   210, 26, 0, 2, 12,
   2, 3),

-- (CORDERO: categoria_id=3, tipo_id=3 = Principal)
  ('Asado de Ternasco al Horno con Hierbas',
   'Ternasco al horno con hierbas aromáticas',
   500, 30, 5, 15, 20,
   3, 3),

  ('Ternasco a la Parrilla con Limón y Romero',
   'Ternasco a la parrilla con limón fresco y romero',
   270, 23, 0, 1, 20,
   3, 3),

  ('Estofado de Ternasco con Patatas y Verduras',
   'Guiso de ternasco con patatas, zanahorias y guisantes',
   180, 15, 3, 10, 9,
   3, 3),

  ('Brochetas de Ternasco con Pimientos',
   'Brochetas a la parrilla de ternasco y pimientos',
   240, 22, 2, 4, 15,
   3, 3),

  ('Ragú de Ternasco con Tomate',
   'Ternasco en salsa de tomate con especias italianas',
   200, 18, 1, 5, 12,
   3, 3),

  ('Ternasco a la Mostaza con Puré de Zanahorias',
   'Ternasco al horno con salsa de mostaza y puré de zanahorias',
   230, 20, 3, 8, 14,
   3, 3),

  ('Costillas de Ternasco a la Barbacoa',
   'Costillas de ternasco en salsa barbacoa a la parrilla',
   290, 24, 0, 2, 20,
   3, 3),

  ('Ternasco a la Plancha con Ensalada Mediterránea',
   'Ternasco a la plancha con ensalada de tomate, pepino y aceitunas',
   200, 22, 2, 6, 10,
   3, 3),

  ('Ternasco Guisado con Garbanzos',
   'Guiso de ternasco con garbanzos cocido lentamente',
   220, 18, 5, 10, 12,
   3, 3),

  ('Ternasco al Ajillo',
   'Ternasco cocinado al ajillo con perejil fresco',
   250, 22, 1, 3, 17,
   3, 3),

-- (CONEJO: categoria_id=4, tipo_id=3 = Principal)
  ('Conejo al Ajillo',
   'Conejo cocinado al ajillo con vino blanco',
   150, 22, 1, 3, 7,
   4, 3),

  ('Conejo a la Cazadora',
   'Conejo guisado con tomate, cebolla y pimientos',
   200, 25, 2, 10, 8,
   4, 3),

  ('Conejo Asado con Romero',
   'Conejo asado con hierbas aromáticas',
   180, 28, 1, 4, 6,
   4, 3),

  ('Estofado de Conejo con Patatas',
   'Estofado de conejo con patatas, zanahorias y vino tinto',
   250, 22, 4, 25, 7,
   4, 3),

  ('Conejo al Horno con Verduras',
   'Conejo al horno con cebolla, zanahorias y pimientos',
   220, 26, 3, 12, 9,
   4, 3),

  ('Conejo a la Mostaza',
   'Conejo en salsa cremosa de mostaza',
   210, 25, 2, 8, 12,
   4, 3),

  ('Conejo con Setas',
   'Conejo cocinado con setas y vino blanco',
   180, 24, 2, 5, 9,
   4, 3),

  ('Conejo en Salsa de Vino',
   'Conejo en salsa de vino tinto',
   230, 27, 1, 8, 10,
   4, 3),

  ('Conejo con Tomate y Albahaca',
   'Guiso de conejo con tomate y albahaca',
   190, 26, 2, 6, 7,
   4, 3),

  ('Conejo en Salsa de Mostaza y Miel',
   'Conejo en salsa de mostaza y miel',
   240, 28, 2, 9, 10,
   4, 3),

-- (CERDO: categoria_id=5, tipo_id=3 = Principal)
  ('Lomo de Cerdo Asado con Manzanas',
   'Lomo de cerdo asado con salsa de manzanas y especias',
   250, 30, 2, 12, 10,
   5, 3),

  ('Costillas de Cerdo a la Barbacoa',
   'Costillas de cerdo en salsa barbacoa a la parrilla',
   320, 28, 1, 20, 20,
   5, 3),

  ('Cerdo a la Cazadora',
   'Cerdo guisado con tomate, cebolla y zanahorias',
   280, 25, 3, 18, 15,
   5, 3),

  ('Chuletas de Cerdo a la Parrilla',
   'Chuletas de cerdo a la parrilla con especias y ajo',
   250, 27, 1, 3, 15,
   5, 3),

  ('Cerdo en Salsa de Mostaza',
   'Cerdo en salsa cremosa de mostaza y miel',
   270, 30, 2, 6, 15,
   5, 3),

  ('Cerdo a la Plancha con Ensalada',
   'Cerdo a la plancha con ensalada fresca',
   220, 30, 3, 5, 10,
   5, 3),

  ('Estofado de Cerdo con Verduras',
   'Estofado de cerdo con zanahorias, cebolla y pimientos',
   280, 28, 5, 18, 15,
   5, 3),

  ('Cerdo en Salsa de Vino Blanco',
   'Cerdo en salsa de vino blanco con cebolla y hierbas',
   230, 28, 1, 7, 12,
   5, 3),

  ('Cerdo al Horno con Romero y Ajo',
   'Cerdo al horno con hierbas aromáticas y ajo',
   270, 30, 2, 8, 14,
   5, 3),

  ('Albóndigas de Cerdo con Salsa de Tomate',
   'Albóndigas de cerdo en salsa de tomate con especias italianas',
   220, 24, 3, 15, 12,
   5, 3),

-- (AVES: categoria_id=6)
  ('Pollo al Horno con Limón y Hierbas',
   'Pollo al horno con limón, ajo y hierbas aromáticas',
   230, 30, 2, 5, 10,
   6, 3),

  ('Pechugas de Pollo a la Parrilla',
   'Pechugas de pollo marinadas y a la parrilla',
   180, 35, 1, 0, 6,
   6, 3),

  ('Pollo al Curry con Arroz',
   'Pollo en salsa cremosa de curry con arroz',
   350, 28, 4, 45, 10,
   6, 3),

  ('Pollo en Salsa de Tomate',
   'Pollo en salsa de tomate con especias italianas',
   270, 30, 3, 12, 8,
   6, 3),

  ('Pollo a la Plancha con Ensalada',
   'Pechugas de pollo a la plancha con ensalada fresca',
   200, 30, 3, 5, 8,
   6, 3),

  ('Pollo a la Barbacoa',
   'Pollo a la parrilla con salsa barbacoa',
   320, 30, 1, 20, 18,
   6, 3),

  ('Pollo al Ajillo',
   'Pollo con ajo, aceite de oliva y hierbas',
   260, 28, 2, 3, 15,
   6, 3),

  ('Pollo en Salsa de Mostaza',
   'Pollo en salsa cremosa de mostaza y miel',
   280, 30, 2, 10, 14,
   6, 3),

  ('Tacos de Pollo',
   'Pollo desmenuzado en tacos con cebolla, cilantro y salsa',
   280, 28, 5, 30, 12,
   6, 3),

  ('Pollo a la Naranja',
   'Pollo en salsa dulce de naranja',
   250, 30, 1, 18, 10,
   6, 3),

  ('Pavo a la Plancha con Limón y Ajo',
   'Pechuga de pavo a la plancha con limón, ajo y especias',
   230, 30, 1, 4, 12,
   6, 3),

  ('Albóndigas de Pavo con Tomate',
   'Albóndigas de pavo en salsa de tomate casera',
   350, 28, 4, 18, 22,
   6, 3),

  ('Ensalada de Pavo y Aguacate',
   'Ensalada con pavo, aguacate, tomate y lechuga',
   320, 35, 6, 14, 18,
   6, 2),

  ('Tacos de Pavo con Guacamole',
   'Tacos de pavo con guacamole, cebolla morada y cilantro',
   280, 22, 5, 24, 15,
   6, 3),

  ('Pavo al Horno con Verduras',
   'Pechuga de pavo al horno con zanahorias, patatas y cebolla',
   400, 45, 8, 30, 20,
   6, 3),

  ('Pavo a la Barbacoa',
   'Pechuga de pavo a la parrilla con salsa barbacoa casera',
   350, 30, 2, 20, 18,
   6, 3),

  ('Estofado de Pavo con Verduras',
   'Estofado de pavo con zanahorias, patatas y guisantes',
   330, 35, 7, 22, 15,
   6, 3),

  ('Pavo al Curry con Arroz Integral',
   'Pavo en salsa de curry con arroz integral',
   450, 40, 6, 45, 15,
   6, 3),

  ('Pavo en Salsa de Mostaza',
   'Pavo en salsa cremosa de mostaza y miel',
   380, 35, 4, 12, 22,
   6, 3),

  ('Hamburguesas de Pavo con Espinacas',
   'Hamburguesas de pavo con espinacas y cebolla a la plancha',
   300, 30, 5, 10, 18,
   6, 3),

  -- VERDEL
  ('Verdel a la Parrilla con Limón y Aceite de Oliva',
   'Verdel a la parrilla con limón, aceite de oliva, sal y pimienta',
   200, 22, 0, 1, 12, 7, 3),
  ('Verdel al Horno con Hierbas Aromáticas',
   'Verdel al horno con tomillo, romero y toque de ajo',
   210, 23, 1, 2, 13, 7, 3),
  ('Verdel en Salsa de Tomate',
   'Verdel en salsa de tomate natural, ajo y albahaca',
   250, 24, 2, 6, 15, 7, 3),
  ('Verdel con Pesto de Albahaca y Piñones',
   'Verdel a la parrilla con pesto fresco de albahaca y piñones',
   270, 25, 3, 7, 17, 7, 3),
  ('Verdel al Vapor con Verduras',
   'Verdel al vapor con zanahorias, calabacines y espárragos',
   230, 23, 3, 8, 10, 7, 3),
  ('Verdel con Salsa de Mostaza y Miel',
   'Verdel a la parrilla con salsa de mostaza, miel y limón',
   260, 27, 1, 5, 15, 7, 3),
  ('Verdel al Horno con Papas y Romero',
   'Verdel al horno con papas asadas, romero y aceite de oliva',
   280, 26, 4, 28, 16, 7, 3),
  ('Verdel con Arroz Integral',
   'Verdel a la plancha con arroz integral',
   300, 28, 5, 35, 14, 7, 3),
  ('Verdel con Salsa de Ajo y Vino Blanco',
   'Verdel a la parrilla con salsa de ajo, vino blanco y perejil',
   240, 25, 2, 4, 12, 7, 3),
  ('Verdel a la Cazuela con Pimientos',
   'Verdel en cazuela con pimientos, cebolla y tomate',
   260, 27, 3, 9, 14, 7, 3),

  -- TRUCHA
  ('Trucha a la Plancha con Limón y Aceite de Oliva',
   'Trucha a la plancha con limón, aceite de oliva, sal y pimienta',
   210, 22, 0, 1, 13, 7, 3),
  ('Trucha al Horno con Hierbas Aromáticas',
   'Trucha al horno con romero, tomillo y limón',
   230, 24, 1, 4, 14, 7, 3),
  ('Trucha con Salsa de Almendras',
   'Trucha con salsa de almendras tostadas y toque de ajo',
   250, 25, 2, 6, 16, 7, 3),
  ('Trucha a la Parrilla con Salsa de Mostaza y Miel',
   'Trucha a la parrilla con salsa de mostaza, miel y limón',
   260, 27, 0, 8, 15, 7, 3),
  ('Trucha al Vapor con Verduras',
   'Trucha al vapor con zanahorias, calabacines y espárragos',
   220, 23, 3, 10, 10, 7, 3),
  ('Trucha con Arroz Integral y Espinacas',
   'Trucha con arroz integral y espinacas salteadas',
   280, 27, 5, 30, 14, 7, 3),
  ('Trucha con Salsa de Limón y Alcaparras',
   'Trucha con salsa de limón, alcaparras y perejil fresco',
   240, 26, 1, 3, 14, 7, 3),
  ('Trucha con Pesto de Albahaca',
   'Trucha a la parrilla con pesto fresco de albahaca',
   270, 28, 3, 6, 17, 7, 3),
  ('Trucha al Curry con Arroz Basmati',
   'Trucha al curry con arroz basmati y especias',
   290, 28, 4, 35, 12, 7, 3),
  ('Trucha con Salsa de Tomate y Albahaca',
   'Trucha en salsa de tomate natural y albahaca fresca',
   260, 27, 3, 9, 15, 7, 3),

  -- SARGO
  ('Sargo a la Plancha con Aceite de Oliva y Ajo',
   'Sargo a la plancha con aceite de oliva, ajo picado y limón',
   220, 23, 0, 1, 14, 7, 3),
  ('Sargo al Horno con Hierbas Provenzales',
   'Sargo al horno con hierbas provenzales, aceite de oliva y limón',
   240, 25, 1, 4, 14, 7, 3),
  ('Sargo a la Parrilla con Salsa de Manteca de Cerdo',
   'Sargo a la parrilla con salsa ligera de manteca de cerdo y especias',
   260, 28, 0, 2, 16, 7, 3),
  ('Sargo al Vapor con Limón y Ajo',
   'Sargo al vapor con limón, ajo picado y perejil',
   200, 22, 0, 0, 12, 7, 3),
  ('Sargo con Ensalada de Hortalizas',
   'Sargo a la parrilla con ensalada de hortalizas variadas',
   280, 26, 4, 20, 16, 7, 3),
  ('Sargo con Salsa de Tomate y Albahaca',
   'Sargo con salsa de tomate, albahaca y ajo',
   250, 27, 2, 9, 15, 7, 3),
  ('Sargo al Horno con Papas y Pimientos',
   'Sargo al horno con papas asadas y pimientos',
   300, 29, 4, 25, 18, 7, 3),
  ('Sargo con Arroz Integral y Espinacas',
   'Sargo a la parrilla con arroz integral y espinacas salteadas',
   350, 30, 6, 38, 16, 7, 3),
  ('Sargo en Salsa de Vino Blanco',
   'Sargo en salsa de vino blanco con cebolla, ajo y perejil',
   230, 24, 2, 5, 14, 7, 3),
  ('Sargo con Pesto de Albahaca',
   'Sargo a la parrilla con pesto de albahaca, piñones y parmesano',
   280, 26, 3, 7, 18, 7, 3),

  -- SARDINAS
  ('Sardinas a la Plancha con Limón y Ajo',
   'Sardinas a la plancha con ajo, limón y aceite de oliva',
   210, 24, 0, 1, 12, 7, 3),
  ('Sardinas al Horno con Tomate y Albahaca',
   'Sardinas al horno con tomate, albahaca y aceite de oliva',
   240, 26, 2, 5, 14, 7, 3),
  ('Ensalada de Sardinas y Garbanzos',
   'Sardinas asadas con garbanzos, cebolla y pimientos',
   280, 30, 6, 22, 15, 7, 3),
  ('Sardinas a la Parrilla con Salsa de Mostaza y Miel',
   'Sardinas a la parrilla con salsa de mostaza y miel',
   270, 28, 1, 9, 16, 7, 3),
  ('Sardinas Fritas con Ensalada de Tomate',
   'Sardinas fritas con ensalada de tomate y pepino',
   350, 28, 3, 12, 22, 7, 3),
  ('Sardinas con Pimientos y Calabacín',
   'Sardinas a la plancha con pimientos y calabacín',
   290, 26, 4, 10, 18, 7, 3),
  ('Sardinas con Puré de Patatas y Ensalada',
   'Sardinas a la plancha con puré de patatas y ensalada verde',
   330, 30, 4, 25, 18, 7, 3),
  ('Sardinas al Horno con Limón y Romero',
   'Sardinas al horno con limón y romero',
   240, 26, 1, 5, 14, 7, 3),
  ('Sardinas con Ensalada de Quinoa',
   'Sardinas a la parrilla con ensalada de quinoa, pepino y tomate',
   320, 30, 6, 28, 18, 7, 3),
  ('Sardinas en Salsa de Tomate Picante',
   'Sardinas en salsa de tomate picante con cebolla y guindilla',
   270, 26, 2, 9, 16, 7, 3),

  -- SALMÓNETE
  ('Salmónete a la Plancha con Ajo y Limón',
   'Salmónete a la plancha con ajo, limón y aceite de oliva',
   220, 25, 0, 2, 12, 7, 3),
  ('Salmónete al Horno con Tomate y Albahaca',
   'Salmónete al horno con tomate, albahaca y aceite de oliva',
   250, 28, 1, 6, 14, 7, 3),
  ('Salmónete a la Parrilla con Salsa de Mostaza y Miel',
   'Salmónete a la parrilla con salsa de mostaza y miel',
   270, 30, 1, 8, 15, 7, 3),
  ('Ensalada de Salmónete y Espárragos',
   'Ensalada de salmónete a la parrilla con espárragos y aguacate',
   280, 26, 5, 9, 16, 7, 3),
  ('Salmónete con Puré de Patata y Ensalada de Lechuga',
   'Salmónete a la plancha con puré de patata y ensalada de lechuga',
   320, 30, 3, 25, 18, 7, 3),
  ('Salmónete en Salsa de Vino Blanco',
   'Salmónete en salsa de vino blanco con cebolla y ajo',
   250, 28, 1, 7, 12, 7, 3),
  ('Salmónete Frito con Patatas',
   'Salmónete frito con patatas',
   350, 30, 2, 18, 20, 7, 3),
  ('Salmónete con Salsa de Limón y Eneldo',
   'Salmónete a la plancha con salsa de limón, eneldo y aceite de oliva',
   240, 27, 1, 4, 13, 7, 3),
  ('Salmónete con Verduras al Horno',
   'Salmónete al horno con verduras como zanahorias, calabacines y pimientos',
   300, 28, 5, 15, 18, 7, 3),
  ('Salmónete con Ensalada de Quinoa y Aguacate',
   'Salmónete a la parrilla con ensalada de quinoa, aguacate, tomate y pepino',
   320, 30, 6, 20, 18, 7, 3),

  -- SALMÓN
  ('Salmón a la Parrilla con Limón y Eneldo',
   'Salmón a la parrilla con limón, eneldo y aceite de oliva',
   280, 30, 0, 2, 18, 7, 3),
  ('Salmón al Horno con Miel y Mostaza',
   'Salmón horneado con miel, mostaza y ajo',
   300, 32, 1, 9, 17, 7, 3),
  ('Ensalada de Salmón Ahumado y Aguacate',
   'Ensalada con salmón ahumado, aguacate, espinacas y cebolla morada',
   320, 22, 6, 8, 20, 7, 3),
  ('Salmón con Salsa de Limón y Alcaparras',
   'Salmón a la plancha con salsa de limón y alcaparras',
   290, 32, 1, 4, 15, 7, 3),
  ('Salmón con Puré de Patata y Espárragos',
   'Salmón al horno con puré de patata y espárragos a la parrilla',
   350, 35, 3, 18, 20, 7, 3),
  ('Salmón en Salsa de Vino Blanco y Ajo',
   'Salmón en salsa de vino blanco, ajo y perejil',
   270, 32, 1, 6, 15, 7, 3),
  ('Salmón a la Parrilla con Ensalada de Quinoa',
   'Salmón a la parrilla con ensalada de quinoa, pepino y tomate',
   320, 34, 5, 18, 15, 7, 3),
  ('Salmón al Horno con Tomate y Albahaca',
   'Salmón al horno con tomate, albahaca y aceite de oliva',
   280, 30, 2, 7, 16, 7, 3),
  ('Salmón en Salsa Teriyaki',
   'Salmón en salsa teriyaki con arroz integral',
   330, 35, 3, 15, 18, 7, 3),
  ('Salmón con Espinacas Salteadas y Almendras',
   'Salmón a la plancha con espinacas salteadas y almendras',
   290, 30, 4, 5, 18, 7, 3),

  -- RODABALLO
  ('Rodaballo a la Parrilla con Limón y Ajo',
   'Rodaballo a la parrilla con limón, ajo y aceite de oliva',
   230, 30, 0, 3, 12, 7, 3),
  ('Rodaballo al Horno con Tomate y Albahaca',
   'Rodaballo al horno con tomate, cebolla y albahaca',
   250, 32, 2, 7, 14, 7, 3),
  ('Rodaballo en Salsa de Mostaza y Miel',
   'Rodaballo en salsa de mostaza y miel',
   270, 33, 1, 10, 15, 7, 3),
  ('Rodaballo con Salsa de Vino Blanco y Ajo',
   'Rodaballo en salsa de vino blanco, ajo y perejil',
   260, 32, 1, 6, 14, 7, 3),
  ('Rodaballo a la Plancha con Espárragos',
   'Rodaballo a la plancha con espárragos grillados',
   240, 31, 3, 5, 13, 7, 3),
  ('Rodaballo al Horno con Pimientos',
   'Rodaballo al horno con pimientos, cebolla y ajo',
   280, 34, 4, 15, 14, 7, 3),
  ('Rodaballo con Salsa de Ajo y Perejil',
   'Rodaballo en salsa de ajo, perejil y aceite de oliva',
   250, 32, 1, 5, 15, 7, 3),
  ('Rodaballo en Salsa de Piquillos',
   'Rodaballo en salsa de pimientos del piquillo y cebolla',
   270, 33, 2, 9, 16, 7, 3),
  ('Rodaballo con Ensalada de Tomate y Albahaca',
   'Rodaballo con ensalada de tomate, albahaca y cebolla',
   230, 30, 2, 6, 12, 7, 3),
  ('Rodaballo al Horno con Limón y Romero',
   'Rodaballo al horno con limón, romero y aceite de oliva',
   240, 31, 1, 4, 13, 7, 3),

  -- PEZ ESPADA
  ('Pez Espada a la Parrilla con Ajo y Limón',
   'Pez espada a la parrilla con ajo, limón y aceite de oliva',
   220, 28, 0, 2, 14, 7, 3),
  ('Pez Espada al Horno con Tomate y Albahaca',
   'Pez espada al horno con tomate y albahaca',
   250, 30, 1, 8, 12, 7, 3),
  ('Pez Espada en Salsa de Naranja y Miel',
   'Pez espada en salsa de naranja y miel',
   270, 32, 1, 10, 15, 7, 3),
  ('Pez Espada con Ensalada de Mango y Aguacate',
   'Pez espada con ensalada de mango, aguacate y cebolla roja',
   290, 32, 4, 18, 14, 7, 3),
  ('Pez Espada a la Plancha con Espárragos',
   'Pez espada a la plancha con espárragos al grill',
   240, 30, 2, 5, 13, 7, 3),
  ('Pez Espada con Salsa de Vino Blanco y Ajo',
   'Pez espada en salsa de vino blanco, ajo y perejil',
   260, 31, 2, 7, 15, 7, 3),
  ('Pez Espada a la Parrilla con Pimientos Asados',
   'Pez espada a la parrilla con pimientos asados',
   230, 29, 2, 8, 12, 7, 3),
  ('Pez Espada con Salsa de Tomate y Albahaca',
   'Pez espada en salsa de tomate y albahaca',
   250, 31, 3, 12, 14, 7, 3),
  ('Pez Espada con Verduras al Horno',
   'Pez espada horneado con verduras al horno',
   280, 32, 4, 15, 14, 7, 3),
  ('Pez Espada con Salsa de Mostaza y Miel',
   'Pez espada en salsa de mostaza y miel',
   260, 31, 1, 8, 15, 7, 3),

  -- PARGO
  ('Pargo a la Parrilla con Ajo y Limón',
   'Pargo a la parrilla con ajo, limón y un toque de aceite de oliva',
   240, 30, 0, 2, 14, 7, 3),
  ('Pargo al Horno con Hierbas',
   'Pargo al horno con una mezcla de hierbas frescas, aceite de oliva y un toque de sal',
   250, 31, 1, 3, 15, 7, 3),
  ('Pargo en Salsa de Naranja y Miel',
   'Pargo cocinado en una salsa dulce de naranja y miel',
   270, 32, 1, 10, 14, 7, 3),
  ('Pargo a la Plancha con Ensalada de Tomate',
   'Pargo a la plancha acompañado de una fresca ensalada de tomate y albahaca',
   220, 28, 2, 6, 12, 7, 3),
  ('Pargo en Salsa de Vino Blanco y Ajo',
   'Pargo en salsa de vino blanco con ajo y perejil',
   260, 31, 2, 7, 15, 7, 3),
  ('Pargo al Horno con Papas y Cebolla',
   'Pargo al horno acompañado de papas y cebolla asadas',
   300, 32, 4, 35, 16, 7, 3),
  ('Pargo con Salsa de Tomate y Albahaca',
   'Pargo en salsa de tomate fresco con albahaca y ajo',
   280, 30, 3, 15, 14, 7, 3),
  ('Pargo al Grill con Espárragos',
   'Pargo a la parrilla acompañado de espárragos frescos al grill',
   240, 30, 2, 5, 12, 7, 3),
  ('Pargo con Ensalada de Mango y Aguacate',
   'Pargo servido con una ensalada fresca de mango, aguacate y pepino',
   290, 31, 4, 20, 16, 7, 3),
  ('Pargo al Horno con Limón y Pimentón',
   'Pargo horneado con limón y pimentón dulce, servido con guarnición de verduras',
   280, 31, 3, 10, 14, 7, 3),

  -- PALOMETA
  ('Palometa a la Parrilla',
   'Palometa a la parrilla con un toque de sal y pimienta',
   230, 30, 0, 1, 14, 7, 3),
  ('Palometa al Horno con Limón',
   'Palometa horneada con limón, ajo y hierbas frescas',
   240, 32, 1, 4, 14, 7, 3),
  ('Palometa con Salsa de Mostaza y Miel',
   'Palometa en salsa de mostaza y miel, servida con ensalada',
   270, 32, 2, 8, 16, 7, 3),
  ('Palometa a la Plancha con Tomate',
   'Palometa a la plancha acompañada de rodajas de tomate fresco',
   220, 30, 1, 3, 12, 7, 3),
  ('Palometa con Verduras al Vapor',
   'Palometa acompañada de zanahorias, calabacín y espárragos al vapor',
   250, 31, 3, 10, 14, 7, 3),
  ('Palometa en Salsa de Ajo y Perejil',
   'Palometa en salsa de ajo, perejil y aceite de oliva',
   260, 31, 1, 5, 15, 7, 3),
  ('Palometa al Horno con Papas',
   'Palometa horneada con papas y cebolla',
   300, 32, 4, 35, 16, 7, 3),
  ('Palometa con Ensalada de Mango y Aguacate',
   'Palometa con ensalada fresca de mango, aguacate y pepino',
   280, 30, 3, 15, 14, 7, 3),
  ('Palometa en Salsa de Vino Blanco',
   'Palometa en salsa de vino blanco con ajo y perejil',
   270, 30, 2, 6, 14, 7, 3),
  ('Palometa a la Parrilla con Ensalada de Arroz Integral',
   'Palometa a la parrilla con ensalada de arroz integral, tomate y pepino',
   320, 33, 4, 35, 15, 7, 3),

  -- MUJOL
  ('Mujol a la Plancha',
   'Mujol cocinado a la plancha con un toque de sal y pimienta',
   210, 28, 0, 1, 12, 7, 3),
  ('Mujol en Salsa de Ajo y Perejil',
   'Mujol en salsa de ajo, perejil y aceite de oliva',
   250, 30, 1, 5, 15, 7, 3),
  ('Mujol al Horno con Limón',
   'Mujol horneado con limón, ajo y tomillo',
   230, 29, 1, 3, 14, 7, 3),
  ('Mujol con Verduras al Vapor',
   'Mujol acompañado de verduras al vapor como zanahoria, calabacín y pimientos',
   240, 30, 3, 8, 14, 7, 3),
  ('Mujol con Arroz Integral',
   'Mujol con arroz integral, cebolla, pimiento y espárragos',
   280, 31, 3, 30, 14, 7, 3),
  ('Mujol en Salsa de Mostaza y Miel',
   'Mujol en salsa de mostaza y miel, acompañado de ensalada',
   290, 31, 2, 9, 16, 7, 3),
  ('Mujol al Horno con Papas',
   'Mujol horneado con papas y cebolla, aderezado con especias',
   320, 32, 4, 30, 18, 7, 3),
  ('Mujol con Ensalada de Tomate y Pepino',
   'Mujol con ensalada fresca de tomate, pepino y cebolla morada',
   270, 30, 3, 12, 15, 7, 3),
  ('Mujol en Salsa de Vino Blanco',
   'Mujol en salsa de vino blanco, ajo y perejil',
   280, 30, 1, 6, 14, 7, 3),
  ('Mujol a la Parrilla con Especias',
   'Mujol a la parrilla con especias como pimentón, ajo en polvo y pimienta negra',
   220, 29, 0, 2, 13, 7, 3),

  -- MELVA
  ('Melva a la Plancha',
   'Melva cocinada a la plancha con un toque de sal y pimienta',
   220, 30, 0, 1, 12, 7, 3),
  ('Melva en Salsa de Tomate',
   'Melva en salsa de tomate casera, ajo, cebolla y especias',
   270, 32, 1, 8, 14, 7, 3),
  ('Melva a la Parrilla con Limón',
   'Melva a la parrilla acompañada de rodajas de limón',
   230, 30, 0, 2, 13, 7, 3),
  ('Melva en Escabeche',
   'Melva en escabeche con vinagre, cebolla y especias',
   240, 32, 1, 5, 15, 7, 3),
  ('Melva con Arroz Integral',
   'Melva con arroz integral, cebolla y pimientos',
   310, 34, 3, 30, 16, 7, 3),
  ('Melva con Verduras Salteadas',
   'Melva con verduras salteadas como calabacín, pimiento y cebolla',
   290, 32, 3, 8, 17, 7, 3),
  ('Melva al Horno con Tomate y Ajo',
   'Melva horneada con tomate, ajo y hierbas aromáticas',
   250, 30, 2, 5, 14, 7, 3),
  ('Melva con Patatas a lo Pobre',
   'Melva con patatas a lo pobre, con cebolla, pimientos y ajo',
   320, 32, 4, 30, 18, 7, 3),
  ('Melva en Salsa de Mostaza',
   'Melva en salsa de mostaza y miel, acompañada de ensalada',
   290, 34, 2, 10, 15, 7, 3),
  ('Melva con Ensalada de Quinoa',
   'Melva con ensalada fresca de quinoa, tomate y pepino',
   280, 33, 3, 18, 14, 7, 3),

  -- LAMPREA
  ('Lamprea a la Parrilla',
   'Lamprea a la parrilla con ajo y limón',
   250, 28, 0, 2, 15, 7, 3),
  ('Lamprea en Salsa de Vino Tinto',
   'Lamprea en salsa de vino tinto, cebolla, ajo y especias',
   300, 35, 1, 6, 18, 7, 3),
  ('Lamprea a la Plancha con Ensalada Verde',
   'Lamprea a la plancha con ensalada de lechuga, tomate y cebolla',
   220, 30, 3, 5, 12, 7, 3),
  ('Lamprea con Patatas al Horno',
   'Lamprea con patatas al horno, tomillo y aceite de oliva',
   320, 32, 2, 20, 18, 7, 3),
  ('Lamprea en Salsa de Ajo y Perejil',
   'Lamprea en salsa de ajo y perejil con aceite de oliva',
   280, 30, 0, 4, 17, 7, 3),
  ('Lamprea a la Cerveza',
   'Lamprea en salsa de cerveza con cebolla, ajo y especias',
   290, 33, 1, 8, 16, 7, 3),
  ('Lamprea con Verduras Salteadas',
   'Lamprea con verduras salteadas como calabacines, pimientos y cebolla',
   310, 34, 3, 10, 17, 7, 3),
  ('Lamprea en Salsa de Mostaza y Miel',
   'Lamprea en salsa de mostaza y miel, acompañada de arroz integral',
   340, 38, 2, 15, 18, 7, 3),
  ('Lamprea con Arroz',
   'Lamprea servida con arroz blanco y perejil',
   320, 35, 2, 18, 16, 7, 3),
  ('Lamprea en Escabeche',
   'Lamprea en escabeche con vinagre, cebolla y especias',
   250, 30, 1, 4, 14, 7, 3),

  -- JUREL
  ('Jurel a la Parrilla',
   'Jurel a la parrilla con limón y especias',
   200, 25, 0, 1, 10, 7, 3),
  ('Jurel al Horno con Ajo y Romero',
   'Jurel al horno con ajo picado, romero y aceite de oliva',
   210, 26, 0, 2, 12, 7, 3),
  ('Jurel en Salsa de Mostaza y Miel',
   'Jurel en salsa de mostaza y miel, servido con arroz integral',
   230, 28, 1, 8, 10, 7, 3),
  ('Jurel a la Plancha con Ensalada de Tomate',
   'Jurel a la plancha con ensalada de tomate, cebolla y pepino',
   220, 27, 2, 4, 9, 7, 3),
  ('Jurel al Vapor con Limón',
   'Jurel al vapor con rodajas de limón y un toque de sal',
   190, 24, 0, 1, 8, 7, 3),
  ('Jurel en Salsa de Tomate y Albahaca',
   'Jurel en salsa de tomate casera con albahaca y ajo',
   240, 30, 2, 5, 12, 7, 3),
  ('Jurel con Verduras Salteadas',
   'Jurel con verduras salteadas como zanahorias, calabacines y pimientos',
   250, 28, 3, 6, 11, 7, 3),
  ('Jurel en Salsa de Vino Blanco',
   'Jurel en salsa de vino blanco con cebolla y perejil',
   230, 29, 1, 3, 10, 7, 3),
  ('Jurel en Escabeche',
   'Jurel en escabeche con vinagre, ajo, cebolla y especias',
   210, 27, 2, 4, 9, 7, 3),
  ('Jurel con Papas al Horno',
   'Jurel con papas al horno con tomillo y pimienta',
   270, 30, 3, 24, 12, 7, 3),

  -- JAPUTA
  ('Japuta a la Parrilla',
   'Japuta a la parrilla con limón y ajo',
   230, 30, 0, 2, 12, 7, 3),
  ('Japuta al Horno con Ajo y Perejil',
   'Japuta al horno con ajo picado, perejil y aceite de oliva',
   240, 32, 0, 3, 13, 7, 3),
  ('Japuta en Salsa de Tomate',
   'Japuta en salsa de tomate con especias',
   250, 31, 2, 5, 11, 7, 3),
  ('Japuta con Pimientos y Cebolla',
   'Japuta con pimientos y cebolla salteados',
   240, 29, 3, 4, 10, 7, 3),
  ('Japuta a la Plancha con Ensalada',
   'Japuta a la plancha con ensalada de tomates y lechuga',
   220, 30, 2, 3, 9, 7, 3),
  ('Japuta en Salsa de Limón y Alcaparras',
   'Japuta en salsa de limón y alcaparras, servido con arroz integral',
   260, 33, 1, 5, 15, 7, 3),
  ('Japuta con Papas al Horno',
   'Japuta con papas al horno y romero',
   280, 30, 3, 24, 11, 7, 3),
  ('Japuta en Salsa Verde',
   'Japuta en salsa verde con perejil y ajo',
   240, 32, 0, 3, 12, 7, 3),
  ('Japuta con Verduras Asadas',
   'Japuta con verduras asadas como zanahorias y calabacín',
   230, 30, 4, 6, 9, 7, 3),
  ('Japuta a la Sal',
   'Japuta a la sal, acompañado de limón fresco',
   210, 29, 0, 1, 9, 7, 3),

  -- EMPERADOR
  ('Emperador a la Parrilla',
   'Emperador a la parrilla con aceite de oliva y limón',
   220, 28, 0, 1, 12, 7, 3),
  ('Emperador al Horno con Ajo',
   'Emperador al horno con ajo picado, perejil y vino blanco',
   240, 30, 0, 2, 14, 7, 3),
  ('Emperador en Salsa de Limón',
   'Emperador en salsa cremosa de limón y alcaparras',
   250, 31, 0, 4, 13, 7, 3),
  ('Emperador a la Plancha con Verduras',
   'Emperador a la plancha con guarnición de verduras asadas',
   220, 29, 3, 4, 9, 7, 3),
  ('Emperador en Salsa de Tomate',
   'Emperador en salsa de tomate con especias y hierbas aromáticas',
   230, 29, 2, 5, 10, 7, 3),
  ('Emperador con Salsa de Mostaza y Miel',
   'Emperador en salsa de mostaza, miel y hierbas',
   260, 32, 1, 6, 14, 7, 3),
  ('Emperador a la Sal',
   'Emperador a la sal, acompañado de limón',
   210, 27, 0, 1, 9, 7, 3),
  ('Emperador en Salsa de Vino Blanco',
   'Emperador en salsa de vino blanco, ajo y cebolla',
   250, 31, 1, 4, 13, 7, 3),
  ('Emperador a la Parrilla con Hierbas Aromáticas',
   'Emperador a la parrilla con hierbas aromáticas',
   230, 28, 0, 2, 12, 7, 3),
  ('Emperador con Pimientos y Tomate',
   'Emperador con pimientos y tomates asados',
   240, 29, 3, 5, 11, 7, 3),

  -- CONGRIO
  ('Congrio a la Parrilla',
   'Congrio a la parrilla con aceite de oliva y especias',
   190, 25, 0, 2, 9, 7, 3),
  ('Congrio al Horno con Limón',
   'Congrio al horno con rodajas de limón, ajo y romero',
   210, 27, 0, 3, 10, 7, 3),
  ('Congrio en Salsa de Tomate',
   'Congrio en salsa de tomate, cebolla y especias',
   220, 28, 2, 4, 10, 7, 3),
  ('Congrio a la Plancha con Ajo',
   'Congrio a la plancha con ajo y perejil fresco',
   200, 26, 1, 2, 9, 7, 3),
  ('Congrio en Salsa Verde',
   'Congrio en salsa verde con ajo, perejil y vino blanco',
   230, 28, 2, 4, 11, 7, 3),
  ('Congrio a la Sal',
   'Congrio a la sal con un toque de limón',
   180, 25, 0, 1, 7, 7, 3),
  ('Congrio con Verduras al Vapor',
   'Congrio al vapor con zanahorias, brócoli y espárragos',
   220, 26, 3, 5, 10, 7, 3),
  ('Congrio en Brochetas',
   'Congrio en brochetas con pimientos y cebolla',
   240, 28, 2, 6, 12, 7, 3),
  ('Congrio al Vapor con Ajo y Limón',
   'Congrio al vapor con ajo, limón y aceite de oliva',
   200, 25, 1, 3, 9, 7, 3),
  ('Congrio en Salsa de Mostaza',
   'Congrio en salsa cremosa de mostaza y vino blanco',
   250, 30, 1, 4, 13, 7, 3),

  -- CHOBA
  ('Choba a la Plancha',
   'Choba a la plancha con limón y aceite de oliva',
   180, 24, 0, 1, 8, 7, 3),
  ('Choba al Horno con Hierbas',
   'Choba al horno con romero, ajo y aceite de oliva',
   210, 25, 0, 2, 11, 7, 3),
  ('Choba en Salsa de Limón y Ajo',
   'Choba en salsa de limón, ajo y vino blanco',
   200, 24, 1, 3, 10, 7, 3),
  ('Choba a la Parrilla con Tomate',
   'Choba a la parrilla con rodajas de tomate fresco',
   220, 25, 1, 4, 12, 7, 3),
  ('Choba en Salsa Verde',
   'Choba en salsa verde con ajo, perejil y vino blanco',
   230, 26, 2, 4, 12, 7, 3),
  ('Choba a la Sal',
   'Choba a la sal para resaltar su sabor natural',
   180, 24, 0, 1, 7, 7, 3),
  ('Choba con Pimientos Asados',
   'Choba con pimientos asados con ajo y aceite',
   250, 26, 3, 6, 14, 7, 3),
  ('Choba al Vapor con Verduras',
   'Choba al vapor con zanahorias, brócoli y calabacín',
   210, 24, 3, 4, 9, 7, 3),
  ('Choba Frita con Ajo y Perejil',
   'Choba frita con ajo y perejil fresco',
   260, 25, 1, 5, 15, 7, 3),
  ('Choba con Ensalada Fresca',
   'Choba con ensalada de tomate, cebolla y pepino',
   230, 25, 2, 7, 11, 7, 3),

  -- CHICHARRO
  ('Chicharro a la Plancha',
   'Chicharro a la plancha con aceite de oliva y limón',
   180, 25, 0, 2, 8, 7, 3),
  ('Chicharro al Horno con Ajo y Romero',
   'Chicharro al horno con ajo, romero y aceite de oliva',
   220, 27, 1, 3, 12, 7, 3),
  ('Chicharro en Salsa de Tomate',
   'Chicharro en salsa de tomate con cebolla, pimiento y especias',
   240, 26, 2, 8, 10, 7, 3),
  ('Chicharro a la Parrilla',
   'Chicharro a la parrilla con limón y aceite de oliva',
   200, 27, 0, 2, 9, 7, 3),
  ('Chicharro en Salsa Verde',
   'Chicharro en salsa verde con ajo, perejil y vino blanco',
   230, 28, 1, 4, 11, 7, 3),
  ('Chicharro a la Sal',
   'Chicharro cubierto de sal gruesa y horneado',
   190, 26, 0, 2, 7, 7, 3),
  ('Chicharro con Pimientos Asados',
   'Chicharro con pimientos asados y ajo',
   250, 28, 3, 8, 14, 7, 3),
  ('Chicharro al Vapor con Verduras',
   'Chicharro al vapor con zanahorias, brócoli y calabacín',
   210, 26, 4, 5, 9, 7, 3),
  ('Chicharro Frito con Ajo y Perejil',
   'Chicharro frito con ajo, perejil y limón',
   270, 25, 1, 6, 15, 7, 3),
  ('Chicharro con Ensalada de Tomate',
   'Chicharro con ensalada de tomate, cebolla y aceite de oliva',
   220, 26, 2, 7, 11, 7, 3),

  -- CAZÓN
  ('Cazón a la Plancha',
   'Cazón a la plancha con aceite de oliva y limón',
   200, 28, 0, 1, 10, 7, 3),
  ('Cazón en Salsa de Tomate',
   'Cazón en salsa de tomate con ajo, cebolla y especias',
   220, 30, 2, 6, 11, 7, 3),
  ('Cazón al Horno con Limón y Ajo',
   'Cazón al horno con limón, ajo y hierbas',
   210, 28, 1, 2, 12, 7, 3),
  ('Cazón en Adobo',
   'Cazón adobado con especias y a la parrilla',
   230, 29, 1, 3, 13, 7, 3),
  ('Cazón a la Parrilla con Aceite de Oliva',
   'Cazón a la parrilla con aceite de oliva virgen extra',
   220, 29, 0, 1, 12, 7, 3),
  ('Cazón a la Andaluza',
   'Cazón empanado y frito al estilo andaluz',
   350, 30, 2, 15, 20, 7, 3),
  ('Cazón en Salsa Verde',
   'Cazón en salsa verde con perejil, ajo y vino blanco',
   230, 28, 1, 4, 12, 7, 3),
  ('Cazón con Pimientos Asados',
   'Cazón con pimientos asados y aceite de oliva',
   250, 30, 3, 7, 14, 7, 3),
  ('Cazón a la Sal',
   'Cazón cubierto de sal y horneado',
   210, 28, 0, 1, 11, 7, 3),
  ('Cazón con Verduras al Vapor',
   'Cazón al vapor con zanahorias, brócoli y calabacín',
   200, 29, 4, 5, 9, 7, 3),

  -- CARPA
  ('Carpa a la Plancha',
   'Carpa a la plancha con aceite de oliva y limón',
   210, 28, 0, 2, 12, 7, 3),
  ('Carpa al Horno con Hierbas',
   'Carpa al horno con romero, ajo y aceite de oliva',
   240, 30, 1, 3, 15, 7, 3),
  ('Carpa en Salsa de Soja y Jengibre',
   'Carpa en salsa de soja y jengibre con cebolla y zanahorias',
   220, 29, 2, 5, 10, 7, 3),
  ('Carpa a la Parrilla con Limón',
   'Carpa a la parrilla con limón y especias',
   210, 27, 0, 3, 11, 7, 3),
  ('Carpa al Vino Blanco',
   'Carpa en vino blanco con cebolla y ajo',
   230, 28, 1, 4, 14, 7, 3),
  ('Ensalada de Carpa con Verduras',
   'Ensalada con carpa, tomate, pepino y cebolla',
   180, 25, 3, 6, 8, 7, 3),
  ('Carpa a la Mostaza',
   'Carpa marinada en mostaza y horneada con cebollas y zanahorias',
   240, 30, 1, 5, 14, 7, 3),
  ('Carpa en Salsa de Tomate',
   'Carpa en salsa de tomate casera con hierbas',
   250, 29, 3, 8, 14, 7, 3),
  ('Carpa a la Parrilla con Ajo y Perejil',
   'Carpa a la parrilla con salsa de ajo y perejil',
   220, 28, 0, 4, 12, 7, 3),
  ('Carpa al Curry',
   'Carpa en salsa de curry con cebolla, tomate y especias',
   230, 27, 2, 6, 13, 7, 3),

  -- CABALLA
  ('Caballa a la Plancha',
   'Caballa a la plancha con aceite de oliva y limón',
   200, 25, 1, 2, 12, 7, 3),
  ('Caballa en Salsa Verde',
   'Caballa en salsa verde de perejil, ajo y aceite de oliva',
   220, 24, 2, 4, 14, 7, 3),
  ('Caballa al Horno con Limón',
   'Caballa al horno con rodajas de limón y especias',
   180, 23, 1, 3, 10, 7, 3),
  ('Caballa en Escabeche',
   'Caballa en escabeche con vinagre, cebolla y zanahoria',
   250, 22, 3, 6, 14, 7, 3),
  ('Caballa a la Parrilla',
   'Caballa a la parrilla con aceite de oliva y ajo',
   210, 26, 2, 3, 12, 7, 3),
  ('Ensalada de Caballa con Tomate',
   'Ensalada con caballa, tomate, cebolla y aceite de oliva',
   190, 23, 3, 5, 9, 7, 3),
  ('Caballa a la Mostaza',
   'Caballa en salsa de mostaza horneada',
   230, 25, 1, 3, 15, 7, 3),
  ('Caballa a la Miel',
   'Caballa glaseada con miel y especias',
   240, 22, 2, 8, 14, 7, 3),
  ('Caballa al Vino Blanco',
   'Caballa en vino blanco con cebolla, ajo y perejil',
   220, 23, 2, 4, 13, 7, 3),
  ('Caballa en Tartar',
   'Caballa cruda con cebolla, limón y aceite de oliva',
   180, 26, 1, 2, 9, 7, 3),

  -- BOQUERONES
  ('Boquerones en Vinagre',
   'Boquerones marinados en vinagre con ajo y perejil',
   150, 22, 1, 3, 7, 7, 3),
  ('Boquerones a la Plancha',
   'Boquerones a la plancha con aceite de oliva y limón',
   180, 20, 1, 2, 9, 7, 3),
  ('Boquerones Fritos',
   'Boquerones rebozados y fritos en aceite de oliva',
   220, 18, 1, 5, 12, 7, 3),
  ('Boquerones al Horno con Ajo',
   'Boquerones al horno con ajo, perejil y limón',
   160, 22, 1, 2, 8, 7, 3),
  ('Boquerones en Salsa de Tomate',
   'Boquerones en salsa de tomate con especias',
   190, 23, 2, 4, 9, 7, 3),
  ('Boquerones con Pimientos Asados',
   'Boquerones fritos con pimientos asados',
   210, 19, 3, 6, 11, 7, 3),
  ('Boquerones a la Andaluza',
   'Boquerones rebozados y fritos al estilo andaluz',
   230, 18, 1, 7, 13, 7, 3),
  ('Boquerones con Ensalada de Tomate',
   'Boquerones fritos con ensalada de tomate y cebolla',
   210, 20, 4, 5, 11, 7, 3),
  ('Boquerones en Aceite',
   'Boquerones en conserva de aceite de oliva con ajo y especias',
   250, 25, 1, 3, 14, 7, 3),
  ('Boquerones al Vinagre de Jerez',
   'Boquerones marinados en vinagre de Jerez con ajo y guindilla',
   170, 22, 1, 3, 7, 7, 3),

  -- BESUGO
  ('Besugo al Horno con Limón y Romero',
   'Besugo al horno con limón, romero y aceite de oliva',
   230, 25, 2, 3, 12, 7, 3),
  ('Besugo a la Parrilla con Ajo y Perejil',
   'Besugo a la parrilla con ajo, perejil y aceite de oliva',
   210, 26, 1, 1, 10, 7, 3),
  ('Besugo a la Sal',
   'Besugo cocinado en sal gruesa para mantener su jugosidad',
   220, 27, 0, 0, 11, 7, 3),
  ('Besugo con Salsa de Mostaza y Miel',
   'Besugo al horno con salsa ligera de mostaza y miel',
   250, 28, 2, 5, 14, 7, 3),
  ('Besugo al Vapor con Verduras',
   'Besugo al vapor con zanahorias, brócoli y cebolla',
   200, 25, 4, 8, 7, 7, 3),
  ('Besugo con Salsa de Vino Blanco',
   'Besugo al horno con salsa de vino blanco y cebollas',
   240, 26, 2, 6, 11, 7, 3),
  ('Besugo a la Plancha con Ensalada',
   'Besugo a la plancha con ensalada mixta',
   210, 23, 3, 7, 9, 7, 3),
  ('Besugo con Salsa Verde',
   'Besugo al vapor con salsa verde de perejil, ajo y almejas',
   230, 27, 1, 3, 10, 7, 3),
  ('Besugo al Horno con Pimientos',
   'Besugo al horno con pimientos asados',
   250, 28, 4, 7, 12, 7, 3),
  ('Besugo con Tomates Cherry',
   'Besugo al horno con tomates cherry, ajo y aceite de oliva',
   240, 26, 3, 6, 13, 7, 3),

  -- ATÚN
  ('Ensalada de Atún y Garbanzos',
   'Atún en conserva con garbanzos, cebolla, pimientos y aceite de oliva',
   210, 22, 5, 10, 12, 7, 3),
  ('Atún a la Parrilla con Limón',
   'Lomos de atún a la parrilla con limón y aceite de oliva',
   230, 25, 1, 0, 14, 7, 3),
  ('Tartar de Atún',
   'Tartar de atún fresco con cebollín, aguacate y sésamo',
   190, 20, 3, 6, 10, 7, 3),
  ('Atún al Horno con Verduras',
   'Atún al horno con zanahorias, cebolla y tomates',
   240, 26, 4, 8, 14, 7, 3),
  ('Ensalada de Atún con Pimientos',
   'Ensalada de atún con pimientos, pepino y cebolla morada',
   200, 22, 4, 8, 12, 7, 3),
  ('Atún con Salsa de Soja y Sésamo',
   'Atún en cubos con salsa de soja, jengibre y semillas de sésamo',
   210, 23, 1, 7, 13, 7, 3),
  ('Croquetas de Atún',
   'Croquetas de atún con bechamel ligera y pan rallado',
   220, 18, 2, 18, 12, 7, 3),
  ('Atún a la Plancha con Ensalada',
   'Atún a la plancha con ensalada mixta',
   250, 28, 3, 10, 15, 7, 3),
  ('Sopa de Atún',
   'Sopa ligera de atún con verduras y caldo de pescado',
   180, 20, 4, 7, 8, 7, 3),
  ('Pizza de Atún',
   'Pizza casera con atún, tomate, cebolla y aceitunas',
   300, 20, 2, 30, 14, 7, 3),

  -- ARENQUE
  ('Arenque Ahumado con Ensalada',
   'Arenque ahumado con ensalada de pepino y cebolla',
   180, 20, 2, 5, 10, 7, 3),
  ('Arenque en Escabeche',
   'Arenque marinado en vinagre y especias',
   210, 22, 1, 3, 12, 7, 3),
  ('Arenque a la Parrilla',
   'Arenque a la parrilla con limón y ajo',
   220, 25, 0, 4, 14, 7, 3),
  ('Ensalada de Arenque y Patata',
   'Ensalada de arenque ahumado con patatas, cebolla y mayonesa',
   250, 22, 3, 20, 15, 7, 3),
  ('Arenque al Horno con Verduras',
   'Arenque horneado con zanahorias, cebollas y tomate',
   240, 23, 4, 8, 14, 7, 3),
  ('Tartar de Arenque',
   'Tartar de arenque con cebollín, mostaza y pepinillos',
   210, 20, 2, 6, 13, 7, 3),
  ('Arenque con Salsa de Mostaza',
   'Arenque con salsa de mostaza y miel',
   230, 24, 1, 7, 14, 7, 3),
  ('Arenque con Pan de Centeno',
   'Arenque ahumado sobre pan de centeno con cebolla morada',
   190, 21, 3, 8, 10, 7, 3),
  ('Sopa de Arenque',
   'Sopa de arenque con caldo de pescado, patatas y cebolla',
   250, 24, 3, 15, 14, 7, 3),
  ('Arenque con Huevo Cocido',
   'Arenque acompañado de huevo cocido y ensalada de pepino',
   280, 26, 2, 5, 18, 7, 3),

  -- ANGULA
  ('Angula a la Plancha',
   'Angula a la plancha con ajo y aceite de oliva',
   150, 18, 1, 5, 7, 7, 3),
  ('Tartar de Angula',
   'Tartar de angula con aguacate y cebolla morada',
   200, 18, 2, 8, 12, 7, 3),
  ('Angula a la Sidra',
   'Angula cocinada con sidra, ajo y perejil',
   180, 19, 1, 4, 9, 7, 3),
  ('Ensalada de Angula y Piquillos',
   'Ensalada de angula con pimientos del piquillo',
   220, 20, 3, 15, 10, 7, 3),
  ('Angula con Huevos Rotos',
   'Angula con huevos rotos y patatas fritas',
   400, 22, 4, 30, 25, 7, 3),
  ('Angula a la Plancha con Limón',
   'Angula a la plancha con limón y aceite de oliva',
   170, 18, 0, 6, 8, 7, 3),
  ('Angula con Piquillos y Jamón',
   'Angula con pimientos del piquillo y jamón ibérico',
   230, 20, 3, 12, 15, 7, 3),
  ('Angula al Ajillo',
   'Angula salteada al ajillo con guindilla y perejil',
   210, 19, 1, 5, 14, 7, 3),
  ('Angula con Arroz Integral',
   'Angula salteada con arroz integral y verduras',
   350, 22, 4, 40, 12, 7, 3),
  ('Angula a la Vinagreta',
   'Angula con vinagreta de mostaza y miel',
   180, 19, 2, 8, 9, 7, 3),

  -- ANGUILA
  ('Anguila a la Parrilla',
   'Anguila a la parrilla con sal y pimienta',
   250, 20, 0, 2, 18, 7, 3),
  ('Sushi de Anguila',
   'Sushi de anguila con arroz y algas nori',
   300, 22, 1, 35, 10, 7, 3),
  ('Anguila Ahumada con Ensalada',
   'Anguila ahumada con ensalada verde y aceite de oliva',
   200, 18, 4, 10, 12, 7, 3),
  ('Anguila al Horno con Limón y Romero',
   'Anguila al horno con limón, romero y aceite de oliva',
   280, 22, 2, 5, 20, 7, 3),
  ('Anguila a la Salsa Teriyaki',
   'Anguila marinada en salsa teriyaki servida con arroz',
   350, 25, 3, 40, 15, 7, 3),
  ('Brochetas de Anguila y Verduras',
   'Brochetas de anguila y verduras a la parrilla',
   220, 18, 4, 8, 14, 7, 3),
  ('Anguila en Salsa de Mostaza y Miel',
   'Anguila en salsa de mostaza y miel',
   300, 20, 1, 18, 15, 7, 3),
  ('Anguila al Curry',
   'Anguila en salsa de curry suave',
   350, 23, 3, 15, 20, 7, 3),
  ('Anguila con Verduras al Vapor',
   'Anguila con verduras al vapor',
   220, 20, 5, 10, 12, 7, 3),
  ('Ensalada de Anguila y Mango',
   'Ensalada de anguila con mango, cebolla morada y cilantro',
   180, 18, 3, 12, 10, 7, 3),

  -- ANCHOAS
  ('Ensalada de Anchoas y Tomate',
   'Ensalada con anchoas, tomate, cebolla y aliño de aceite de oliva',
   150, 10, 2, 5, 10, 7, 3),
  ('Pizza de Anchoas',
   'Pizza con tomate, queso mozzarella y anchoas',
   300, 15, 3, 30, 15, 7, 3),
  ('Pasta con Anchoas y Ajo',
   'Pasta salteada con ajo, aceite de oliva y anchoas',
   400, 20, 4, 50, 15, 7, 3),
  ('Ensalada de Anchoas y Judías Verdes',
   'Ensalada de judías verdes, huevo duro, tomate y anchoas',
   200, 15, 5, 15, 12, 7, 3),
  ('Tostadas de Pan con Anchoas',
   'Tostadas con anchoas, tomate y ajo',
   180, 12, 2, 20, 8, 7, 3),
  ('Anchoas con Pimientos Asados',
   'Anchoas con pimientos asados y cebolla caramelizada',
   250, 18, 4, 15, 18, 7, 3),
  ('Pizza de Anchoas y Aceitunas',
   'Pizza con tomate, anchoas, aceitunas y queso',
   350, 20, 4, 35, 18, 7, 3),
  ('Revuelto de Huevo con Anchoas',
   'Revuelto de huevo con anchoas, cebolla y espárragos',
   250, 18, 3, 5, 20, 7, 3),
  ('Espárragos con Anchoas',
   'Espárragos cocidos acompañados de anchoas y aceite de oliva',
   200, 15, 6, 12, 10, 7, 3),
  ('Anchoas a la Salsa Verde',
   'Anchoas en salsa verde de perejil, ajo y aceite de oliva',
   180, 15, 3, 5, 12, 7, 3),

-- VERDURAS: categoria_id=8, tipo_id=3
  ('Ensalada de Pimientos Asados',
   'Ensalada fresca de pimientos asados con aceite de oliva y especias',
   90, 2, 4, 10, 4, 8, 3),
  ('Fajitas de Pollo y Pimientos',
   'Fajitas de pollo con pimientos frescos en tortillas de trigo',
   250, 20, 3, 25, 8, 8, 3),
  ('Pimientos Rellenos de Quinoa y Verduras',
   'Pimientos rellenos de quinoa, calabacín, zanahoria y maíz',
   180, 6, 5, 20, 5, 8, 3),
  ('Pimientos Rellenos de Atún y Arroz Integral',
   'Pimientos al horno rellenos de atún y arroz integral',
   210, 15, 4, 18, 7, 8, 3),
  ('Salteado de Pimientos con Tofu',
   'Pimientos salteados con trozos de tofu en salsa de soja',
   140, 10, 3, 8, 6, 8, 3),
  ('Pimientos al Horno con Hierbas',
   'Pimientos horneados con hierbas aromáticas y aceite de oliva',
   120, 1, 4, 6, 5, 8, 3),
  ('Ensalada de Pimientos y Garbanzos',
   'Ensalada de pimientos con garbanzos, cebolla y perejil',
   150, 7, 5, 18, 4, 8, 3),
  ('Revuelto de Pimientos y Huevos',
   'Revuelto de pimientos rojos y verdes con huevos',
   200, 12, 2, 4, 14, 8, 3),
  ('Pimientos y Calabacín Salteados con Ajo',
   'Salteado de pimientos y calabacín con ajo fresco',
   130, 2, 3, 10, 7, 8, 3),
  ('Pimientos Asados con Aceite de Oliva',
   'Pimientos rojos y verdes asados con un chorrito de aceite de oliva y sal',
   80, 1, 3, 8, 4, 8, 3),
  ('Puré de Patatas Saludable',
   'Puré de patatas con aceite de oliva y un toque de sal',
   150, 3, 2, 30, 5, 8, 3),
  ('Patatas Asadas con Romero',
   'Patatas horneadas con romero fresco y aceite de oliva',
   130, 2, 3, 25, 4, 8, 3),
  ('Patatas al Vapor con Perejil',
   'Patatas cocidas al vapor y condimentadas con perejil fresco',
   110, 2, 2, 24, 0, 8, 3),
  ('Patatas Rellenas de Verduras',
   'Patatas al horno rellenas de verduras como pimientos y zanahorias',
   160, 4, 4, 30, 5, 8, 3),
  ('Ensalada de Patatas y Judías Verdes',
   'Ensalada fresca de patatas con judías verdes y aderezo ligero',
   120, 3, 3, 22, 3, 8, 3),
  ('Tortilla de Patatas Saludable',
   'Tortilla de patatas al horno con poca grasa',
   180, 6, 2, 28, 6, 8, 3),
  ('Patatas al Horno con Pimientos',
   'Rodajas de patata y pimientos al horno con especias',
   140, 2, 3, 26, 4, 8, 3),
  ('Patatas a la Provenzal',
   'Patatas horneadas con hierbas provenzales y un toque de ajo',
   130, 2, 3, 25, 4, 8, 3),
  ('Guiso de Patatas y Espinacas',
   'Guiso ligero de patatas y espinacas con especias',
   150, 5, 4, 27, 3, 8, 3),
  ('Patatas Salteadas con Champiñones',
   'Patatas y champiñones salteados con ajo y perejil',
   140, 3, 3, 26, 4, 8, 3),
  ('Puré de Zanahorias Saludable',
   'Puré cremoso de zanahorias cocidas con un toque de aceite de oliva',
   90, 1, 4, 18, 2, 8, 3),
  ('Zanahorias Asadas con Miel y Tomillo',
   'Zanahorias asadas al horno con miel y tomillo fresco',
   110, 1, 3, 20, 3, 8, 3),
  ('Ensalada de Zanahorias y Manzana',
   'Ensalada crujiente de zanahoria rallada con manzana y aderezo ligero',
   80, 1, 3, 15, 2, 8, 3),
  ('Zanahorias al Vapor con Especias',
   'Zanahorias cocidas al vapor con un toque de cúrcuma y pimienta',
   60, 1, 4, 12, 0, 8, 3),
  ('Zanahorias Ralladas con Limón y Perejil',
   'Zanahorias frescas ralladas con zumo de limón y perejil',
   70, 1, 3, 13, 1, 8, 3),
  ('Sopa de Zanahoria y Jengibre',
   'Sopa suave de zanahoria con un toque de jengibre fresco',
   100, 2, 3, 18, 2, 8, 3),
  ('Zanahorias Glaseadas con Sésamo',
   'Zanahorias glaseadas con aceite de sésamo y semillas de sésamo',
   120, 2, 3, 20, 4, 8, 3),
  ('Revuelto de Zanahoria y Espinacas',
   'Revuelto saludable de zanahorias con espinacas frescas',
   90, 4, 4, 14, 2, 8, 3),
  ('Zanahorias al Horno con Comino',
   'Zanahorias al horno con un toque de comino y sal marina',
   100, 1, 4, 18, 2, 8, 3),
  ('Batido de Zanahoria y Naranja',
   'Batido refrescante de zanahoria y naranja sin azúcar añadida',
   70, 1, 2, 14, 0, 8, 3),
  ('Judías Verdes al Vapor con Limón',
   'Judías verdes cocidas al vapor y aderezadas con jugo de limón fresco',
   50, 2, 4, 8, 0, 8, 3),
  ('Ensalada de Judías Verdes y Tomate Cherry',
   'Judías verdes crujientes mezcladas con tomate cherry y aderezo ligero',
   70, 2, 3, 10, 2, 8, 3),
  ('Judías Verdes Salteadas con Ajo',
   'Judías verdes salteadas con ajo y un toque de aceite de oliva',
   80, 2, 4, 8, 4, 8, 3),
  ('Judías Verdes con Jamón Serrano',
   'Judías verdes cocidas con trozos de jamón serrano',
   110, 6, 4, 8, 5, 8, 3),
  ('Judías Verdes al Horno con Queso Parmesano',
   'Judías verdes al horno con un toque de queso parmesano rallado',
   90, 4, 3, 8, 3, 8, 3),
  ('Guiso de Judías Verdes y Patatas',
   'Judías verdes guisadas con patatas en una salsa de tomate casera',
   120, 3, 5, 18, 2, 8, 3),
  ('Judías Verdes con Almendras Tostadas',
   'Judías verdes cocidas al vapor y servidas con almendras tostadas',
   100, 3, 4, 9, 4, 8, 3),
  ('Salteado de Judías Verdes y Champiñones',
   'Judías verdes salteadas con champiñones frescos y ajo',
   85, 3, 4, 7, 3, 8, 3),
  ('Judías Verdes con Salsa de Yogur',
   'Judías verdes al vapor servidas con una salsa ligera de yogur y hierbas',
   60, 3, 3, 7, 1, 8, 3),
  ('Judías Verdes con Huevo Duro',
   'Judías verdes cocidas acompañadas de huevo duro en trozos',
   100, 6, 4, 6, 5, 8, 3),
  ('Sopa de Cebolla Ligera',
   'Sopa de cebolla clásica con caldo de verduras, sin queso ni pan',
   50, 1, 2, 12, 0, 8, 3),
  ('Ensalada de Cebolla y Tomate',
   'Ensalada fresca con cebolla morada, tomate y un aderezo ligero',
   80, 1, 3, 15, 1, 8, 3),
  ('Cebolla Caramelizada',
   'Cebolla caramelizada a fuego lento con un toque de vinagre balsámico',
   100, 1, 3, 24, 1, 8, 3),
  ('Tarta de Cebolla y Espinacas',
   'Tarta ligera con cebolla, espinacas y masa integral',
   250, 7, 4, 30, 10, 8, 3),
  ('Cebollas Rellenas de Verduras',
   'Cebollas grandes rellenas de mezcla de verduras y especias',
   180, 4, 6, 34, 2, 8, 3),
  ('Cebolla al Horno con Hierbas',
   'Cebolla horneada con hierbas aromáticas y un toque de aceite de oliva',
   70, 2, 3, 15, 3, 8, 3),
  ('Cebolla en Agridulce',
   'Cebolla cocinada con vinagre, azúcar y salsa de soja, con un toque agridulce',
   120, 2, 3, 28, 1, 8, 3),
  ('Cebolla Salteada con Pimientos',
   'Cebolla salteada junto con pimientos rojos y verdes',
   150, 2, 5, 35, 3, 8, 3),
  ('Ensalada de Cebolla y Aguacate',
   'Ensalada fresca con cebolla morada, aguacate y aderezo de limón',
   200, 3, 6, 18, 14, 8, 3),
  ('Cebolla Gratinada',
   'Cebolla cocida con una capa de queso bajo en grasa y gratinada al horno',
   180, 6, 4, 20, 8, 8, 3),
  ('Ensalada de Tomate y Albahaca',
   'Ensalada fresca con tomate, albahaca y un toque de aceite de oliva',
   90, 2, 3, 18, 4, 8, 3),
  ('Salsa de Tomate Casera',
   'Salsa de tomate natural con ajo, cebolla y especias, ideal para pasta o pizza',
   80, 2, 4, 18, 2, 8, 3),
  ('Tomate Relleno de Atún',
   'Tomate grande relleno de atún, cebolla y un toque de mayonesa ligera',
   150, 14, 3, 10, 7, 8, 3),
  ('Gazpacho Andaluz',
   'Sopa fría tradicional de tomate, pepino, pimiento y pan',
   100, 3, 4, 20, 3, 8, 3),
  ('Tomates Asados al Horno',
   'Tomates asados al horno con hierbas, ajo y un toque de aceite de oliva',
   80, 2, 4, 15, 4, 8, 3),
  ('Ensalada Caprese',
   'Ensalada italiana con tomate, mozzarella, albahaca y aceite de oliva',
   220, 8, 4, 12, 18, 8, 3),
  ('Sopa de Tomate',
   'Sopa cremosa de tomate con un toque de albahaca y crema ligera',
   120, 3, 5, 20, 4, 8, 3),
  ('Tomate a la Parrilla',
   'Tomates a la parrilla con un toque de aceite de oliva y ajo',
   90, 3, 4, 18, 3, 8, 3),
  ('Tomate y Pepino en Ensalada',
   'Ensalada fresca de tomate, pepino y cebolla, aderezada con limón',
   60, 2, 4, 12, 1, 8, 3),
  ('Tomate Frito Casero',
   'Salsa de tomate frito hecha en casa, ideal para acompañar arroz o pasta',
   140, 4, 5, 25, 6, 8, 3),
  ('Acelga Salteada con Ajo',
   'Acelga cocinada con ajo y aceite de oliva, un acompañamiento saludable.',
   80, 3, 5, 10, 4, 8, 3),
  ('Sopa de Acelga y Patata',
   'Sopa ligera con acelga, patata, cebolla y caldo de verduras.',
   150, 4, 6, 20, 3, 8, 3),
  ('Tortilla de Acelga',
   'Tortilla hecha con acelga, huevos y cebolla, ideal para un almuerzo rápido.',
   220, 12, 3, 10, 15, 8, 3),
  ('Ensalada de Acelga y Garbanzos',
   'Ensalada de acelga fresca, garbanzos cocidos, tomate y cebolla.',
   200, 8, 10, 30, 5, 8, 3),
  ('Acelga al Vapor con Limón',
   'Acelga cocida al vapor con limón y un toque de aceite de oliva.',
   60, 3, 7, 10, 2, 8, 3),
  ('Empanada de Acelga y Atún',
   'Empanada de masa integral rellena de acelga y atún.',
   250, 15, 5, 20, 12, 8, 3),
  ('Acelga con Garbanzos y Tomate',
   'Guiso de acelga con garbanzos y tomate, un plato reconfortante.',
   220, 9, 8, 35, 5, 8, 3),
  ('Acelga con Huevo Pochado',
   'Acelga salteada acompañada de un huevo pochado, ideal para una comida ligera.',
   180, 12, 5, 10, 12, 8, 3),
  ('Guiso de Acelga con Almejas',
   'Guiso delicioso de acelga con almejas, preparado con caldo de pescado.',
   250, 20, 5, 15, 10, 8, 3),
  ('Croquetas de Acelga y Patata',
   'Croquetas caseras de acelga y patata, perfectas como aperitivo o plato principal.',
   220, 6, 5, 30, 8, 8, 3),
  ('Berenjenas al Horno con Ajo y Romero',
   'Berenjenas asadas con ajo, aceite de oliva y romero, un plato sabroso y saludable.',
   100, 2, 4, 15, 5, 8, 3),
  ('Moussaka de Berenjena',
   'Plato tradicional griego con berenjenas, carne de cordero y bechamel.',
   350, 18, 6, 25, 20, 8, 3),
  ('Berenjenas a la Plancha con Limón',
   'Berenjenas a la plancha acompañadas de un toque de limón y hierbas.',
   120, 3, 5, 12, 7, 8, 3),
  ('Berenjenas Rellenas de Quinoa y Verduras',
   'Berenjenas asadas rellenas de quinoa y verduras, una receta ligera y deliciosa.',
   250, 10, 8, 40, 10, 8, 3),
  ('Curry de Berenjena',
   'Berenjenas cocidas en salsa de curry con leche de coco, un plato lleno de sabor.',
   220, 4, 6, 20, 15, 8, 3),
  ('Berenjenas Fritas con Yogur',
   'Berenjenas fritas servidas con salsa de yogur, perfectas como aperitivo.',  
   180, 5, 4, 20, 8, 8, 3),
  ('Lasagna de Berenjena',
   'Lasagna sin pasta, con capas de berenjena, carne y salsa de tomate.',
   300, 15, 7, 25, 18, 8, 3),
  ('Berenjenas en Salsa de Tomate',
   'Berenjenas cocinadas en salsa de tomate con ajo y albahaca.',
   150, 4, 6, 20, 7, 8, 3),
  ('Tarta Salada de Berenjena',
   'Tarta salada con berenjena, queso ricotta y una base crujiente.',
   280, 12, 5, 35, 14, 8, 3),
  ('Ensalada de Berenjena con Tomate y Albahaca',
   'Ensalada fresca de berenjena asada con tomate, albahaca y un toque de aceite de oliva.',
   140, 4, 5, 15, 9, 8, 3),
  ('Ensalada de Lechuga y Tomate',
   'Ensalada fresca de lechuga y tomate, ideal para acompañar cualquier plato.',
   40, 2, 2, 8, 1, 8, 3),
  ('Tacos de Lechuga con Pollo',
   'Tacos frescos hechos con hojas de lechuga en lugar de tortillas, rellenos de pollo a la parrilla.',
   200, 25, 3, 5, 10, 8, 3),
  ('Ensalada César con Lechuga',
   'Lechuga romana, pollo, croutons y aderezo César.',
   300, 20, 4, 12, 20, 8, 3),
  ('Wraps de Lechuga con Atún',
   'Hojas de lechuga rellenas de atún con verduras, un almuerzo ligero y nutritivo.',
   150, 18, 3, 4, 8, 8, 3),
  ('Ensalada de Lechuga, Aguacate y Pepino',
   'Una ensalada ligera con lechuga, aguacate, pepino y un toque de aceite de oliva.',
   150, 2, 6, 12, 12, 8, 3),
  ('Ensalada de Lechuga y Zanahorias',
   'Ensalada fresca de lechuga con zanahorias ralladas y un toque de limón.',
   50, 1, 3, 10, 1, 8, 3),
  ('Sopa Fría de Lechuga',
   'Sopa fría de lechuga con cebolla, pepino y un toque de limón.',
   70, 3, 3, 12, 2, 8, 3),
  ('Ensalada Mediterránea de Lechuga',
   'Ensalada con lechuga, tomate, pepino, aceitunas y queso feta.',
   200, 7, 4, 15, 14, 8, 3),
  ('Lechuga Rellena de Pollo y Verduras',
   'Hojas de lechuga rellenas de pollo, zanahoria rallada y pepino.',
   180, 25, 4, 8, 8, 8, 3),
  ('Ensalada de Lechuga, Fresas y Almendras',
   'Ensalada dulce con lechuga, fresas frescas y almendras.',
   130, 3, 5, 16, 5, 8, 3),
  ('Ensalada de Pepino y Tomate',
   'Una ensalada refrescante con pepino, tomate y cebolla.',  
   40, 2, 3, 8, 1, 8, 3),
  ('Tzatziki (Salsa Griega de Pepino)',
   'Salsa cremosa de pepino, yogur, ajo y hierbas, perfecta como acompañamiento.',
   80, 3, 1, 7, 5, 8, 3),
  ('Ensalada de Pepino y Aguacate',
   'Ensalada fresca con pepino, aguacate y un toque de limón.',
   150, 3, 6, 12, 10, 8, 3),
  ('Pepino a la Menta',
   'Pepino fresco con menta y limón, ideal como guarnición.',
   35, 1, 2, 7, 0, 8, 3),
  ('Ensalada de Pepino con Yogur',
   'Ensalada de pepino con un aderezo cremoso de yogur y hierbas.',
   100, 4, 2, 10, 5, 8, 3),
  ('Gazpacho de Pepino',
   'Sopa fría de pepino, ideal para el verano.',
   60, 2, 3, 13, 1, 8, 3),
  ('Rollitos de Pepino con Hummus',
   'Rollitos de pepino rellenos de hummus, una opción ligera y sabrosa.',
   120, 4, 2, 10, 8, 8, 3),
  ('Pepino en Vinagre',
   'Pepinos frescos marinados en vinagre, un acompañante ideal para carnes.',
   30, 1, 2, 7, 0, 8, 3),
  ('Ensalada de Pepino y Queso Feta',
   'Ensalada ligera de pepino y queso feta, perfecta como acompañamiento.',
   180, 6, 4, 10, 12, 8, 3),
  ('Smoothie de Pepino y Limón',
   'Un refrescante smoothie de pepino con limón y menta.',
   50, 1, 3, 12, 0, 8, 3),
  ('Ensalada de Guisantes y Zanahorias',
   'Ensalada fresca con guisantes, zanahorias, cebolla y un aderezo de aceite de oliva y limón.',  
   180, 6, 5, 28, 6, 8, 3),
  ('Sopa de Guisantes Verdes',
   'Sopa cremosa de guisantes verdes, cebolla y ajo, perfecta para el invierno.',
   200, 10, 8, 30, 5, 8, 3),
  ('Guisantes Salteados con Ajo',
   'Guisantes frescos salteados con ajo, aceite de oliva y un toque de limón.',
   150, 5, 7, 20, 8, 8, 3),
  ('Puré de Guisantes',
   'Puré suave de guisantes, ideal como acompañante de carnes o pescado.',
   220, 8, 10, 30, 6, 8, 3),
  ('Guisantes con Jamón',
   'Guisantes cocidos con trozos de jamón ibérico, una receta simple y sabrosa.',
   250, 12, 6, 25, 12, 8, 3),
  ('Guisantes con Huevo',
   'Guisantes cocidos con huevo revuelto, un plato nutritivo y fácil de preparar.',
   300, 15, 8, 28, 16, 8, 3),
  ('Arroz con Guisantes',
   'Arroz integral cocido con guisantes, cebolla y un toque de aceite de oliva.',
   220, 6, 8, 35, 5, 8, 3),
  ('Guisantes con Pimientos',
   'Guisantes cocidos con pimientos rojos y verdes, cebolla y ajo, todo salteado con aceite de oliva.',
   200, 7, 8, 28, 8, 8, 3),
  ('Ensalada de Guisantes con Feta',
   'Ensalada fresca con guisantes, queso feta, tomate y un aderezo de vinagre balsámico.',
   230, 8, 6, 20, 14, 8, 3),
  ('Guisantes con Lentejas',
   'Guisantes cocidos junto con lentejas, cebolla y especias, un plato lleno de proteína vegetal.',
   300, 18, 12, 40, 6, 8, 3),
  ('Ensalada de Brócoli y Almendras',
   'Ensalada fresca con brócoli, almendras, cebolla morada y aderezo de aceite de oliva.',
   180, 6, 6, 20, 10, 8, 3),
  ('Crema de Brócoli',
   'Sopa cremosa de brócoli, cebolla, ajo y un toque de nata.',
   220, 8, 7, 25, 12, 8, 3),
  ('Brócoli al Horno con Ajo y Limón',
   'Brócoli asado al horno con ajo, aceite de oliva y limón.',  
   150, 5, 8, 20, 7, 8, 3),
  ('Brócoli con Queso',
   'Brócoli cocido con queso rallado y un toque de pan rallado.',
   250, 12, 8, 18, 16, 8, 3),
  ('Brócoli Salteado con Tofu',
   'Brócoli salteado con tofu, ajo, aceite de sésamo y salsa de soja.',
   200, 10, 7, 15, 12, 8, 3),
  ('Ensalada de Brócoli con Tomate y Garbanzos',
   'Ensalada de brócoli, tomate y garbanzos con un toque de vinagreta.',
   250, 9, 10, 30, 8, 8, 3),
  ('Brócoli con Pollo y Salsa de Mostaza',
   'Brócoli cocido con trozos de pollo y salsa de mostaza.',
   300, 25, 8, 18, 14, 8, 3),
  ('Brócoli al Vapor con Aceite de Oliva',
   'Brócoli al vapor con un toque de aceite de oliva y sal.',
   100, 4, 7, 12, 5, 8, 3),
  ('Brócoli con Pimientos y Cebolla',
   'Brócoli cocido con pimientos y cebolla, salteado con especias.',
   180, 6, 8, 20, 8, 8, 3),
  ('Brócoli con Huevo y Queso',
   'Brócoli cocido acompañado de huevo duro y queso rallado.',
   280, 18, 8, 18, 16, 8, 3),
  ('Ensalada de Remolacha y Naranjas',
   'Ensalada fresca con remolacha cocida, rodajas de naranja, cebolla morada y vinagreta.',
   180, 4, 6, 28, 8, 8, 3),
  ('Crema de Remolacha',
   'Sopa cremosa de remolacha con cebolla, ajo y un toque de crema.',
   220, 6, 7, 30, 10, 8, 3),
  ('Remolacha Asada con Miel y Mostaza',
   'Remolacha asada al horno con miel, mostaza y un toque de aceite de oliva.',
   200, 4, 8, 35, 7, 8, 3),
  ('Hummus de Remolacha',
   'Hummus con remolacha cocida, garbanzos, tahini, limón y ajo.',
   250, 8, 10, 30, 12, 8, 3),
  ('Remolacha al Horno con Ajo y Romero',
   'Remolacha cocida al horno con ajo y romero.',
   180, 3, 9, 40, 7, 8, 3),
  ('Ensalada de Remolacha con Queso de Cabra',
   'Ensalada de remolacha cocida con queso de cabra, nueces y vinagre balsámico.',
   250, 8, 10, 28, 14, 8, 3),
  ('Remolacha con Arroz Integral',
   'Remolacha cocida acompañada de arroz integral, cebolla y cilantro.',
   230, 7, 9, 45, 6, 8, 3),
  ('Batido de Remolacha y Manzana',
   'Batido saludable de remolacha cocida, manzana, zanahoria y un toque de jengibre.',
   180, 2, 7, 40, 1, 8, 3),
  ('Tarta de Remolacha y Chocolate',
   'Tarta de remolacha cocida con cacao y almendras, perfecta para el postre.',
   300, 8, 12, 45, 15, 8, 3),
  ('Ensalada de Remolacha y Garbanzos',
   'Ensalada de remolacha cocida, garbanzos, pepino, cebolla roja y cilantro.',
   250, 9, 12, 30, 8, 8, 3),
  ('Crema de Calabaza',
   'Sopa cremosa de calabaza con cebolla, zanahoria, ajo y un toque de crema.',
   180, 4, 6, 30, 8, 8, 3),
  ('Ensalada de Calabaza Asada',
   'Ensalada de calabaza asada con espinacas, nueces y vinagreta de mostaza.',
   220, 6, 7, 35, 10, 8, 3),
  ('Tarta de Calabaza',
   'Tarta casera de calabaza con especias, ideal para postres.',
   300, 5, 8, 45, 12, 8, 3),
  ('Calabaza Rellena de Quinoa y Verduras',
   'Calabaza asada rellena con quinoa, espinacas, cebolla y pimientos.',
   250, 8, 10, 40, 6, 8, 3),
  ('Gnocchis de Calabaza',
   'Gnocchis caseros hechos con puré de calabaza, acompañados de salsa de tomate.',
   350, 10, 9, 50, 12, 8, 3),
  ('Calabaza al Horno con Romero',
   'Calabaza asada al horno con romero y aceite de oliva.',
   200, 3, 8, 45, 7, 8, 3),
  ('Ensalada de Calabaza y Garbanzos',
   'Ensalada tibia de calabaza asada, garbanzos, espinacas y una vinagreta balsámica.',
   250, 9, 12, 35, 8, 8, 3),
  ('Puré de Calabaza con Ajo y Jengibre',
   'Puré de calabaza con un toque de ajo y jengibre.',
   220, 4, 8, 35, 9, 8, 3),
  ('Calabaza en Curry',
   'Calabaza cocida con salsa de curry, coco y espinacas.',
   250, 6, 10, 40, 12, 8, 3),
  ('Chips de Calabaza al Horno',
   'Chips crujientes de calabaza asada al horno con sal y pimienta.',
   150, 3, 6, 35, 4, 8, 3),
  ('Cardo a la Navarra',
   'Cardo cocido con jamón y huevo, típico de la cocina española.',
   180, 6, 8, 25, 7, 8, 3),
  ('Cardo con Almendras',
   'Cardo salteado con almendras y ajo.',
   220, 5, 7, 30, 10, 8, 3),
  ('Cardo con Salsa de Tomate',
   'Cardo cocido en salsa de tomate casera.',
   150, 4, 9, 25, 5, 8, 3),
  ('Cardo en Salsa de Almendras',
   'Cardo cocido y acompañado de una salsa cremosa de almendras.',
   250, 6, 8, 20, 14, 8, 3),
  ('Cardo con Setas',
   'Cardo cocido con setas variadas y un toque de aceite de oliva.',
   220, 6, 10, 28, 8, 8, 3),
  ('Cardo a la Plancha',
   'Cardo a la plancha con aceite de oliva y sal.',
   180, 3, 7, 30, 6, 8, 3),
  ('Cardo en Tempura',
   'Cardo frito en tempura, crujiente y ligero.',
   300, 4, 6, 45, 12, 8, 3),
  ('Cardo con Piquillos',
   'Cardo cocido con pimientos del piquillo y cebolla.',
   250, 5, 8, 30, 9, 8, 3),
  ('Cardo a la Crema',
   'Cardo cocido con una crema de nata y queso.',
   300, 6, 6, 20, 18, 8, 3),
  ('Cardo en Ensalada',
   'Cardo cocido y frío, acompañado de lechuga y aderezo de aceite y vinagre.',
   180, 4, 7, 25, 8, 8, 3),
  ('Coliflor al Horno con Ajo y Aceite de Oliva',
   'Coliflor horneada con ajo, aceite de oliva y un toque de sal.',
   180, 5, 9, 15, 10, 8, 3),
  ('Coliflor con Bechamel Ligera',
   'Coliflor cocida acompañada de una bechamel ligera y gratinada al horno.',
   220, 7, 8, 18, 12, 8, 3),
  ('Puré de Coliflor',
   'Puré suave de coliflor, ideal como acompañamiento de platos principales.',
   150, 4, 7, 20, 8, 8, 3),
  ('Coliflor a la Parrilla',
   'Coliflor troceada y asada a la parrilla con aceite y especias.',
   180, 4, 10, 20, 9, 8, 3),
  ('Ensalada de Coliflor y Garbanzos',
   'Coliflor cocida y mezclada con garbanzos, aderezada con aceite de oliva y limón.',
   210, 8, 10, 25, 9, 8, 3),
  ('Coliflor con Curry',
   'Coliflor cocida con salsa de curry y leche de coco.',
   230, 6, 7, 25, 12, 8, 3),
  ('Croquetas de Coliflor',
   'Croquetas de coliflor empanadas y fritas, ideales para una merienda o aperitivo.',
   280, 6, 8, 30, 14, 8, 3),
  ('Sopa de Coliflor',
   'Sopa cremosa de coliflor con caldo vegetal y un toque de crema ligera.',
   180, 5, 9, 18, 7, 8, 3),
  ('Coliflor Salteada con Pimientos',
   'Coliflor salteada con pimientos rojos y verdes, aderezada con aceite de oliva.',
   200, 5, 10, 18, 10, 8, 3),
  ('Pizza de Coliflor',
   'Base de pizza hecha con coliflor triturada, cubierta con tomate y queso.',
   250, 12, 8, 18, 14, 8, 3),
  ('Espárragos Verdes a la Parrilla',
   'Espárragos verdes asados a la parrilla con aceite de oliva y sal.',
   80, 3, 3, 6, 5, 8, 3),
  ('Crema de Espárragos Verdes',
   'Crema suave de espárragos verdes con caldo vegetal y un toque de crema.',
   120, 4, 5, 12, 7, 8, 3),
  ('Espárragos Verdes con Jamón Serrano',
   'Espárragos verdes salteados con jamón serrano y un toque de aceite de oliva.',
   150, 8, 4, 7, 10, 8, 3),
  ('Ensalada de Espárragos Verdes y Tomate',
   'Ensalada fresca de espárragos verdes con tomate, aceite de oliva y vinagre balsámico.',
   100, 4, 5, 8, 6, 8, 3),
  ('Espárragos Verdes Salteados con Ajo',
   'Espárragos salteados con ajo y aceite de oliva, acompañados con un toque de limón.',
   110, 3, 4, 8, 8, 8, 3),
  ('Espárragos Verdes con Huevo Poché',
   'Espárragos verdes acompañados de huevo pochado, ideales para una comida ligera.',
   160, 9, 5, 8, 10, 8, 3),
  ('Quiche de Espárragos Verdes',
   'Quiche con espárragos verdes, huevo, queso bajo en grasa y base de masa integral.',
   250, 12, 6, 20, 14, 8, 3),
  ('Espárragos Verdes con Almendras',
   'Espárragos verdes cocidos y servidos con almendras tostadas y un toque de aceite de oliva.',
   180, 5, 6, 10, 14, 8, 3),
  ('Espárragos Verdes al Horno con Parmesano',
   'Espárragos horneados con queso parmesano rallado y hierbas aromáticas.',
   160, 6, 4, 10, 12, 8, 3),
  ('Espárragos Verdes con Salsa de Yogur',
   'Espárragos verdes servidos con una ligera salsa de yogur y hierbas frescas.',
   120, 5, 5, 8, 7, 8, 3),
  ('Puerros a la Parrilla',
   'Puerros asados a la parrilla con un toque de aceite de oliva y sal.',
   80, 2, 4, 7, 5, 8, 3),
  ('Crema de Puerro y Patata',
   'Crema suave de puerro y patata, perfecta para días fríos.',
   150, 4, 6, 20, 7, 8, 3),
  ('Puerros Salteados con Ajo',
   'Puerros salteados con ajo y un toque de aceite de oliva.',
   100, 3, 5, 10, 6, 8, 3),
  ('Ensalada de Puerros y Tomate',
   'Ensalada fresca de puerro y tomate con vinagreta de mostaza.',
   110, 3, 6, 8, 7, 8, 3),
  ('Tarta de Puerros y Queso',
   'Tarta de puerro con una base de masa integral y queso rallado.',
   250, 8, 7, 22, 15, 8, 3),
  ('Puerros con Salsa de Mostaza',
   'Puerros cocidos servidos con una salsa de mostaza y miel.',
   120, 3, 4, 9, 8, 8, 3),
  ('Puerros en Tempura',
   'Puerros rebozados en tempura y fritos hasta quedar crujientes.',
   200, 4, 6, 25, 10, 8, 3),
  ('Sopa de Puerros y Zanahoria',
   'Sopa ligera de puerro y zanahoria con un toque de jengibre.',
   140, 3, 8, 15, 5, 8, 3),
  ('Puerros al Horno con Parmesano',
   'Puerros horneados con queso parmesano rallado y hierbas.',
   160, 6, 5, 12, 10, 8, 3),
  ('Puerros con Huevo Pochado',
   'Puerros cocidos servidos con huevo pochado y salsa ligera.',
   170, 9, 6, 10, 10, 8, 3),
  ('Ensalada de Rábano y Zanahoria',
   'Ensalada fresca de rábano y zanahoria rallada con vinagreta.',
   50, 1, 3, 12, 2, 8, 3),
  ('Rábanos Asados con Ajo',
   'Rábanos asados con ajo y aceite de oliva, acompañados de hierbas.',
   70, 2, 4, 8, 4, 8, 3),
  ('Tartar de Rábano y Aguacate',
   'Tartar de rábano y aguacate con limón y cilantro.',
   150, 3, 6, 14, 10, 8, 3),
  ('Sopa Fría de Rábano y Pepino',
   'Sopa refrescante de rábano y pepino con un toque de menta.',
   90, 2, 4, 15, 2, 8, 3),
  ('Ensalada de Rábano y Tomate',
   'Ensalada ligera de rábano y tomate con aceite de oliva y limón.',
   60, 2, 5, 8, 3, 8, 3),
  ('Rábano al Horno con Miel y Mostaza',
   'Rábanos horneados con una mezcla de miel, mostaza y aceite de oliva.',
   100, 2, 5, 15, 5, 8, 3),
  ('Rábano en Pickles',
   'Rábanos marinados en vinagre, sal y especias para un toque ácido.',
   40, 1, 3, 7, 0, 8, 3),
  ('Rábano con Huevo Pochado',
   'Rodajas de rábano acompañadas de un huevo pochado sobre tostada.',
   160, 7, 5, 12, 10, 8, 3),
  ('Ensalada de Rábano y Apio',
   'Ensalada crujiente de rábano y apio con una vinagreta de mostaza.',
   50, 2, 4, 8, 2, 8, 3),
  ('Rábano con Aceite de Sésamo',
   'Rodajas de rábano con aceite de sésamo tostado y un toque de jengibre.',
   70, 1, 3, 9, 4, 8, 3),
  ('Ensalada de Repollo y Zanahoria',
   'Ensalada crujiente de repollo y zanahoria rallada con aderezo de limón.',
   60, 2, 5, 12, 2, 8, 3),
  ('Repollo Salteado con Ajo',
   'Repollo salteado con ajo y aceite de oliva, una receta sencilla y sabrosa.',
   80, 3, 4, 15, 3, 8, 3),
  ('Rollitos de Repollo Rellenos de Arroz y Verduras',
   'Repollo relleno de arroz integral y verduras, cocido a fuego lento.',
   150, 6, 7, 30, 2, 8, 3),
  ('Sopa de Repollo y Pollo',
   'Sopa reconfortante de repollo con trozos de pollo y caldo de verduras.',
   120, 15, 5, 12, 4, 8, 3),
  ('Repollo al Horno con Queso',
   'Repollo al horno con queso rallado y una capa crujiente dorada.',
   180, 7, 6, 12, 10, 8, 3),
  ('Ensalada de Repollo y Manzana',
   'Ensalada fresca de repollo y manzana con aderezo de mostaza y miel.',
   90, 2, 6, 18, 2, 8, 3),
  ('Repollo en Escabeche',
   'Repollo fermentado en vinagre con hierbas, para un toque ácido y saludable.',
   40, 1, 4, 8, 0, 8, 3),
  ('Repollo Salteado con Tofu',
   'Repollo salteado con tofu y salsa de soja, una receta vegetariana rica en proteínas.',
   140, 8, 6, 10, 8, 8, 3),
  ('Repollo a la Plancha',
   'Rodajas de repollo a la plancha con un toque de aceite de oliva y especias.',
   70, 2, 5, 14, 2, 8, 3),
  ('Sopa de Repollo con Lentejas',
   'Sopa de repollo y lentejas cocida a fuego lento con especias y verduras.',
   160, 8, 10, 28, 3, 8, 3),
  ('Sopa de Nabo y Patata',
   'Sopa ligera de nabo y patata, ideal para una comida reconfortante.',
   90, 2, 5, 20, 1, 8, 3),
  ('Nabo al Horno con Aceite de Oliva',
   'Nabo cortado en rodajas y horneado con aceite de oliva y especias.',
   120, 3, 7, 22, 4, 8, 3),
  ('Ensalada de Nabo y Zanahoria',
   'Ensalada fresca de nabo y zanahoria rallada con aderezo de limón y aceite de oliva.',
   70, 2, 6, 16, 3, 8, 3),
  ('Puré de Nabo y Ajo',
   'Puré cremoso de nabo con ajo, ideal como acompañamiento de platos principales.',
   110, 3, 4, 25, 2, 8, 3),
  ('Nabo Salteado con Tofu',
   'Nabo salteado con tofu y un toque de salsa de soja.',
   140, 8, 5, 15, 7, 8, 3),
  ('Nabo en Escabeche',
   'Nabo encurtido en vinagre con especias, perfecto como aperitivo.',
   50, 1, 4, 9, 0, 8, 3),
  ('Guiso de Nabo con Verduras',
   'Guiso saludable de nabo con zanahorias, cebolla y especias.',
   150, 4, 8, 30, 5, 8, 3),
  ('Tacos de Nabo',
   'Tacos con relleno de nabo sazonado, ideales para una comida ligera.',
   180, 6, 5, 35, 6, 8, 3),
  ('Nabo y Calabacín a la Plancha',
   'Rodajas de nabo y calabacín a la plancha con un toque de aceite de oliva.',
   80, 2, 5, 18, 2, 8, 3),
  ('Ensalada de Nabo con Manzana y Apio',
   'Ensalada fresca y crujiente de nabo, manzana y apio con un toque de limón.',
   90, 2, 6, 22, 2, 8, 3),
  ('Ajo Asado',
   'Ajo asado en su piel, perfecto para acompañar otros platos o para untar en pan.',
   40, 1, 1, 9, 0, 8, 3),
  ('Espaguetis al Ajo y Aceite',
   'Espaguetis con ajo, aceite de oliva y guindilla, una receta clásica italiana.',
   350, 8, 3, 65, 10, 8, 3),
  ('Pollo al Ajo',
   'Pollo cocinado lentamente con ajo, hierbas y un toque de vino blanco.',
   250, 28, 2, 6, 12, 8, 3),
  ('Crema de Ajo',
   'Crema suave de ajo ideal como aperitivo o acompañante de platos.',
   100, 3, 2, 15, 4, 8, 3),
  ('Ajo en Aceite de Oliva',
   'Ajo macerado en aceite de oliva, ideal para aderezos o para añadir a ensaladas.',
   90, 2, 1, 4, 8, 8, 3),
  ('Pan de Ajo',
   'Pan tostado con mantequilla de ajo y perejil, ideal como acompañante o aperitivo.',
   180, 4, 2, 30, 6, 8, 3),
  ('Sopa de Ajo',
   'Sopa reconfortante de ajo, caldo y huevo, una receta tradicional.',
   150, 6, 3, 12, 8, 8, 3),
  ('Gambas al Ajillo',
   'Gambas salteadas con ajo y guindilla, un plato rápido y sabroso.',
   220, 24, 2, 2, 12, 8, 3),
  ('Ajo Negro en Vinagre',
   'Ajo fermentado en vinagre, con un sabor dulce y suave, ideal para acompañar platos.',
   60, 2, 3, 10, 0, 8, 3),
  ('Verduras al Ajo',
   'Verduras salteadas con ajo, aceite de oliva y especias, perfectas como acompañamiento.',
   150, 3, 6, 25, 6, 8, 3),
  ('Crema de Calabacín',
   'Una crema suave y ligera de calabacín, ideal como entrada o plato principal.',
   100, 3, 2, 20, 4, 8, 3),
  ('Calabacín Relleno de Carne',
   'Calabacines cortados y rellenos de carne picada, cebolla y especias, luego horneados.',
   250, 20, 4, 10, 15, 8, 3),
  ('Espaguetis de Calabacín',
   'Calabacín cortado en tiras finas como espaguetis, ideal como alternativa baja en carbohidratos.',
   80, 3, 3, 14, 2, 8, 3),
  ('Calabacín a la Parrilla',
   'Calabacín a la parrilla con un toque de aceite de oliva y especias.',
   50, 2, 3, 10, 3, 8, 3),
  ('Calabacín Salteado con Ajo',
   'Calabacín salteado con ajo y aceite de oliva, un plato ligero y sabroso.',
   90, 2, 3, 15, 5, 8, 3),
  ('Ensalada de Calabacín y Tomate',
   'Ensalada fresca de calabacín y tomate con aceite de oliva y hierbas.',
   100, 3, 4, 12, 7, 8, 3),
  ('Lasagna de Calabacín',
   'Lasagna ligera utilizando calabacín en lugar de pasta, con carne y salsa de tomate.',
   350, 25, 6, 25, 18, 8, 3),
  ('Tarta de Calabacín',
   'Tarta salada de calabacín con queso, huevo y hierbas, perfecta para un almuerzo o cena ligera.',
   220, 10, 3, 15, 14, 8, 3),
  ('Frittata de Calabacín',
   'Frittata italiana de calabacín, cebolla, huevo y queso, fácil de hacer y deliciosa.',
   200, 15, 3, 6, 14, 8, 3),
  ('Sopa de Calabacín y Jengibre',
   'Sopa suave de calabacín con un toque de jengibre, ideal para los días fríos.',
   120, 3, 4, 18, 4, 8, 3),


-- EMBUTIDOS: categoria_id=9, tipo_id=3
  ('Ensalada de Jamón Ibérico y Rúcula',
   'Ensalada fresca de rúcula con finas lonchas de jamón ibérico y aceite de oliva',
   150, 10, 1, 3, 11, 9, 3),
  ('Tostadas con Tomate y Jamón Ibérico',
   'Tostadas de pan integral con tomate triturado y jamón ibérico',
   180, 9, 2, 20, 8, 9, 3),
  ('Melón con Jamón Ibérico',
   'Rodajas frescas de melón dulce acompañadas de jamón ibérico',
   90, 6, 1, 8, 4, 9, 3),
  ('Huevos Rotos con Jamón Ibérico',
   'Huevos cocidos a baja temperatura con jamón ibérico y pimientos',
   210, 14, 1, 5, 16, 9, 3),
  ('Brochetas de Jamón Ibérico y Mozzarella',
   'Brochetas de mozzarella fresca y jamón ibérico con un toque de albahaca',
   130, 8, 0, 2, 10, 9, 3),
  ('Alcachofas al Horno con Jamón Ibérico',
   'Alcachofas horneadas con trozos de jamón ibérico y especias',
   100, 7, 4, 6, 5, 9, 3),
  ('Espárragos con Jamón Ibérico y Parmesano',
   'Espárragos a la plancha con jamón ibérico y virutas de parmesano',
   120, 10, 2, 3, 8, 9, 3),
  ('Crema de Calabacín con Jamón Ibérico',
   'Crema suave de calabacín con trozos de jamón ibérico como topping',
   90, 5, 2, 8, 4, 9, 3),
  ('Tortilla de Espinacas y Jamón Ibérico',
   'Tortilla de huevo con espinacas frescas y trocitos de jamón ibérico',
   160, 12, 2, 4, 11, 9, 3),
  ('Champiñones Rellenos de Jamón Ibérico',
   'Champiñones al horno rellenos de jamón ibérico y un toque de ajo',
   110, 6, 1, 4, 8, 9, 3),
  ('Guiso de Chorizo y Patatas',
   'Guiso casero de chorizo con patatas y verduras.',
   350, 25, 5, 30, 20, 9, 3),
  ('Chorizo a la Sidra',
   'Chorizo cocinado a fuego lento en sidra, con un toque de especias.',
   280, 20, 1, 8, 20, 9, 3),
  ('Huevos Rotos con Chorizo',
   'Huevos fritos acompañados de chorizo y patatas fritas.',
   450, 25, 3, 30, 30, 9, 3),
  ('Chorizo al Vino',
   'Chorizo cocinado en vino tinto con cebolla y especias.',
   300, 22, 2, 8, 22, 9, 3),
  ('Paella de Chorizo',
   'Paella con arroz, chorizo, pimientos y otros ingredientes.',
   380, 20, 4, 45, 15, 9, 3),
  ('Pizza de Chorizo',
   'Pizza casera con salsa de tomate, queso y chorizo.',
   400, 18, 3, 40, 20, 9, 3),
  ('Sopa de Chorizo y Lentejas',
   'Sopa espesa de lentejas con chorizo y especias.',
   330, 22, 10, 35, 12, 9, 3),
  ('Chorizo en Salsa de Tomate',
   'Chorizo cocinado en una salsa de tomate casera.',
   270, 20, 3, 10, 18, 9, 3),
  ('Chorizo y Arroz',
   'Arroz con chorizo y verduras salteadas.',
   350, 20, 4, 45, 15, 9, 3),
  ('Tacos de Chorizo',
   'Tacos con chorizo, cebolla, cilantro y salsa.',
   320, 18, 4, 30, 18, 9, 3),
  ('Tosta de Salchichón y Queso',
   'Tosta de pan con salchichón, queso manchego y un toque de aceite de oliva.',
   280, 18, 2, 20, 18, 9, 3),
  ('Ensalada de Salchichón y Tomate',
   'Ensalada fresca con tomate, lechuga, salchichón y aliño de aceite de oliva.',
   250, 15, 3, 10, 18, 9, 3),
  ('Bocadillo de Salchichón y Pimientos Asados',
   'Bocadillo de salchichón con pimientos asados y un toque de aceite de oliva.',
   350, 20, 4, 30, 20, 9, 3),
  ('Pasta con Salchichón y Champiñones',
   'Pasta con salchichón, champiñones y una salsa cremosa.',
   400, 22, 5, 45, 18, 9, 3),
  ('Pizza de Salchichón',
   'Pizza casera con salchichón, tomate, queso y especias.',
   420, 18, 3, 40, 25, 9, 3),
  ('Tacos de Salchichón',
   'Tacos con salchichón, cebolla, cilantro y salsa picante.',
   330, 20, 4, 25, 18, 9, 3),
  ('Ensalada de Salchichón y Garbanzos',
   'Ensalada con salchichón, garbanzos cocidos, cebolla y pimientos.',
   350, 20, 10, 30, 15, 9, 3),
  ('Salchichón con Huevo Frito',
   'Salchichón acompañado de huevo frito y patatas a la brasa.',
   400, 22, 4, 30, 28, 9, 3),
  ('Revuelto de Salchichón con Espárragos',
   'Revuelto de salchichón y espárragos con huevo.',
   300, 18, 4, 10, 22, 9, 3),
  ('Galletas Saladas con Salchichón',
   'Galletas saladas con trozos de salchichón, queso y hierbas.',
   250, 12, 2, 30, 14, 9, 3),
  ('Tosta de Lomo Embuchado y Queso Manchego',
   'Tosta de pan con lomo embuchado y queso manchego, acompañada de un toque de aceite de oliva.',
   320, 22, 2, 18, 20, 9, 3),
  ('Ensalada de Lomo Embuchado y Tomate',
   'Ensalada fresca con tomate, lechuga, lomo embuchado y aliño de aceite de oliva.',
   290, 18, 4, 12, 18, 9, 3),
  ('Bocadillo de Lomo Embuchado y Pimientos Asados',
   'Bocadillo de lomo embuchado con pimientos asados y un toque de aceite de oliva.',
   370, 22, 5, 30, 22, 9, 3),
  ('Pasta con Lomo Embuchado y Espinacas',
   'Pasta con lomo embuchado, espinacas y una salsa ligera de aceite de oliva y ajo.',
   420, 25, 6, 40, 24, 9, 3),
  ('Pizza de Lomo Embuchado y Champiñones',
   'Pizza casera con lomo embuchado, champiñones, tomate y queso.',
   460, 20, 4, 42, 28, 9, 3),
  ('Tacos de Lomo Embuchado con Guacamole',
   'Tacos con lomo embuchado, guacamole, cebolla morada y cilantro fresco.',
   340, 22, 6, 28, 20, 9, 3),
  ('Ensalada de Lomo Embuchado y Garbanzos',
   'Ensalada con lomo embuchado, garbanzos cocidos, cebolla, pimientos y un toque de vinagre balsámico.',
   380, 24, 10, 30, 18, 9, 3),
  ('Lomo Embuchado con Huevo y Patatas',
   'Lomo embuchado acompañado de huevo frito y patatas a la brasa.',
   480, 30, 5, 40, 30, 9, 3),
  ('Revuelto de Lomo Embuchado con Pimientos',
   'Revuelto de lomo embuchado con pimientos de colores y huevo.',
   350, 22, 4, 18, 22, 9, 3),
  ('Empanadas de Lomo Embuchado y Queso',
   'Empanadas rellenas de lomo embuchado y queso manchego, horneadas hasta dorarse.',
   400, 20, 2, 45, 22, 9, 3),
  ('Sándwich de Jamón Cocido y Queso',
   'Sándwich clásico con jamón cocido, queso y pan integral.',
   280, 20, 3, 30, 10, 9, 3),
  ('Ensalada de Jamón Cocido con Manzana',
   'Ensalada fresca con jamón cocido, manzana, lechuga y aderezo de mostaza.',
   250, 18, 5, 20, 12, 9, 3),
  ('Tortilla de Jamón Cocido y Espinacas',
   'Tortilla ligera con jamón cocido y espinacas.',
   230, 22, 4, 6, 14, 9, 3),
  ('Rollitos de Jamón Cocido con Queso',
   'Rollitos de jamón cocido rellenos de queso fresco y espárragos.',
   180, 15, 2, 4, 12, 9, 3),
  ('Pizza de Jamón Cocido y Champiñones',
   'Pizza con base de pan integral, jamón cocido y champiñones.',
   320, 25, 6, 35, 15, 9, 3),
  ('Jamón Cocido con Puré de Patatas',
   'Jamón cocido servido con puré de patatas cremoso.',
   400, 30, 4, 45, 15, 9, 3),
  ('Ensalada de Pasta con Jamón Cocido',
   'Ensalada de pasta con jamón cocido, tomate y pepino.',
   350, 18, 5, 45, 10, 9, 3),
  ('Sopa de Jamón Cocido y Guisantes',
   'Sopa caliente con jamón cocido, guisantes y zanahorias.',
   250, 18, 7, 30, 6, 9, 3),
  ('Croquetas de Jamón Cocido',
   'Croquetas crujientes de jamón cocido con bechamel.',
   350, 20, 3, 30, 20, 9, 3),
  ('Jamón Cocido con Huevo y Espárragos',
   'Jamón cocido acompañado de huevo revuelto y espárragos a la plancha.',
   300, 25, 4, 8, 18, 9, 3),


-- Frutas

-- FRUTAS: categoria_id=10, tipo_id=3

-- (1) Ensalada de Fresas y Espinacas
('Ensalada de Fresas y Espinacas',
 'Ensalada fresca con fresas, espinacas, queso de cabra y nueces.',
  180, 5, 4, 22, 9,
  10, 3),

-- (2) Smoothie de Fresas y Plátano
('Smoothie de Fresas y Plátano',
 'Batido refrescante de fresas y plátano con leche de almendra.',
  220, 3, 5, 40, 4,
  10, 3),

-- (3) Tarta de Fresas y Crema
('Tarta de Fresas y Crema',
 'Tarta de base crujiente con fresas frescas y crema pastelera.',
  300, 6, 3, 45, 15,
  10, 3),

-- (4) Yogur con Fresas y Miel
('Yogur con Fresas y Miel',
 'Yogur natural con fresas frescas y un toque de miel.',
  180, 6, 3, 30, 4,
  10, 3),

-- (5) Ensalada de Fresas con Queso Fresco
('Ensalada de Fresas con Queso Fresco',
 'Ensalada ligera con fresas, queso fresco y un toque de aceite de oliva.',
  150, 6, 4, 22, 7,
  10, 3),

-- (6) Fresas con Chocolate
('Fresas con Chocolate',
 'Fresas frescas cubiertas con chocolate negro derretido.',
  220, 2, 4, 30, 12,
  10, 3),

-- (7) Mermelada de Fresas Casera
('Mermelada de Fresas Casera',
 'Mermelada casera de fresas, perfecta para untar en pan o galletas.',
  150, 1, 2, 40, 0,
  10, 3),

-- (8) Pudding de Chía y Fresas
('Pudding de Chía y Fresas',
 'Pudding de chía con fresas frescas y un toque de vainilla.',
  250, 6, 8, 28, 12,
  10, 3),

-- (9) Helado de Fresa Casero
('Helado de Fresa Casero',
 'Helado casero de fresas sin azúcar añadido, cremoso y natural.',
  180, 3, 4, 25, 6,
  10, 3),

-- (10) Fresas al Balsámico
('Fresas al Balsámico',
 'Fresas marinadas en vinagre balsámico y azúcar, perfectas como postre o acompañamiento.',
  120, 1, 3, 28, 0,
  10, 3),

  
-- PLÁTANO: categoria_id=10, tipo_id=3

-- (1) Smoothie de Plátano y Espinacas
('Smoothie de Plátano y Espinacas',
 'Batido saludable de plátano y espinacas con leche de almendra.',
  200, 3, 5, 35, 4,
  10, 3),

-- (2) Panqueques de Plátano
('Panqueques de Plátano',
 'Panqueques esponjosos de plátano, perfectos para el desayuno.',
  250, 6, 4, 45, 8,
  10, 3),

-- (3) Tarta de Plátano y Chocolate
('Tarta de Plátano y Chocolate',
 'Tarta de plátano con chocolate derretido y una base crujiente.',
  320, 5, 3, 50, 15,
  10, 3),

-- (4) Plátanos Asados con Miel y Canela
('Plátanos Asados con Miel y Canela',
 'Plátanos asados con un toque de miel y canela.',
  150, 2, 3, 35, 1,
  10, 3),

-- (5) Helado de Plátano y Fresas
('Helado de Plátano y Fresas',
 'Helado casero de plátano y fresas sin azúcar añadido.',
  180, 2, 5, 40, 2,
  10, 3),

-- (6) Plátano con Yogur y Granola
('Plátano con Yogur y Granola',
 'Plátano en rodajas con yogur natural y granola crujiente.',
  220, 7, 4, 40, 6,
  10, 3),

-- (7) Muffins de Plátano y Nueces
('Muffins de Plátano y Nueces',
 'Muffins caseros de plátano y nueces, ideales para un snack.',
  280, 6, 4, 50, 10,
  10, 3),

-- (8) Tostadas con Plátano y Mantequilla de Almendras
('Tostadas con Plátano y Mantequilla de Almendras',
 'Tostadas de pan integral con plátano en rodajas y mantequilla de almendras.',
  220, 6, 5, 35, 8,
  10, 3),

-- (9) Batido de Plátano y Avena
('Batido de Plátano y Avena',
 'Batido energético con plátano y avena, ideal para empezar el día.',
  230, 5, 6, 45, 4,
  10, 3),

-- (10) Galletas de Plátano y Avena
('Galletas de Plátano y Avena',
 'Galletas suaves de plátano y avena, perfectas para un snack saludable.',
  180, 4, 5, 40, 3,
  10, 3),
  
  
-- MANGO
-- (1) Smoothie de Mango y Piña
('Smoothie de Mango y Piña',
 'Batido refrescante de mango y piña con leche de coco.',
  180, 2, 4, 40, 3,
  10, 3),
-- (2) Ensalada de Mango y Aguacate
('Ensalada de Mango y Aguacate',
 'Ensalada fresca con mango, aguacate y un toque de lima.',
  220, 3, 5, 30, 15,
  10, 3),
-- (3) Tarta de Mango y Coco
('Tarta de Mango y Coco',
 'Tarta dulce de mango con una base de coco.',
  280, 4, 3, 45, 12,
  10, 3),
-- (4) Salsa de Mango para Ensalada
('Salsa de Mango para Ensalada',
 'Salsa cremosa de mango para acompañar ensaladas o carnes a la parrilla.',
  100, 1, 2, 25, 2,
  10, 3),
-- (5) Helado de Mango Casero
('Helado de Mango Casero',
 'Helado natural de mango sin azúcar añadido.',
  150, 1, 4, 35, 1,
  10, 3),
-- (6) Curry de Pollo con Mango
('Curry de Pollo con Mango',
 'Pollo en salsa de curry con trozos de mango, un plato exótico.',
  350, 25, 5, 40, 15,
  10, 3),
-- (7) Batido de Mango y Yogur
('Batido de Mango y Yogur',
 'Batido cremoso de mango con yogur natural.',
  200, 6, 3, 40, 2,
  10, 3),
-- (8) Ensalada de Mango, Pepino y Menta
('Ensalada de Mango, Pepino y Menta',
 'Ensalada fresca con mango, pepino y hojas de menta.',
  150, 2, 5, 30, 2,
  10, 3),
-- (9) Muffins de Mango y Limón
('Muffins de Mango y Limón',
 'Muffins suaves de mango con un toque de limón.',
  230, 4, 3, 45, 8,
  10, 3),
-- (10) Tacos de Mango con Pollo
('Tacos de Mango con Pollo',
 'Tacos de pollo con salsa de mango y verduras frescas.',
  250, 18, 4, 35, 7,
  10, 3),

-- COCO
-- (1) Smoothie de Coco y Piña
('Smoothie de Coco y Piña',
 'Batido tropical de coco y piña con un toque de miel.',
  200, 2, 3, 35, 7,
  10, 3),
-- (2) Curry de Pollo al Coco
('Curry de Pollo al Coco',
 'Pollo en una salsa cremosa de coco con especias y verduras.',
  350, 25, 4, 30, 18,
  10, 3),
-- (3) Galletas de Coco y Avena
('Galletas de Coco y Avena',
 'Galletas ligeras y saludables de coco y avena.',
  150, 3, 4, 20, 7,
  10, 3),
-- (4) Ensalada Tropical con Coco
('Ensalada Tropical con Coco',
 'Ensalada fresca con mango, aguacate y coco rallado.',
  180, 3, 5, 20, 10,
  10, 3),
-- (5) Arroz con Coco
('Arroz con Coco',
 'Arroz cocido con leche de coco, ideal como acompañamiento.',
  250, 4, 2, 45, 9,
  10, 3),
-- (6) Pan de Coco
('Pan de Coco',
 'Pan casero de coco, perfecto para acompañar desayunos.',
  200, 3, 3, 30, 9,
  10, 3),
-- (7) Batido de Coco y Mango
('Batido de Coco y Mango',
 'Batido cremoso con mango y leche de coco.',
  220, 2, 4, 40, 8,
  10, 3),
-- (8) Trufas de Coco y Cacao
('Trufas de Coco y Cacao',
 'Dulce saludable a base de coco y cacao, ideal para postre.',
  120, 3, 2, 18, 7,
  10, 3),
-- (9) Pollo en Salsa de Coco y Lima
('Pollo en Salsa de Coco y Lima',
 'Pollo en una deliciosa salsa cremosa de coco y lima.',
  300, 25, 3, 25, 15,
  10, 3),
-- (10) Pudding de Chía y Coco
('Pudding de Chía y Coco',
 'Pudding de chía con leche de coco, ideal para un desayuno saludable.',
  180, 5, 8, 20, 9,
  10, 3),

-- ARÁNDANOS
-- (1) Smoothie de Arándanos y Plátano
('Smoothie de Arándanos y Plátano',
 'Batido fresco y saludable de arándanos y plátano.',
  180, 3, 4, 35, 2,
  10, 3),
-- (2) Ensalada de Arándanos y Queso de Cabra
('Ensalada de Arándanos y Queso de Cabra',
 'Ensalada fresca con arándanos, queso de cabra y nueces.',
  220, 7, 5, 25, 12,
  10, 3),
-- (3) Muffins de Arándanos
('Muffins de Arándanos',
 'Deliciosos muffins caseros de arándanos, perfectos para el desayuno.',
  150, 3, 2, 25, 5,
  10, 3),
-- (4) Tarta de Arándanos
('Tarta de Arándanos',
 'Tarta de arándanos con masa crujiente y crema suave.',
  280, 4, 3, 40, 12,
  10, 3),
-- (5) Yogur con Arándanos y Miel
('Yogur con Arándanos y Miel',
 'Yogur natural con arándanos frescos y un toque de miel.',
  150, 8, 3, 20, 5,
  10, 3),
-- (6) Ensalada de Arándanos y Espinacas
('Ensalada de Arándanos y Espinacas',
 'Ensalada fresca de espinacas, arándanos y almendras.',
  180, 5, 6, 20, 9,
  10, 3),
-- (7) Granola Casera con Arándanos
('Granola Casera con Arándanos',
 'Granola casera con arándanos, nueces y miel.',
  220, 6, 5, 30, 10,
  10, 3),
-- (8) Arándanos con Avena y Almendras
('Arándanos con Avena y Almendras',
 'Desayuno de avena con arándanos y almendras tostadas.',
  200, 6, 7, 30, 7,
  10, 3),
-- (9) Batido de Arándanos y Espinacas
('Batido de Arándanos y Espinacas',
 'Batido energético con arándanos y espinacas frescas.',
  170, 3, 5, 30, 3,
  10, 3),
-- (10) Helado de Arándanos y Yogur
('Helado de Arándanos y Yogur',
 'Helado casero de arándanos y yogur, ideal para el verano.',
  180, 5, 3, 25, 8,
  10, 3),

-- PIÑA
-- (1) Ensalada de Piña y Aguacate
('Ensalada de Piña y Aguacate',
 'Ensalada refrescante con piña, aguacate y cilantro.',
  180, 3, 5, 30, 7,
  10, 3),
-- (2) Batido de Piña y Coco
('Batido de Piña y Coco',
 'Batido tropical de piña y coco, ideal para el verano.',
  210, 2, 3, 40, 8,
  10, 3),
-- (3) Piña a la Parrilla con Miel
('Piña a la Parrilla con Miel',
 'Rodajas de piña a la parrilla con un toque de miel.',
  120, 1, 2, 30, 0,
  10, 3),
-- (4) Ensalada Tropical de Piña y Mango
('Ensalada Tropical de Piña y Mango',
 'Ensalada fresca de piña, mango y pepino con un aderezo de lima.',
  150, 2, 4, 35, 3,
  10, 3),
-- (5) Arroz con Piña y Pollo
('Arroz con Piña y Pollo',
 'Arroz integral con trozos de piña y pollo a la plancha.',
  350, 25, 5, 45, 8,
  10, 3),
-- (6) Tarta de Piña y Coco
('Tarta de Piña y Coco',
 'Tarta ligera de piña y coco con una base crujiente.',
  250, 4, 3, 40, 10,
  10, 3),
-- (7) Piña Colada Saludable
('Piña Colada Saludable',
 'Cóctel sin alcohol con piña y leche de coco, ideal para refrescarse.',
  180, 1, 4, 38, 4,
  10, 3),
-- (8) Brochetas de Piña y Pollo
('Brochetas de Piña y Pollo',
 'Brochetas de piña y pollo marinadas en especias, perfectas para la parrilla.',
  250, 28, 3, 20, 7,
  10, 3),
-- (9) Piña Rellena de Arroz y Verduras
('Piña Rellena de Arroz y Verduras',
 'Piña fresca rellena de arroz integral y verduras salteadas.',
  300, 6, 6, 55, 7,
  10, 3),
-- (10) Smoothie de Piña y Espinacas
('Smoothie de Piña y Espinacas',
 'Batido energético de piña, espinacas y manzana verde.',
  160, 3, 5, 35, 1,
  10, 3),

-- MANZANA
-- (1) Ensalada de Manzana y Nueces
('Ensalada de Manzana y Nueces',
 'Ensalada fresca con manzana, nueces y aderezo de yogur.',
  180, 2, 5, 30, 8,
  10, 3),
-- (2) Batido de Manzana y Canela
('Batido de Manzana y Canela',
 'Batido energizante de manzana, canela y yogur natural.',
  160, 3, 4, 35, 2,
  10, 3),
-- (3) Tarta de Manzana y Canela
('Tarta de Manzana y Canela',
 'Deliciosa tarta de manzana con un toque de canela.',
  250, 3, 4, 45, 10,
  10, 3),
-- (4) Manzana Asada con Miel y Almendras
('Manzana Asada con Miel y Almendras',
 'Manzana asada con miel y almendras, perfecta para el postre.',
  220, 2, 5, 40, 7,
  10, 3),
-- (5) Ensalada de Manzana, Zanahoria y Pipas
('Ensalada de Manzana, Zanahoria y Pipas',
 'Ensalada de manzana, zanahoria rallada y pipas de girasol.',
  170, 3, 6, 25, 9,
  10, 3),
-- (6) Manzana Rellena de Avena y Pasas
('Manzana Rellena de Avena y Pasas',
 'Manzanas rellenas de avena, pasas y canela, horneadas al gusto.',
  230, 4, 6, 50, 4,
  10, 3),
-- (7) Compota de Manzana y Pera
('Compota de Manzana y Pera',
 'Compota casera de manzana y pera, ideal para postres ligeros.',
  150, 1, 5, 35, 0,
  10, 3),
-- (8) Manzana con Queso y Miel
('Manzana con Queso y Miel',
 'Manzana acompañada de queso fresco y un toque de miel.',
  200, 5, 4, 30, 9,
  10, 3),
-- (9) Ensalada de Manzana y Apio
('Ensalada de Manzana y Apio',
 'Ensalada ligera de manzana, apio, nueces y aderezo de mostaza.',
  150, 2, 6, 25, 6,
  10, 3),
-- (10) Muffins de Manzana y Avena
('Muffins de Manzana y Avena',
 'Muffins caseros de manzana y avena, perfectos para un desayuno saludable.',
  200, 5, 4, 40, 6,
  10, 3),

-- MANDARINA
-- (1) Ensalada de Mandarina y Aguacate
('Ensalada de Mandarina y Aguacate',
 'Ensalada fresca con gajos de mandarina y aguacate, aderezada con vinagreta.',
  180, 2, 5, 25, 8,
  10, 3),
-- (2) Batido de Mandarina y Jengibre
('Batido de Mandarina y Jengibre',
 'Batido refrescante de mandarina con un toque de jengibre.',
  160, 2, 4, 35, 1,
  10, 3),
-- (3) Tarta de Mandarina y Yogur
('Tarta de Mandarina y Yogur',
 'Tarta ligera con base de galleta, relleno de yogur y cubierta de gajos de mandarina.',
  240, 4, 3, 40, 10,
  10, 3),
-- (4) Ensalada de Mandarina, Remolacha y Queso de Cabra
('Ensalada de Mandarina, Remolacha y Queso de Cabra',
 'Ensalada fresca con gajos de mandarina, remolacha cocida y queso de cabra.',
  220, 6, 7, 25, 14,
  10, 3),
-- (5) Mandarinas Asadas con Miel y Almendras
('Mandarinas Asadas con Miel y Almendras',
 'Mandarinas asadas con miel, almendras y un toque de canela.',
  200, 3, 5, 45, 7,
  10, 3),
-- (6) Sorbete de Mandarina
('Sorbete de Mandarina',
 'Sorbete refrescante de mandarina, ideal para postres ligeros.',
  150, 1, 2, 35, 0,
  10, 3),
-- (7) Mandarina con Yogur y Miel
('Mandarina con Yogur y Miel',
 'Mandarinas frescas acompañadas de yogur natural y un toque de miel.',
  180, 6, 4, 30, 5,
  10, 3),
-- (8) Pollo con Salsa de Mandarina
('Pollo con Salsa de Mandarina',
 'Pechuga de pollo asada con salsa de mandarina y especias.',
  220, 30, 3, 20, 7,
  10, 3),
-- (9) Ensalada de Mandarina, Espinacas y Almendras
('Ensalada de Mandarina, Espinacas y Almendras',
 'Ensalada de mandarina con espinacas frescas y almendras tostadas.',
  190, 5, 6, 30, 8,
  10, 3),
-- (10) Mandarina con Menta y Azúcar
('Mandarina con Menta y Azúcar',
 'Gajos de mandarina con menta fresca y un toque de azúcar moreno.',
  130, 2, 3, 30, 0,
  10, 3),

-- NARANJA
-- (1) Ensalada de Naranja y Aguacate
('Ensalada de Naranja y Aguacate',
 'Ensalada fresca con gajos de naranja y aguacate, aderezada con vinagreta.',
  180, 2, 6, 25, 8,
  10, 3),
-- (2) Jugo Natural de Naranja
('Jugo Natural de Naranja',
 'Jugo fresco hecho con naranjas exprimidas al momento.',
  150, 2, 4, 35, 0,
  10, 3),
-- (3) Pollo a la Naranja
('Pollo a la Naranja',
 'Pechuga de pollo en salsa de naranja con especias.',
  220, 30, 4, 20, 7,
  10, 3),
-- (4) Ensalada de Naranja y Remolacha
('Ensalada de Naranja y Remolacha',
 'Gajos de naranja combinados con remolacha cocida, espinacas y queso feta.',
  210, 5, 7, 28, 10,
  10, 3),
-- (5) Tarta de Naranja y Almendras
('Tarta de Naranja y Almendras',
 'Tarta de base de almendra con un suave relleno de crema de naranja.',
  250, 6, 3, 35, 12,
  10, 3),
-- (6) Sorbete de Naranja
('Sorbete de Naranja',
 'Sorbete refrescante hecho con jugo de naranja natural.',
  130, 1, 2, 32, 0,
  10, 3),
-- (7) Ensalada de Naranja, Mango y Mariscos
('Ensalada de Naranja, Mango y Mariscos',
 'Ensalada refrescante de naranja, mango y mariscos con aderezo de lima.',
  220, 18, 5, 28, 7,
  10, 3),
-- (8) Sopa de Naranja y Zanahoria
('Sopa de Naranja y Zanahoria',
 'Sopa ligera de zanahorias y naranja con un toque de jengibre.',
  180, 3, 6, 40, 4,
  10, 3),
-- (9) Ensalada de Naranja y Pavo
('Ensalada de Naranja y Pavo',
 'Ensalada de gajos de naranja con pechuga de pavo, espinacas y nueces.',
  250, 30, 6, 22, 12,
  10, 3),
-- (10) Bizcocho de Naranja
('Bizcocho de Naranja',
 'Bizcocho esponjoso con jugo y ralladura de naranja, ideal para el desayuno.',
  220, 4, 2, 45, 8,
  10, 3),

-- LIMÓN (grupo ID = 8)

-- (1) Pollo al Limón
('Pollo al Limón',
 'Pechuga de pollo marinada en jugo de limón y hierbas, luego horneada.',
 220, 30, 2, 8, 7,
  8, 3),
-- (2) Ensalada de Limón y Pepino
('Ensalada de Limón y Pepino',
 'Ensalada refrescante con pepino, limón, menta y yogur griego.',
 180, 5, 6, 18, 9,
  8, 3),
-- (3) Tarta de Limón
('Tarta de Limón',
 'Tarta cremosa de limón con base de galleta y cobertura de merengue.',
 280, 4, 2, 45, 10,
  8, 3),
-- (4) Limonada Casera
('Limonada Casera',
 'Bebida refrescante hecha con jugo de limón, agua y azúcar.',
 130, 1, 2, 32, 0,
  8, 3),
-- (5) Salmón al Limón
('Salmón al Limón',
 'Filete de salmón horneado con salsa de limón y hierbas.',
 250, 30, 1, 6, 12,
  8, 3),
-- (6) Ensalada de Limón y Aguacate
('Ensalada de Limón y Aguacate',
 'Ensalada con gajos de limón, aguacate, tomate y cebolla morada.',
 200, 3, 8, 16, 14,
  8, 3),
-- (7) Sopa de Limón y Pollo
('Sopa de Limón y Pollo',
 'Sopa ligera con pollo, limón y arroz, ideal para días fríos.',
 220, 20, 4, 30, 5,
  8, 3),
-- (8) Galletas de Limón
('Galletas de Limón',
 'Galletas crujientes con sabor a limón, perfectas para acompañar té.',
 180, 2, 1, 28, 7,
  8, 3),
-- (9) Ensalada de Limón y Pollo a la Parrilla
('Ensalada de Limón y Pollo a la Parrilla',
 'Ensalada fresca con pollo a la parrilla, limón, espinacas y garbanzos.',
 240, 30, 6, 20, 9,
  8, 3),
-- (10) Mousse de Limón
('Mousse de Limón',
 'Mousse ligera de limón, ideal como postre fresco.',
 180, 3, 2, 28, 8,
  8, 3),

-- MARACUYÁ (grupo ID = 9)

-- (1) Jugo de Maracuyá
('Jugo de Maracuyá',
 'Bebida refrescante a base de jugo de maracuyá, agua y azúcar.',
 130, 1, 2, 30, 0,
  9, 3),
-- (2) Mousse de Maracuyá
('Mousse de Maracuyá',
 'Mousse suave y cremoso de maracuyá, ideal para postre.',
 190, 3, 3, 35, 7,
  9, 3),
-- (3) Ensalada de Maracuyá y Mango
('Ensalada de Maracuyá y Mango',
 'Ensalada fresca con maracuyá, mango, pepino y hojas verdes.',
 180, 3, 7, 28, 5,
  9, 3),
-- (4) Helado de Maracuyá
('Helado de Maracuyá',
 'Helado cremoso de maracuyá, refrescante y afrutado.',
 250, 4, 2, 35, 12,
  9, 3),
-- (5) Tarta de Maracuyá
('Tarta de Maracuyá',
 'Tarta ligera con una base de galleta y crema de maracuyá.',
 300, 5, 3, 40, 15,
  9, 3),
-- (6) Ensalada de Pollo y Maracuyá
('Ensalada de Pollo y Maracuyá',
 'Ensalada de pollo a la parrilla con aderezo de maracuyá, aguacate y hojas verdes.',
 250, 30, 6, 18, 12,
  9, 3),
-- (7) Smoothie de Maracuyá y Banana
('Smoothie de Maracuyá y Banana',
 'Batido de maracuyá, banana, yogur y miel, perfecto para el desayuno.',
 220, 4, 5, 40, 4,
  9, 3),
-- (8) Panna Cotta de Maracuyá
('Panna Cotta de Maracuyá',
 'Panna cotta cremosa con una capa de maracuyá fresco en la parte superior.',
 280, 6, 3, 35, 14,
  9, 3),
-- (9) Sorbete de Maracuyá
('Sorbete de Maracuyá',
 'Sorbete refrescante de maracuyá, perfecto para el verano.',
 150, 1, 2, 36, 0,
  9, 3),
-- (10) Pescado a la Parrilla con Salsa de Maracuyá
('Pescado a la Parrilla con Salsa de Maracuyá',
 'Pescado blanco a la parrilla servido con salsa de maracuyá dulce y picante.',
 270, 30, 2, 18, 12,
  9, 3),

-- CIRUELA (grupo ID = 10)

-- (1) Jugo de Ciruela
('Jugo de Ciruela',
 'Bebida refrescante hecha a base de ciruelas frescas, agua y un toque de azúcar.',
 120, 1, 3, 30, 0,
  10, 3),
-- (2) Tarta de Ciruelas
('Tarta de Ciruelas',
 'Tarta suave con una base crujiente y ciruelas frescas en la parte superior.',
 250, 4, 4, 45, 9,
  10, 3),
-- (3) Ensalada de Ciruelas y Queso de Cabra
('Ensalada de Ciruelas y Queso de Cabra',
 'Ensalada fresca con ciruelas, queso de cabra, nueces y hojas verdes.',
 200, 8, 5, 22, 12,
  10, 3),
-- (4) Compota de Ciruela
('Compota de Ciruela',
 'Compota casera de ciruelas cocidas con azúcar y canela, perfecta para postre.',
 150, 1, 5, 35, 0,
  10, 3),
-- (5) Ciruelas Asadas con Miel
('Ciruelas Asadas con Miel',
 'Ciruelas asadas al horno con miel y un toque de canela, acompañadas de nueces.',
 220, 3, 6, 40, 7,
  10, 3),
-- (6) Batido de Ciruela y Plátano
('Batido de Ciruela y Plátano',
 'Batido energético con ciruelas, plátano y yogur natural.',
 210, 3, 6, 45, 2,
  10, 3),
-- (7) Ciruelas Rellenas de Almendra
('Ciruelas Rellenas de Almendra',
 'Ciruelas deshuesadas rellenas con almendras y cubiertas con chocolate negro.',
 280, 5, 6, 38, 12,
  10, 3),
-- (8) Ensalada de Ciruelas con Pollo
('Ensalada de Ciruelas con Pollo',
 'Ensalada fresca con pollo a la parrilla, ciruelas, aguacate y vinagreta ligera.',
 300, 35, 7, 18, 14,
  10, 3),
-- (9) Sorbete de Ciruela
('Sorbete de Ciruela',
 'Sorbete casero de ciruela, ideal para el verano.',
 140, 1, 3, 32, 0,
  10, 3),
-- (10) Ensalada de Ciruelas y Espinacas
('Ensalada de Ciruelas y Espinacas',
 'Ensalada ligera con ciruelas frescas, espinacas, queso feta y almendras.',
 180, 5, 6, 28, 7,
  10, 3),

-- KIWI
  ('Ensalada de Kiwi y Fresas',
   'Ensalada fresca con rodajas de kiwi, fresas y un toque de menta.',
   120, 2, 4, 30, 0, 10, 3),

  ('Batido de Kiwi y Plátano',
   'Batido energético con kiwi, plátano y yogur natural.',
   180, 3, 5, 40, 2, 10, 3),

  ('Tarta de Kiwi',
   'Tarta de base crujiente con una capa de crema y decorada con rodajas de kiwi.',
   250, 4, 3, 45, 8, 10, 3),

  ('Ensalada de Kiwi y Aguacate',
   'Ensalada fresca con kiwi, aguacate, pepino y cebolla morada.',
   220, 5, 8, 20, 14, 10, 3),

  ('Kiwi Relleno de Yogur y Miel',
   'Kiwi partido por la mitad y relleno de yogur natural y un toque de miel.',
   150, 5, 6, 30, 2, 10, 3),

  ('Ensalada de Kiwi con Espinacas',
   'Ensalada ligera con kiwi, espinacas, nueces y vinagreta balsámica.',
   200, 6, 5, 35, 8, 10, 3),

  ('Kiwi al Horno con Canela',
   'Kiwi asado al horno con un toque de canela, ideal para postres.',
   120, 2, 4, 28, 0, 10, 3),

  ('Sorbete de Kiwi',
   'Sorbete refrescante hecho con kiwi, azúcar y agua.',
   130, 1, 3, 32, 0, 10, 3),

  ('Brochetas de Kiwi y Piña',
   'Brochetas frescas de kiwi y piña, ideales para una merienda saludable.',
   140, 1, 5, 35, 0, 10, 3),

  ('Muffins de Kiwi y Avena',
   'Muffins integrales de avena con trozos de kiwi fresco.',
   180, 4, 5, 38, 6, 10, 3),

  -- SANDÍA
  ('Ensalada de Sandía y Feta',
   'Ensalada fresca de sandía con queso feta, menta y un toque de aceite de oliva.',
   150, 4, 2, 35, 5, 10, 3),

  ('Batido de Sandía y Menta',
   'Refrescante batido de sandía con hojas de menta y un toque de limón.',
   120, 1, 3, 30, 0, 10, 3),

  ('Sorbete de Sandía',
   'Sorbete helado y refrescante hecho a base de sandía y azúcar.',
   100, 1, 3, 25, 0, 10, 3),

  ('Brochetas de Sandía y Queso',
   'Brochetas de sandía combinadas con trozos de queso mozzarella.',
   170, 7, 3, 28, 6, 10, 3),

  ('Ensalada de Sandía y Pepino',
   'Ensalada fresca de sandía, pepino y cebolla roja, aliñada con limón y menta.',
   140, 3, 4, 35, 2, 10, 3),

  ('Sandía con Limón y Sal',
   'Rodajas de sandía acompañadas de jugo de limón y sal, para un toque refrescante.',
   90, 1, 2, 24, 0, 10, 3),

  ('Jugo de Sandía y Jengibre',
   'Jugo natural de sandía con un toque de jengibre fresco.',
   110, 1, 2, 28, 0, 10, 3),

  ('Tarta de Sandía',
   'Tarta de base crujiente con una capa de crema y cubierta con rodajas de sandía.',
   230, 6, 4, 48, 9, 10, 3),

  ('Helado de Sandía',
   'Helado casero de sandía, ideal para el verano.',
   120, 1, 3, 30, 2, 10, 3),

  ('Ensalada de Sandía y Arándanos',
   'Ensalada refrescante con sandía y arándanos, ideal para el calor.',
   130, 2, 5, 35, 1, 10, 3),
   -- CEREZA
  ('Ensalada de Cereza y Espinacas',
   'Ensalada fresca de espinacas, cerezas, nueces y queso de cabra.',
   180, 3, 4, 35, 8, 10, 3),
  ('Batido de Cereza y Plátano',
   'Un batido delicioso de cerezas y plátano con un toque de yogur.',
   150, 2, 3, 35, 1, 10, 3),
  ('Tartaleta de Cereza',
   'Tartaleta de masa crujiente con relleno de crema pastelera y cerezas frescas.',
   220, 4, 2, 35, 10, 10, 3),
  ('Mermelada de Cereza',
   'Mermelada casera de cereza, ideal para untar en pan o galletas.',
   120, 1, 2, 30, 0, 10, 3),
  ('Ensalada de Cereza y Pollo',
   'Ensalada de pollo con cerezas, aguacate y aderezo balsámico.',
   250, 25, 5, 20, 12, 10, 3),
  ('Helado de Cereza',
   'Helado cremoso hecho con cerezas frescas y crema.',
   200, 3, 3, 35, 8, 10, 3),
  ('Sopa Fría de Cereza',
   'Sopa fría de cereza con un toque de menta, perfecta para el verano.',
    90, 1, 2, 22, 0, 10, 3),
  ('Cereza al Vino Tinto',
   'Cereza cocida en vino tinto con azúcar y canela.',
   180, 1, 3, 40, 3, 10, 3),
  ('Tarta de Cereza y Almendra',
   'Tarta de almendra con una capa de cerezas frescas.',
   280, 6, 4, 35, 15, 10, 3),
  ('Smoothie de Cereza y Yogur',
   'Smoothie cremoso de cereza y yogur natural, refrescante y saludable.',
   140, 4, 3, 28, 2, 10, 3),

  -- MELOCOTÓN
  ('Ensalada de Melocotón y Queso de Cabra',
   'Ensalada fresca con melocotones, queso de cabra y nueces.',
   180, 5, 3, 30, 7, 10, 3),
  ('Batido de Melocotón y Plátano',
   'Batido delicioso de melocotón y plátano con leche de almendra.',
   150, 2, 3, 35, 1, 10, 3),
  ('Tarta de Melocotón y Almendra',
   'Tarta de melocotón con base de almendras y crema pastelera.',
   220, 5, 4, 30, 12, 10, 3),
  ('Mermelada de Melocotón',
   'Mermelada casera de melocotón, perfecta para untar en pan o galletas.',
   120, 1, 2, 28, 0, 10, 3),
  ('Melocotones Asados con Miel',
   'Melocotones asados con miel y un toque de canela.',
   150, 2, 3, 35, 3, 10, 3),
  ('Ensalada de Melocotón y Pollo',
   'Ensalada de pollo con melocotones, espinacas y aderezo de balsámico.',
   250, 25, 4, 20, 12, 10, 3),
  ('Helado de Melocotón',
   'Helado cremoso de melocotón con leche de coco.',
   200, 3, 3, 40, 8, 10, 3),
  ('Compota de Melocotón',
   'Compota de melocotón casera, perfecta como postre o acompañante.',
   100, 1, 3, 25, 0, 10, 3),
  ('Melocotón a la Parrilla',
   'Melocotones a la parrilla con un toque de azúcar moreno y canela.',
   130, 1, 3, 30, 2, 10, 3),
  ('Smoothie de Melocotón y Yogur',
   'Smoothie refrescante de melocotón y yogur natural.',
   140, 5, 3, 28, 2, 10, 3),

  -- GRANADA
  ('Ensalada de Granada y Queso Feta',
   'Ensalada fresca con granada, queso feta, espinacas y nueces.',
   150, 5, 4, 30, 6, 10, 3),
  ('Batido de Granada y Plátano',
   'Batido refrescante con granada, plátano y yogur natural.',
   180, 4, 3, 40, 2, 10, 3),
  ('Mermelada de Granada',
   'Mermelada casera de granada, perfecta para untar en pan o galletas.',
   120, 1, 2, 30, 0, 10, 3),
  ('Salsa de Granada',
   'Salsa agridulce de granada, ideal para acompañar carnes a la parrilla.',
   100, 1, 1, 25, 0, 10, 3),
  ('Ensalada de Pollo y Granada',
   'Ensalada ligera con pollo, granada, lechuga y aderezo de mostaza.',
   200, 30, 4, 25, 6, 10, 3),
  ('Jugo de Granada y Naranja',
   'Jugo refrescante de granada y naranja, perfecto para el desayuno.',
   140, 2, 3, 35, 1, 10, 3),
  ('Yogur con Granada y Miel',
   'Yogur natural con granada y miel, ideal para un snack saludable.',
   160, 6, 4, 30, 4, 10, 3),
  ('Tarta de Granada y Crema Pastelera',
   'Tarta dulce de granada con una capa de crema pastelera.',
   250, 5, 3, 45, 8, 10, 3),
  ('Granada con Queso de Cabra',
   'Granada acompañada de queso de cabra y un toque de miel.',
   180, 8, 4, 30, 7, 10, 3),
  ('Granizado de Granada',
   'Granizado refrescante de granada para los días calurosos.',
   120, 1, 2, 30, 0, 10, 3),

  -- HIGO
  ('Ensalada de Higos y Queso de Cabra',
   'Ensalada fresca con higos, queso de cabra, nueces y miel.',
   180, 6, 4, 35, 7, 10, 3),
  ('Batido de Higos y Yogur',
   'Batido cremoso de higos con yogur natural y un toque de miel.',
   150, 5, 3, 35, 3, 10, 3),
  ('Mermelada de Higos Casera',
   'Mermelada dulce de higos, perfecta para untar en pan o tostadas.',
   120, 1, 3, 30, 0, 10, 3),
  ('Higos a la Parrilla con Miel',
   'Higos asados a la parrilla con un toque de miel y almendras.',
   180, 4, 5, 40, 6, 10, 3),
  ('Tarta de Higos y Almendras',
   'Tarta de higos con una base de almendras, ideal para postres.',
   250, 6, 4, 45, 12, 10, 3),
  ('Higos Rellenos de Queso Crema',
   'Higos rellenos de queso crema, ideales para una entrada o snack.',
   160, 5, 3, 30, 8, 10, 3),
  ('Ensalada de Higos y Jamón Ibérico',
   'Ensalada con higos, jamón ibérico, rúcula y vinagreta de balsámico.',
   200, 12, 5, 25, 10, 10, 3),
  ('Higos con Chocolate Amargo',
   'Higos frescos cubiertos con chocolate amargo derretido, un postre delicioso.',
   220, 3, 5, 45, 10, 10, 3),
  ('Higos en Compota',
   'Higos cocidos en su propio jugo con azúcar y especias, ideales para acompañar platos.',
   160, 2, 4, 38, 0, 10, 3),
  ('Ensalada de Higos y Aguacate',
   'Ensalada ligera con higos, aguacate, espinacas y aderezo de limón.',
   220, 4, 6, 35, 12, 10, 3),

  -- UVA
  ('Ensalada de Uvas y Queso Azul',
   'Ensalada fresca con uvas, queso azul, nueces y aderezo balsámico.',
   180, 5, 3, 35, 7, 10, 3),
  ('Batido de Uva y Plátano',
   'Batido saludable con uvas, plátano y leche de almendras.',
   150, 3, 2, 35, 2, 10, 3),
  ('Mermelada de Uva Casera',
   'Mermelada de uvas para untar en pan o acompañar postres.',
   120, 1, 2, 30, 0, 10, 3),
  ('Uvas a la Parrilla con Miel',
   'Uvas asadas a la parrilla con un toque de miel y almendras.',
   180, 2, 4, 40, 6, 10, 3),
  ('Tarta de Uvas y Almendras',
   'Tarta con base de almendras y uvas frescas, ideal para postres.',
   250, 5, 3, 45, 12, 10, 3),
  ('Ensalada de Uvas y Pollo',
   'Ensalada con uvas, pollo a la parrilla, espinacas y vinagreta.',
   220, 20, 5, 30, 8, 10, 3),
  ('Uvas con Queso de Cabra',
   'Uvas acompañadas de queso de cabra y nueces, ideal para una merienda ligera.',
   160, 6, 3, 30, 8, 10, 3),
  ('Uvas en Salsa de Vino Tinto',
   'Uvas cocidas con vino tinto y especias, ideal como acompañamiento de carnes.',
   190, 1, 3, 40, 5, 10, 3),
  ('Brochetas de Uvas y Queso',
   'Brochetas con uvas y trozos de queso manchego, ideales para un aperitivo.',
   200, 8, 4, 25, 12, 10, 3),
  ('Uvas con Yogur Griego',
   'Uvas frescas acompañadas de yogur griego y miel.',
   160, 6, 3, 30, 4, 10, 3),

  -- PERA
  ('Ensalada de Pera y Nuez',
   'Ensalada fresca con peras, nueces, queso azul y aderezo de miel.',
   180, 5, 4, 30, 8, 10, 3),
  ('Pera al Vino Tinto',
   'Peras cocidas en vino tinto con especias, ideal para postres.',
   220, 1, 4, 45, 6, 10, 3),
  ('Batido de Pera y Plátano',
   'Batido saludable con peras, plátano y leche de almendras.',
   150, 3, 3, 35, 2, 10, 3),
  ('Tarta de Pera y Almendra',
   'Tarta casera con peras y una base de almendra.',
   250, 5, 5, 40, 12, 10, 3),
  ('Ensalada de Pera y Pollo',
   'Ensalada con peras, pollo a la parrilla, espinacas y vinagreta.',
   220, 20, 6, 30, 8, 10, 3),
  ('Pera Asada con Canela',
   'Peras asadas con un toque de canela, perfectas para el postre.',
   180, 1, 5, 45, 3, 10, 3),
  ('Pera con Queso Cottage',
   'Peras frescas acompañadas de queso cottage y nueces.',
   160, 10, 5, 30, 4, 10, 3),
  ('Pera al Horno con Miel y Almendras',
   'Peras al horno con miel, almendras y un toque de limón.',
   220, 4, 5, 50, 6, 10, 3),
  ('Ensalada de Pera y Remolacha',
   'Ensalada con peras, remolacha, queso de cabra y nueces.',
   200, 5, 6, 30, 8, 10, 3),
  ('Compota de Pera Casera',
   'Compota de peras cocidas con un toque de canela y limón.',
   150, 1, 4, 35, 1, 10, 3),

  -- MELÓN
  ('Ensalada de Melón y Jamón',
   'Ensalada refrescante de melón y jamón serrano con rúcula.',
   120, 8, 2, 10, 5, 10, 3),
  ('Smoothie de Melón y Menta',
   'Batido de melón fresco con hojas de menta y un toque de limón.',
    90, 1, 2, 20, 0, 10, 3),
  ('Melón a la Parrilla con Miel',
   'Rodajas de melón a la parrilla con miel y un toque de canela.',
   110, 1, 1, 25, 0, 10, 3),
  ('Gazpacho de Melón',
   'Gazpacho refrescante hecho de melón, pepino y hierbabuena.',
    80, 1, 2, 15, 1, 10, 3),
  ('Melón con Yogur y Miel',
   'Cubos de melón servidos con yogur natural y un toque de miel.',
   130, 6, 2, 22, 3, 10, 3),
  ('Ensalada de Melón y Pepino',
   'Ensalada fresca de melón y pepino con aderezo de limón.',
    70, 1, 1, 12, 1, 10, 3),
  ('Brochetas de Melón y Mozzarella',
   'Brochetas de melón, mozzarella fresca y albahaca.',
   100, 5, 1, 10, 5, 10, 3),
  ('Melón con Salsa de Yogur',
   'Melón en cubos servido con salsa de yogur y menta fresca.',
    90, 4, 1, 15, 1, 10, 3),
  ('Ensalada de Melón y Frutos Rojos',
   'Melón mezclado con frutos rojos frescos y un toque de menta.',
    80, 1, 3, 18, 0, 10, 3),
  ('Helado de Melón Casero',
   'Helado casero a base de melón y yogur natural.',
   100, 4, 1, 20, 2, 10, 3),

  -- NECTARINA
  ('Ensalada de Nectarinas y Rúcula',
   'Ensalada fresca de nectarinas, rúcula, queso feta y nueces.',
   130, 4, 3, 15, 7, 10, 3),
  ('Smoothie de Nectarina y Yogur',
   'Batido cremoso de nectarina, yogur griego y un toque de miel.',
   120, 5, 2, 20, 2, 10, 3),
  ('Nectarinas a la Parrilla con Miel',
   'Nectarinas asadas a la parrilla con miel y un toque de canela.',
   100, 1, 2, 22, 0, 10, 3),
  ('Ensalada de Nectarina y Pollo',
   'Ensalada ligera de pollo a la plancha, nectarinas y espinacas.',
   200, 18, 3, 10, 8, 10, 3),
  ('Nectarinas con Queso Cottage',
   'Nectarinas frescas con queso cottage y un toque de canela.',
    90, 6, 2, 15, 1, 10, 3),
  ('Nectarinas en Salsa de Yogur',
   'Nectarinas en rodajas con una salsa ligera de yogur y menta.',
    80, 4, 2, 14, 1, 10, 3),
  ('Nectarinas con Avena y Miel',
   'Avena cocida servida con nectarinas frescas y un toque de miel.',
   160, 5, 4, 30, 2, 10, 3),
  ('Ensalada de Nectarinas y Quinoa',
   'Ensalada saludable de quinoa, nectarinas y verduras frescas.',
   150, 6, 3, 25, 3, 10, 3),
  ('Nectarinas con Ricotta y Almendras',
   'Nectarinas en rodajas servidas con ricotta y almendras troceadas.',
   110, 5, 2, 12, 5, 10, 3),
  ('Tostadas con Nectarina y Mantequilla de Almendra',
   'Tostadas integrales con rodajas de nectarina y mantequilla de almendra.',
   180, 7, 4, 20, 8, 10, 3),

  -- PARAGUAYO
  ('Ensalada de Paraguayos y Frambuesas',
   'Ensalada fresca de paraguayos, frambuesas y queso de cabra.',
   140, 3, 4, 25, 6, 10, 3),
  ('Smoothie de Paraguayo y Plátano',
   'Batido cremoso de paraguayo, plátano y leche de almendras.',
   180, 4, 3, 35, 2, 10, 3),
  ('Paraguayos a la Parrilla con Miel y Limón',
   'Paraguayos asados a la parrilla con miel, limón y un toque de canela.',
   130, 1, 2, 30, 0, 10, 3),
  ('Ensalada de Paraguayos y Pollo',
   'Ensalada ligera de pollo a la plancha, paraguayos, rúcula y nueces.',
   200, 18, 3, 18, 9, 10, 3),
  ('Paraguayos con Yogur Griego',
   'Paraguayos frescos acompañados con yogur griego y almendras.',
   150, 6, 3, 22, 7, 10, 3),
  ('Tostadas con Paraguayos y Queso Ricotta',
   'Tostadas integrales con paraguayos y un toque de queso ricotta.',
   180, 6, 4, 28, 8, 10, 3),
  ('Paraguayos con Mantequilla de Almendra y Canela',
   'Paraguayos en rodajas con mantequilla de almendra y canela.',
   140, 4, 3, 20, 8, 10, 3),
  ('Parfait de Paraguayos y Avena',
   'Parfait con capas de paraguayos, avena y miel.',
   160, 5, 5, 30, 3, 10, 3),
  ('Paraguayos en Salsa de Menta',
   'Paraguayos en rodajas con una salsa ligera de menta y limón.',
   110, 2, 2, 27, 0, 10, 3),
  ('Ensalada de Paraguayos y Tomates Cherry',
   'Ensalada fresca de paraguayos, tomates cherry y cebolla morada.',
   120, 3, 3, 26, 1, 10, 3),

  -- FRAMBUESA
  ('Batido de Frambuesas y Plátano',
   'Un batido cremoso de frambuesas frescas y plátano, ideal para el desayuno.',
   160, 3, 4, 35, 2, 10, 3),
  ('Ensalada de Frambuesas y Queso de Cabra',
   'Ensalada fresca de frambuesas, queso de cabra, espinacas y nueces.',
   200, 7, 5, 20, 12, 10, 3),
  ('Mousse de Frambuesa y Yogur',
   'Mousse ligera de frambuesas y yogur natural, perfecta para un postre saludable.',
   130, 6, 3, 18, 4, 10, 3),
  ('Tarta de Frambuesa sin Azúcar',
   'Tarta casera de frambuesas endulzada con stevia, perfecta para una merienda saludable.',
   180, 5, 6, 30, 6, 10, 3),
  ('Smoothie Bowl de Frambuesas',
   'Bowl de smoothie con frambuesas, plátano, espinacas y granola.',
   220, 7, 5, 45, 6, 10, 3),
  ('Yogur Griego con Frambuesas y Almendras',
   'Yogur griego acompañado de frambuesas frescas y almendras.',
   150, 8, 4, 20, 7, 10, 3),
  ('Galletas de Avena y Frambuesas',
   'Galletas caseras de avena y frambuesas, una opción saludable para el snack.',
   180, 4, 5, 30, 6, 10, 3),
  ('Ensalada de Frambuesas, Aguacate y Pollo',
   'Ensalada fresca con frambuesas, aguacate, pollo a la plancha y hojas verdes.',
   250, 20, 8, 18, 15, 10, 3),
  ('Tostadas Integrales con Frambuesas y Mantequilla de Almendra',
   'Tostadas integrales con frambuesas y un toque de mantequilla de almendra.',
   200, 6, 7, 30, 8, 10, 3),
  ('Sorbete de Frambuesas y Limón',
   'Sorbete casero refrescante de frambuesas y limón, ideal para el calor.',
   100, 2, 5, 25, 0, 10, 3),

  -- AGUACATE
  ('Guacamole Tradicional',
   'Guacamole fresco con aguacate, cebolla, cilantro, limón y chile, ideal para acompañar nachos.',
   220, 3, 6, 12, 18, 10, 3),
  ('Ensalada de Aguacate y Tomate',
   'Ensalada fresca de aguacate, tomate, cebolla morada y aderezo de aceite de oliva.',
   180, 3, 7, 15, 14, 10, 3),
  ('Tostadas de Aguacate y Huevo',
   'Tostadas integrales con aguacate triturado y huevo pochado.',
   300, 12, 8, 25, 18, 10, 3),
  ('Batido de Aguacate y Espinacas',
   'Batido verde y cremoso de aguacate, espinacas, plátano y leche de almendra.',
   250, 4, 10, 28, 15, 10, 3),
  ('Ensalada de Pollo con Aguacate',
   'Ensalada de pechuga de pollo a la parrilla, aguacate, lechuga y tomate, con aderezo de aceite de oliva.',
   350, 30, 7, 12, 24, 10, 3),
  ('Sushi de Aguacate y Pepino',
   'Sushi vegano con aguacate, pepino y arroz de sushi, envuelto en alga nori.',
   200, 4, 6, 40, 6, 10, 3),
  ('Crema de Aguacate y Yogur',
   'Crema suave de aguacate, yogur natural y un toque de miel, ideal como postre.',
   220, 5, 8, 18, 15, 10, 3),
  ('Sándwich de Aguacate y Pavo',
   'Sándwich saludable de aguacate, pechuga de pavo, lechuga y pan integral.',
   280, 20, 8, 30, 14, 10, 3),
  ('Tartar de Atún y Aguacate',
   'Tartar fresco de atún con aguacate, cebollas rojas y limón.',
   300, 25, 6, 12, 18, 10, 3),
  ('Pizza de Aguacate y Pollo',
   'Pizza ligera de aguacate, pollo a la parrilla, tomate, albahaca y queso bajo en grasa.',
   350, 30, 8, 30, 20, 10, 3),

-- QUESOS

-- PECORINO DELLA MAREMMA

-- (1) Pasta Cacio e Pepe con Pecorino della Maremma
('Pasta Cacio e Pepe con Pecorino della Maremma',
 'Clásica pasta italiana con Pecorino della Maremma, pimienta negra recién molida y un toque de aceite de oliva.',
 550, 22, 4, 60, 25,
 11, 3),

-- (2) Ensalada de Tomate, Albahaca y Pecorino della Maremma
('Ensalada de Tomate, Albahaca y Pecorino della Maremma',
 'Tomates frescos, albahaca, rodajas de Pecorino della Maremma y un toque de vinagre balsámico y aceite de oliva.',
 350, 15, 4, 10, 28,
 11, 3),

-- (3) Pizza con Pecorino della Maremma y Higos
('Pizza con Pecorino della Maremma y Higos',
 'Pizza de masa fina con rodajas de higos, Pecorino della Maremma y un toque de miel y rúcula fresca.',
 700, 25, 5, 70, 35,
 11, 3),

-- (4) Risotto con Pecorino della Maremma y Setas
('Risotto con Pecorino della Maremma y Setas',
 'Cremoso risotto con Pecorino della Maremma, setas salteadas y un toque de vino blanco.',
 600, 20, 4, 60, 30,
 11, 3),

-- (5) Tarta de Pecorino della Maremma y Espárragos
('Tarta de Pecorino della Maremma y Espárragos',
 'Tarta salada con masa quebrada, espárragos frescos y una capa de Pecorino della Maremma.',
 500, 18, 6, 40, 30,
 11, 3),

-- (6) Croquetas de Pecorino della Maremma
('Croquetas de Pecorino della Maremma',
 'Croquetas crujientes rellenas de una mezcla de Pecorino della Maremma, patata y cebolla caramelizada.',
 400, 15, 5, 40, 20,
 11, 3),

-- (7) Sopa de Lentejas con Pecorino della Maremma
('Sopa de Lentejas con Pecorino della Maremma',
 'Sopa de lentejas con un toque de Pecorino della Maremma rallado y un chorrito de aceite de oliva.',
 350, 18, 15, 40, 10,
 11, 3),

-- (8) Ensalada de Pera, Nuez y Pecorino della Maremma
('Ensalada de Pera, Nuez y Pecorino della Maremma',
 'Ensalada fresca de pera, nuez y rodajas de Pecorino della Maremma, aderezada con miel y vinagre balsámico.',
 400, 12, 5, 30, 25,
 11, 3),

-- (9) Pollo al Horno con Pecorino della Maremma
('Pollo al Horno con Pecorino della Maremma',
 'Pechugas de pollo al horno cubiertas con una capa de Pecorino della Maremma rallado y hierbas aromáticas.',
 450, 35, 4, 6, 28,
 11, 3),

-- (10) Panini con Pecorino della Maremma y Prosciutto
('Panini con Pecorino della Maremma y Prosciutto',
 'Panini relleno de Pecorino della Maremma, prosciutto crudo y rúcula fresca.',
 550, 30, 4, 45, 25,
 11, 3),


-- MOZZARELLA DI BUFALA

-- (1) Ensalada Caprese con Mozzarella di Bufala
('Ensalada Caprese con Mozzarella di Bufala',
 'Tomates frescos, albahaca y rodajas de Mozzarella di Bufala, rociados con aceite de oliva virgen extra y vinagre balsámico.',
 350, 16, 4, 15, 28,
 11, 3),

-- (2) Pizza Margherita con Mozzarella di Bufala
('Pizza Margherita con Mozzarella di Bufala',
 'Pizza con tomate, albahaca fresca y generosas cantidades de Mozzarella di Bufala, horneada a la perfección.',
 600, 30, 4, 50, 28,
 11, 3),

-- (3) Pasta con Mozzarella di Bufala y Tomates Secos
('Pasta con Mozzarella di Bufala y Tomates Secos',
 'Pasta fresca con tomates secos, albahaca y trozos de Mozzarella di Bufala, salteados con aceite de oliva.',
 500, 20, 6, 60, 22,
 11, 3),

-- (4) Bruschetta con Mozzarella di Bufala
('Bruschetta con Mozzarella di Bufala',
 'Pan tostado cubierto con tomate, albahaca y trozos de Mozzarella di Bufala, aderezado con aceite de oliva.',
 220, 9, 3, 25, 12,
 11, 3),

-- (5) Pollo Relleno de Mozzarella di Bufala y Pesto
('Pollo Relleno de Mozzarella di Bufala y Pesto',
 'Pechugas de pollo rellenas de Mozzarella di Bufala y pesto, luego horneadas hasta quedar doradas.',
 450, 35, 3, 10, 30,
 11, 3),

-- (6) Ensalada de Mozzarella di Bufala con Pera y Nueces
('Ensalada de Mozzarella di Bufala con Pera y Nueces',
 'Ensalada fresca con rodajas de Mozzarella di Bufala, pera, nueces y un toque de miel y vinagre balsámico.',
 400, 12, 5, 30, 25,
 11, 3),

-- (7) Tortilla de Mozzarella di Bufala y Espinacas
('Tortilla de Mozzarella di Bufala y Espinacas',
 'Tortilla esponjosa con espinacas frescas y trozos de Mozzarella di Bufala, ideal para desayuno o cena ligera.',
 350, 18, 4, 6, 30,
 11, 3),

-- (8) Lasagna con Mozzarella di Bufala y Berenjenas
('Lasagna con Mozzarella di Bufala y Berenjenas',
 'Lasaña con capas de berenjenas a la parrilla, salsa de tomate casera y Mozzarella di Bufala.',
 650, 30, 8, 55, 35,
 11, 3),

-- (9) Sopa Fría de Tomate y Mozzarella di Bufala
('Sopa Fría de Tomate y Mozzarella di Bufala',
 'Sopa fría de tomate con trozos de Mozzarella di Bufala y un toque de albahaca fresca.',
 250, 9, 4, 18, 18,
 11, 3),

-- (10) Panini con Mozzarella di Bufala y Prosciutto
('Panini con Mozzarella di Bufala y Prosciutto',
 'Panini relleno de Mozzarella di Bufala, prosciutto y un toque de rúcula.',
 500, 30, 4, 45, 25,
 11, 3),


-- PARMIGIANO REGGIANO

-- (1) Risotto de Parmigiano Reggiano
('Risotto de Parmigiano Reggiano',
 'Un risotto cremoso con un toque de Parmigiano Reggiano, que le da un sabor profundo y delicioso.',
 450, 14, 3, 50, 20,
 11, 3),

-- (2) Ensalada Caprese con Parmigiano Reggiano
('Ensalada Caprese con Parmigiano Reggiano',
 'Ensalada fresca de tomate, albahaca y mozzarella, con lascas de Parmigiano Reggiano y un toque de aceite de oliva.',
 300, 12, 4, 15, 22,
 11, 3),

-- (3) Lasagna al Parmigiano Reggiano
('Lasagna al Parmigiano Reggiano',
 'Una lasaña tradicional italiana con capas de pasta, carne, bechamel y una generosa capa de Parmigiano Reggiano rallado.',
 600, 30, 4, 45, 35,
 11, 3),

-- (4) Pollo al Parmigiano
('Pollo al Parmigiano',
 'Pechugas de pollo empanadas y horneadas con una capa crujiente de Parmigiano Reggiano y hierbas.',
 400, 30, 2, 20, 25,
 11, 3),

-- (5) Sopa de Tomate con Parmigiano Reggiano
('Sopa de Tomate con Parmigiano Reggiano',
 'Sopa de tomate rica y sabrosa, servida con una capa de Parmigiano Reggiano rallado por encima.',
 250, 8, 5, 30, 10,
 11, 3),

-- (6) Espaguetis con Parmigiano Reggiano y Ajo
('Espaguetis con Parmigiano Reggiano y Ajo',
 'Espaguetis salteados con ajo, aceite de oliva y una gran cantidad de Parmigiano Reggiano rallado.',
 500, 18, 3, 60, 25,
 11, 3),

-- (7) Tarta Salada de Parmigiano Reggiano
('Tarta Salada de Parmigiano Reggiano',
 'Tarta salada con una base de hojaldre rellena de una mezcla cremosa de Parmigiano Reggiano y espinacas.',
 350, 14, 6, 30, 22,
 11, 3),

-- (8) Croquetas de Parmigiano Reggiano
('Croquetas de Parmigiano Reggiano',
 'Croquetas crujientes rellenas de una mezcla de bechamel y Parmigiano Reggiano, perfectas como aperitivo.',
 250, 8, 2, 20, 18,
 11, 3),

-- (9) Bruschetta de Parmigiano Reggiano y Tomate
('Bruschetta de Parmigiano Reggiano y Tomate',
 'Rebanadas de pan tostado cubiertas con tomate fresco, albahaca y lascas de Parmigiano Reggiano.',
 220, 6, 4, 25, 12,
 11, 3),

-- (10) Risotto de Champiñones y Parmigiano Reggiano
('Risotto de Champiñones y Parmigiano Reggiano',
 'Un risotto cremoso con champiñones salteados y Parmigiano Reggiano, ideal como plato principal o acompañamiento.',
 480, 14, 5, 55, 22,
 11, 3),


-- QUESO GORGONZOLA

-- (1) Pasta al Gorgonzola
('Pasta al Gorgonzola',
 'Pasta cremosamente cubierta con una salsa de queso Gorgonzola, ideal para una comida reconfortante.',
 500, 18, 3, 55, 25,
 11, 3),

-- (2) Ensalada de Pera, Nueces y Queso Gorgonzola
('Ensalada de Pera, Nueces y Queso Gorgonzola',
 'Ensalada fresca con pera, nueces, y trozos de queso Gorgonzola, aderezada con vinagreta balsámica.',
 300, 12, 5, 28, 20,
 11, 3),

-- (3) Pizza de Gorgonzola y Pera
('Pizza de Gorgonzola y Pera',
 'Pizza gourmet con una base crujiente, peras caramelizadas y queso Gorgonzola fundido.',
 450, 20, 4, 40, 22,
 11, 3),

-- (4) Sopa de Calabaza con Queso Gorgonzola
('Sopa de Calabaza con Queso Gorgonzola',
 'Sopa de calabaza suave con un toque de queso Gorgonzola, que le da cremosidad y un sabor único.',
 220, 7, 5, 30, 12,
 11, 3),

-- (5) Tarta de Gorgonzola y Espinacas
('Tarta de Gorgonzola y Espinacas',
 'Tarta salada con base de hojaldre, espinacas y queso Gorgonzola fundido.',
 380, 15, 6, 32, 24,
 11, 3),

-- (6) Rissotto de Gorgonzola y Champiñones
('Rissotto de Gorgonzola y Champiñones',
 'Un risotto cremoso con queso Gorgonzola y champiñones salteados, ideal para un plato principal delicioso.',
 500, 14, 4, 55, 25,
 11, 3),

-- (7) Brochetas de Pollo con Gorgonzola
('Brochetas de Pollo con Gorgonzola',
 'Brochetas de pollo acompañadas de una salsa cremosa de queso Gorgonzola.',
 350, 25, 3, 12, 20,
 11, 3),

-- (8) Hamburguesas de Ternera con Gorgonzola
('Hamburguesas de Ternera con Gorgonzola',
 'Hamburguesas jugosas de ternera con una rebanada de queso Gorgonzola derretido en la parte superior.',
 550, 30, 3, 30, 30,
 11, 3),

-- (9) Queso Gorgonzola con Miel y Nueces
('Queso Gorgonzola con Miel y Nueces',
 'Un aperitivo sencillo y delicioso: queso Gorgonzola acompañado de miel y nueces.',
 280, 12, 2, 22, 18,
 11, 3),

-- (10) Piquillos Rellenos de Gorgonzola
('Piquillos Rellenos de Gorgonzola',
 'Pimientos del piquillo rellenos con una mezcla cremosa de queso Gorgonzola, ideales como entrante.',
 200, 10, 3, 18, 12,
 11, 3),


-- QUESO DE TETILLA

-- (1) Croquetas de Queso de Tetilla
('Croquetas de Queso de Tetilla',
 'Croquetas cremosas rellenas de queso de Tetilla, perfectas como aperitivo o tapa.',
 250, 8, 1, 18, 18,
 11, 3),

-- (2) Ensalada de Queso de Tetilla y Pera
('Ensalada de Queso de Tetilla y Pera',
 'Ensalada fresca con trozos de queso de Tetilla, pera y nueces, aderezada con una vinagreta suave.',
 320, 12, 5, 30, 20,
 11, 3),

-- (3) Pizza de Queso de Tetilla y Jamón Serrano
('Pizza de Queso de Tetilla y Jamón Serrano',
 'Pizza con base crujiente, jamón serrano y una capa generosa de queso de Tetilla fundido.',
 400, 18, 3, 40, 25,
 11, 3),

-- (4) Sopa de Puerros con Queso de Tetilla
('Sopa de Puerros con Queso de Tetilla',
 'Sopa suave de puerro con trozos de queso de Tetilla fundido, ideal para días fríos.',
 180, 8, 4, 15, 12,
 11, 3),

-- (5) Tarta Salada de Queso de Tetilla y Espinacas
('Tarta Salada de Queso de Tetilla y Espinacas',
 'Tarta salada con base de hojaldre, espinacas y queso de Tetilla fundido.',
 350, 15, 7, 30, 22,
 11, 3),

-- (6) Brochetas de Queso de Tetilla y Tomate Seco
('Brochetas de Queso de Tetilla y Tomate Seco',
 'Brochetas con trozos de queso de Tetilla y tomate seco, acompañadas de una reducción de balsámico.',
 220, 10, 2, 18, 14,
 11, 3),

-- (7) Tortilla de Patatas con Queso de Tetilla
('Tortilla de Patatas con Queso de Tetilla',
 'La clásica tortilla de patatas con un toque de queso de Tetilla, que le aporta cremosidad.',
 350, 14, 3, 30, 22,
 11, 3),

-- (8) Empanada Gallega de Queso de Tetilla y Carne
('Empanada Gallega de Queso de Tetilla y Carne',
 'Empanada rellena con carne y queso de Tetilla, típica de Galicia.',
 450, 20, 4, 40, 25,
 11, 3),

-- (9) Queso de Tetilla con Miel y Almendras
('Queso de Tetilla con Miel y Almendras',
 'Queso de Tetilla servido con un toque de miel y almendras, ideal como postre o aperitivo.',
 280, 12, 3, 20, 18,
 11, 3),

-- (10) Macarrones con Queso de Tetilla y Champiñones
('Macarrones con Queso de Tetilla y Champiñones',
 'Pasta con queso de Tetilla y champiñones salteados, una combinación cremosa y sabrosa.',
 400, 18, 4, 40, 20,
 11, 3),


-- QUESO DE RADIQUERO

-- (1) Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras
('Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras',
 'Ensalada fresca con queso de Radiquero, tomates secos y almendras, acompañada de vinagreta de aceite de oliva.',
 280, 14, 3, 14, 22,
 11, 3),

-- (2) Pasta Fresca con Queso de Radiquero y Espárragos
('Pasta Fresca con Queso de Radiquero y Espárragos',
 'Pasta fresca servida con espárragos y queso de Radiquero rallado, ideal como plato principal ligero.',
 350, 16, 5, 45, 14,
 11, 3),

-- (3) Tarta Salada de Queso de Radiquero y Pimientos Asados
('Tarta Salada de Queso de Radiquero y Pimientos Asados',
 'Tarta salada con base de hojaldre, pimientos asados y queso de Radiquero fundido.',
 400, 15, 7, 35, 25,
 11, 3),

-- (4) Queso de Radiquero al Horno con Miel y Nueces
('Queso de Radiquero al Horno con Miel y Nueces',
 'Queso de Radiquero horneado con miel y nueces, un aperitivo perfecto.',
 310, 12, 4, 20, 22,
 11, 3),

-- (5) Croquetas de Queso de Radiquero y Jamón Serrano
('Croquetas de Queso de Radiquero y Jamón Serrano',
 'Croquetas crujientes rellenas de una mezcla de queso de Radiquero y jamón serrano.',
 220, 10, 2, 25, 12,
 11, 3),

-- (6) Brochetas de Queso de Radiquero y Uvas
('Brochetas de Queso de Radiquero y Uvas',
 'Brochetas sencillas con cubos de queso de Radiquero y uvas, perfectas como tapa.',
 180, 8, 2, 15, 10,
 11, 3),

-- (7) Pizza de Queso de Radiquero con Champiñones
('Pizza de Queso de Radiquero con Champiñones',
 'Pizza de masa fina con queso de Radiquero, champiñones salteados y aceite de oliva.',
 400, 18, 4, 40, 20,
 11, 3),

-- (8) Sopa de Ajo con Queso de Radiquero Fundido
('Sopa de Ajo con Queso de Radiquero Fundido',
 'Sopa de ajo tradicional con un toque de queso de Radiquero fundido en la parte superior.',
 220, 10, 3, 25, 10,
 11, 3),

-- (9) Tortilla Española con Queso de Radiquero
('Tortilla Española con Queso de Radiquero',
 'Tortilla española clásica con un toque cremoso de queso de Radiquero.',
 350, 16, 3, 25, 22,
 11, 3),

-- (10) Queso de Radiquero con Aceite de Oliva y Romero
('Queso de Radiquero con Aceite de Oliva y Romero',
 'Un plato sencillo pero sabroso de queso de Radiquero servido con aceite de oliva y romero.',
 250, 14, 2, 5, 20,
 11, 3),


-- QUESO IDIAZÁBAL

-- (1) Tarta de Queso Idiazábal y Pimientos
('Tarta de Queso Idiazábal y Pimientos',
 'Tarta salada con queso Idiazábal y pimientos asados, ideal para una comida ligera.',
 400, 18, 5, 30, 28,
 11, 3),

-- (2) Ensalada de Queso Idiazábal y Tomate
('Ensalada de Queso Idiazábal y Tomate',
 'Ensalada fresca con tomate, queso Idiazábal y aceite de oliva.',
 320, 15, 6, 20, 22,
 11, 3),

-- (3) Croquetas de Queso Idiazábal
('Croquetas de Queso Idiazábal',
 'Croquetas crujientes rellenas de queso Idiazábal, ideales como aperitivo.',
 250, 10, 3, 22, 18,
 11, 3),

-- (4) Pizza de Queso Idiazábal y Jamón Serrano
('Pizza de Queso Idiazábal y Jamón Serrano',
 'Pizza con queso Idiazábal, jamón serrano y un toque de aceite de oliva.',
 450, 20, 4, 40, 28,
 11, 3),

-- (5) Revuelto de Queso Idiazábal y Setas
('Revuelto de Queso Idiazábal y Setas',
 'Revuelto de huevos con queso Idiazábal y setas, ideal para un desayuno o cena ligera.',
 350, 20, 3, 15, 24,
 11, 3),

-- (6) Brochetas de Queso Idiazábal y Verduras
('Brochetas de Queso Idiazábal y Verduras',
 'Brochetas de queso Idiazábal y verduras asadas, ideales para una comida saludable.',
 300, 12, 5, 18, 20,
 11, 3),

-- (7) Ensalada de Queso Idiazábal y Peras
('Ensalada de Queso Idiazábal y Peras',
 'Ensalada con queso Idiazábal y peras caramelizadas, ideal para acompañar carnes.',
 350, 14, 5, 30, 22,
 11, 3),

-- (8) Sopa de Queso Idiazábal y Calabaza
('Sopa de Queso Idiazábal y Calabaza',
 'Sopa cremosa de calabaza con queso Idiazábal, ideal para el otoño.',
 280, 10, 4, 25, 18,
 11, 3),

-- (9) Frittata de Queso Idiazábal y Espinacas
('Frittata de Queso Idiazábal y Espinacas',
 'Frittata con espinacas, queso Idiazábal y cebolla, perfecta para una comida ligera.',
 320, 18, 5, 12, 22,
 11, 3),

-- (10) Queso Idiazábal al Horno con Miel
('Queso Idiazábal al Horno con Miel',
 'Queso Idiazábal al horno con miel, ideal como aperitivo o acompañamiento.',
 380, 15, 2, 15, 30,
 11, 3),


-- QUESO MANCHEGO

-- (1) Ensalada de Queso Manchego y Jamón Serrano
('Ensalada de Queso Manchego y Jamón Serrano',
 'Ensalada fresca con queso manchego y jamón serrano, ideal para un almuerzo ligero.',
 350, 18, 4, 15, 25,
 11, 3),

-- (2) Tarta de Queso Manchego y Espárragos
('Tarta de Queso Manchego y Espárragos',
 'Tarta salada con queso manchego, espárragos y cebolla caramelizada.',
 420, 20, 5, 35, 30,
 11, 3),

-- (3) Croquetas de Queso Manchego y Trufa
('Croquetas de Queso Manchego y Trufa',
 'Croquetas crujientes rellenas de queso manchego y un toque de aceite de trufa.',
 250, 10, 3, 22, 18,
 11, 3),

-- (4) Pollo Relleno de Queso Manchego y Espinacas
('Pollo Relleno de Queso Manchego y Espinacas',
 'Pechuga de pollo rellena con queso manchego y espinacas, ideal para una comida saludable.',
 400, 35, 6, 5, 28,
 11, 3),

-- (5) Pizza de Queso Manchego y Setas
('Pizza de Queso Manchego y Setas',
 'Pizza con queso manchego y una mezcla de setas salteadas.',
 430, 15, 4, 40, 25,
 11, 3),

-- (6) Bruschetta con Queso Manchego y Pesto
('Bruschetta con Queso Manchego y Pesto',
 'Tostadas de pan con queso manchego y pesto, ideal como aperitivo.',
 280, 10, 4, 25, 18,
 11, 3),

-- (7) Pimientos Rellenos de Queso Manchego
('Pimientos Rellenos de Queso Manchego',
 'Pimientos rojos rellenos de queso manchego y cebolla caramelizada, ideales como plato principal.',
 320, 14, 6, 20, 24,
 11, 3),

-- (8) Ensalada de Queso Manchego y Peras
('Ensalada de Queso Manchego y Peras',
 'Ensalada fresca con queso manchego y peras caramelizadas.',
 300, 12, 5, 28, 18,
 11, 3),

-- (9) Tortilla de Queso Manchego y Cebolla Caramelizada
('Tortilla de Queso Manchego y Cebolla Caramelizada',
 'Tortilla de huevo con queso manchego y cebolla caramelizada, ideal para cualquier comida.',
 350, 20, 2, 12, 24,
 11, 3),

-- (10) Sopa de Queso Manchego y Calabaza
('Sopa de Queso Manchego y Calabaza',
 'Sopa cremosa de calabaza con queso manchego, ideal para el otoño.',
 250, 8, 4, 25, 15,
 11, 3),


-- QUESO DE CABRA

-- (1) Ensalada de Queso de Cabra y Frutos Secos
('Ensalada de Queso de Cabra y Frutos Secos',
 'Ensalada fresca con queso de cabra, frutos secos y una vinagreta balsámica.',
 280, 10, 4, 20, 22,
 11, 3),

-- (2) Tarta de Queso de Cabra y Tomates Secos
('Tarta de Queso de Cabra y Tomates Secos',
 'Tarta salada con queso de cabra y tomates secos, ideal para un almuerzo ligero.',
 350, 15, 3, 25, 24,
 11, 3),

-- (3) Croquetas de Queso de Cabra y Miel
('Croquetas de Queso de Cabra y Miel',
 'Croquetas crujientes rellenas de queso de cabra y un toque de miel.',
 200, 8, 2, 18, 14,
 11, 3),

-- (4) Pollo Relleno de Queso de Cabra y Espinacas
('Pollo Relleno de Queso de Cabra y Espinacas',
 'Pechuga de pollo rellena de queso de cabra y espinacas, ideal para una comida saludable.',
 400, 35, 5, 6, 30,
 11, 3),

-- (5) Pizza de Queso de Cabra, Pera y Rúcula
('Pizza de Queso de Cabra, Pera y Rúcula',
 'Pizza de base crujiente con queso de cabra, pera caramelizada y rúcula fresca.',
 420, 12, 4, 45, 22,
 11, 3),

-- (6) Bruschetta con Queso de Cabra y Miel
('Bruschetta con Queso de Cabra y Miel',
 'Tostadas con queso de cabra y un toque de miel, perfectas como aperitivo.',
 250, 8, 3, 22, 18,
 11, 3),

-- (7) Pimientos Rellenos de Queso de Cabra
('Pimientos Rellenos de Queso de Cabra',
 'Pimientos rojos rellenos de queso de cabra y cebolla caramelizada, ideales como plato principal.',
 300, 12, 6, 15, 22,
 11, 3),

-- (8) Ensalada de Queso de Cabra y Remolacha
('Ensalada de Queso de Cabra y Remolacha',
 'Ensalada de remolacha con queso de cabra, nueces y una vinagreta ligera.',
 280, 10, 5, 22, 18,
 11, 3),

-- (9) Tortilla de Queso de Cabra y Cebolla Caramelizada
('Tortilla de Queso de Cabra y Cebolla Caramelizada',
 'Tortilla de huevo con queso de cabra y cebolla caramelizada, perfecta para cualquier comida.',
 320, 15, 2, 10, 22,
 11, 3),

-- (10) Sopa de Queso de Cabra y Acelga
('Sopa de Queso de Cabra y Acelga',
 'Sopa cremosa de acelga con queso de cabra, suave y nutritiva.',
 220, 8, 4, 18, 15,
 11, 3),


-- QUESO CABRALES

-- (1) Tarta de Queso Cabrales y Nueces
('Tarta de Queso Cabrales y Nueces',
 'Tarta salada con queso Cabrales y nueces, ideal como entrante.',
 320, 15, 2, 25, 22,
 11, 3),

-- (2) Ensalada de Pera, Cabrales y Nueces
('Ensalada de Pera, Cabrales y Nueces',
 'Ensalada fresca con pera, queso Cabrales, nueces y un toque de vinagreta balsámica.',
 250, 10, 5, 20, 18,
 11, 3),

-- (3) Croquetas de Cabrales y Jamón
('Croquetas de Cabrales y Jamón',
 'Croquetas crujientes rellenas de queso Cabrales y jamón serrano.',
 180, 9, 1, 15, 12,
 11, 3),

-- (4) Pollo al Cabrales con Puré de Patatas
('Pollo al Cabrales con Puré de Patatas',
 'Pechuga de pollo a la plancha acompañada de una salsa cremosa de queso Cabrales y puré de patatas.',
 400, 35, 4, 30, 22,
 11, 3),

-- (5) Pasta con Cabrales y Espinacas
('Pasta con Cabrales y Espinacas',
 'Pasta integral con una salsa cremosa de queso Cabrales y espinacas salteadas.',
 350, 15, 6, 45, 15,
 11, 3),

-- (6) Sopa de Cabrales y Setas
('Sopa de Cabrales y Setas',
 'Sopa cremosa de queso Cabrales con setas salteadas.',
 280, 12, 3, 20, 20,
 11, 3),

-- (7) Empanadas de Cabrales y Piquillos
('Empanadas de Cabrales y Piquillos',
 'Empanadas rellenas de queso Cabrales y pimientos del piquillo, horneadas hasta dorarse.',
 240, 8, 2, 22, 15,
 11, 3),

-- (8) Brochetas de Ternera con Cabrales
('Brochetas de Ternera con Cabrales',
 'Brochetas de ternera a la parrilla acompañadas de salsa de queso Cabrales.',
 380, 32, 2, 5, 25,
 11, 3),

-- (9) Pizza de Cabrales, Pera y Jamón
('Pizza de Cabrales, Pera y Jamón',
 'Pizza de base crujiente con queso Cabrales, pera caramelizada y jamón serrano.',
 420, 15, 4, 45, 22,
 11, 3),

-- (10) Queso Cabrales a la Parrilla
('Queso Cabrales a la Parrilla',
 'Queso Cabrales a la parrilla, servido como aperitivo con pan de campo.',
 300, 18, 1, 6, 22,
 11, 3);




/*******************************************************************************
  5) INSERCIÓN DE INGREDIENTES
*******************************************************************************/
INSERT INTO ingredientes (nombre, descripcion)
VALUES
  ('Acelga', 'Hojas verdes usadas en sopas, guisos y ensaladas, ricas en vitaminas.'),
  ('Aceite de coco', 'Aceite vegetal obtenido del coco, con sabor suave y usos múltiples.'),
  ('Aceite de oliva', 'Grasa vegetal saludable, base de la dieta mediterránea.'),
  ('Aceite de sésamo', 'Aceite con sabor intenso, usado para dar un toque oriental.'),
  ('Agua', 'Líquido esencial para la vida, base de sopas y bebidas.'),
  ('Aguacate', 'Fruto cremoso rico en grasas saludables, ideal para guacamole y ensaladas.'),
  ('Ajo', 'Bulbo aromático usado para condimentar múltiples recetas.'),
  ('Ajo negro', 'Variedad de ajo fermentado, con sabor dulce y suave.'),
  ('Albahaca', 'Hierba aromática dulce, esencial en la cocina mediterránea.'),
  ('Alcaparras', 'Capullos florales encurtidos, dan un sabor ácido y salado a los platos.'),
  ('Alcachofas', 'Flor comestible con un corazón tierno, ideal para guisos o al horno.'),
  ('Alga nori', 'Alga comestible usada para envolver sushi y makis.'),
  ('Alga wakame', 'Alga usada en sopas y ensaladas, típica de la gastronomía asiática.'),
  ('Almendras', 'Fruto seco rico en grasas saludables y proteínas.'),
  ('Apio', 'Tallos crujientes de sabor fresco, usados en ensaladas y sopas.'),
  ('Arándanos', 'Pequeñas bayas ricas en antioxidantes, dulces y ligeramente ácidas.'),
  ('Arroz', 'Cereal básico, presente en múltiples recetas como guarnición o plato principal.'),
  ('Arroz basmati', 'Variedad de arroz de grano largo, aroma intenso, muy usado en cocina asiática.'),
  ('Arroz blanco', 'Arroz refinado de grano medio o largo, de uso general en cocina.'),
  ('Arroz integral', 'Arroz con salvado, de mayor aporte de fibra y nutrientes.'),
  ('Arroz para risotto', 'Variedad de arroz rica en almidón, ideal para preparar risottos cremosos.'),
  ('Atún', 'Pescado azul rico en proteínas y grasas saludables.'),
  ('Azúcar', 'Endulzante común extraído de la caña o la remolacha.'),
  ('Azúcar moreno', 'Azúcar no refinado, con sabor más profundo y color oscuro.'),
  ('Bacon', 'Tiras de panceta de cerdo ahumadas o curadas.'),
  ('Banana', 'Fruta tropical muy dulce y cremosa, ideal para batidos y postres.'),
  ('Base crujiente', 'Mezcla de galletas trituradas y mantequilla, usada para tartas.'),
  ('Base de empanada', 'Masa ligera y suave para rellenar con carne, verduras o queso.'),
  ('Base de hojaldre', 'Masa crujiente formada por múltiples capas, usada para tartas saladas o dulces.'),
  ('Base de masa integral', 'Masa de pan o pizza hecha con harina integral.'),
  ('Base de pizza', 'Masa para pizza, generalmente de harina de trigo refinada.'),
  ('Base de pizza integral', 'Masa de pizza hecha con harina integral.'),
  ('Berenjena', 'Hortaliza de piel morada y pulpa suave, ideal para asar o rellenar.'),
  ('Besugo', 'Pescado blanco apreciado, de sabor delicado, ideal para asar o al horno.'),
  ('Bechamel', 'Salsa de leche, mantequilla y harina, base para gratinados y croquetas.'),
  ('Boquerones', 'Pescado azul pequeño, usado en vinagre, frito o a la plancha.'),
  ('Brócoli', 'Hortaliza verde en forma de ramillete, rica en fibra y vitaminas.'),
  ('Brotes verdes', 'Hojas muy tiernas de lechugas, espinacas u otras plantas.'),
  ('Cacao', 'Polvo obtenido de la semilla de cacao, usado en repostería.'),
  ('Café', 'Bebida estimulante obtenida a partir de granos tostados de café.'),
  ('Café descafeinado', 'Café al que se le ha extraído la mayor parte de la cafeína.'),
  ('Camarones', 'Crustáceos pequeños, también llamados gambas en algunos lugares.'),
  ('Canela', 'Especia aromática dulce, usada en postres o platos de sabor cálido.'),
  ('Cardamomo', 'Especia de sabor intenso, usada en cocina asiática y en postres.'),
  ('Cardo', 'Tallitos carnosos, muy usados en guisos y cocidos, típicos de algunas regiones.'),
  ('Carne de cerdo', 'Carne roja proveniente del cerdo, de sabor intenso.'),
  ('Carne de cordero', 'Carne roja de cordero, con sabor característico.'),
  ('Carne de res', 'Carne roja de ternera o vaca, usada en múltiples preparaciones.'),
  ('Carne de ternera', 'Carne magra y tierna, ideal para guisos o plancha.'),
  ('Castañas', 'Fruto seco con alto contenido en hidratos, muy usado en otoño.'),
  ('Cebolla', 'Ingrediente aromático básico en sofritos, sopas y guisos.'),
  ('Cebolla caramelizada', 'Cebolla cocinada lentamente hasta lograr dulzura y color dorado.'),
  ('Cebolla morada', 'Variedad de cebolla de sabor más suave y color morado.'),
  ('Cebollino', 'Hierba fresca usada para aromatizar ensaladas y sopas.'),
  ('Champiñones', 'Setas de color claro y sabor suave, muy versátiles en cocina.'),
  ('Chía', 'Semillas ricas en fibra y grasas saludables, usadas en puddings y batidos.'),
  ('Chile', 'Pimiento picante, se usa para dar un toque de calor a los platos.'),
  ('Chistorra', 'Embutido similar al chorizo pero más delgado, típico de algunas zonas.'),
  ('Choclo (Maíz)', 'Mazorca de maíz tierno, usado en sopas y ensaladas.'),
  ('Chocolate', 'Mezcla de cacao, azúcar y manteca de cacao, base de repostería.'),
  ('Chocolate amargo', 'Variedad de chocolate con alto contenido de cacao y menos azúcar.'),
  ('Chocolate negro', 'Chocolate con un alto porcentaje de cacao, sabor intenso y amargo.'),
  ('Chorizo', 'Embutido típico con pimentón y especias, sabor intenso y ahumado.'),
  ('Cilantro', 'Hierba fresca de sabor distintivo, popular en cocina latina y asiática.'),
  ('Ciruela', 'Fruta dulce y jugosa, usada en mermeladas, postres o ensaladas.'),
  ('Clara de huevo', 'Parte blanca del huevo, rica en proteínas y sin grasa.'),
  ('Coco', 'Fruto tropical con pulpa blanca y jugosa, se usa rallado o en leche de coco.'),
  ('Col iflor', 'Planta de la familia de las crucíferas, sabor suave y textura firme.'),
  ('Comino', 'Especia de semilla pequeña y marrón, sabor terroso, muy usada en cocina árabe.'),
  ('Conejo', 'Carne blanca de sabor suave, usada en guisos y asados.'),
  ('Crema de leche', 'Parte grasa de la leche, usada para salsas y postres.'),
  ('Crema pastelera', 'Crema dulce a base de leche, huevos y azúcar, para rellenos.'),
  ('Dátiles', 'Frutos dulces de la palmera datilera, usados en postres y batidos.'),
  ('Edamame', 'Vainas de soja tiernas, hervidas y consumidas con sal.'),
  ('Emmental', 'Queso suizo de sabor suave y agujeros característicos.'),
  ('Eneldo', 'Hierba fresca con sabor anisado, usada en pescados y salsas.'),
  ('Espaguetis', 'Pasta larga y delgada, base de muchos platos italianos.'),
  ('Espárragos blancos', 'Variedad de espárragos blanqueados, sabor suave.'),
  ('Espárragos verdes', 'Variedad de espárragos de color verde, sabor más marcado.'),
  ('Fideos', 'Pasta corta o larga, base de sopas o salteados.'),
  ('Fresas', 'Fruta roja de sabor dulce y ácido, muy común en postres.'),
  ('Frutos rojos', 'Mezcla de bayas (fresas, frambuesas, arándanos) ricas en antioxidantes.'),
  ('Frutos secos', 'Conjunto de almendras, nueces, avellanas, etc., muy nutritivos.'),
  ('Gambas', 'Crustáceos de pequeño tamaño, también llamados camarones.'),
  ('Garbanzo', 'Leguminosa rica en proteínas y fibra, base de hummus y guisos.'),
  ('Gelatina', 'Producto proteico que se usa para cuajar postres y gelatinas.'),
  ('Gorgonzola', 'Queso azul italiano cremoso y de sabor fuerte.'),
  ('Granada', 'Fruta con granos rojos y dulces, se usa en ensaladas y zumos.'),
  ('Granola', 'Mezcla de avena, frutos secos y miel, consumida en desayunos.'),
  ('Guisantes', 'Leguminosas verdes y dulces, usadas en sopas y ensaladas.'),
  ('Harina', 'Polvo fino obtenido de cereales, base de panes y repostería.'),
  ('Hierbas aromáticas', 'Mezcla de plantas que aportan aroma y sabor (tomillo, orégano, etc.).'),
  ('Higos', 'Fruta dulce, suave, con semillas, usada fresca o deshidratada.'),
  ('Hojaldre', 'Masa crujiente y hojaldrada, base para tartas y empanadas dulces o saladas.'),
  ('Huevo', 'Ingrediente rico en proteínas, se consume de múltiples formas.'),
  ('Jamón cocido', 'Carne de cerdo cocida, de sabor suave y bajo en grasas.'),
  ('Jamón ibérico', 'Jamón curado de cerdo ibérico, sabor intenso y delicado.'),
  ('Jamón serrano', 'Jamón curado con sal, tradicional en la gastronomía española.'),
  ('Jengibre', 'Raíz con sabor picante y fresco, muy usado en cocina asiática.'),
  ('Judías verdes', 'Hortaliza verde en vaina con semillas, usada en guisos y ensaladas.'),
  ('Kefir', 'Producto lácteo fermentado, parecido al yogur, con probióticos.'),
  ('Kiwi', 'Fruta verde con semillas negras, sabor dulce y ácido.'),
  ('Lamprea', 'Pescado de río, apreciado en gastronomía tradicional de ciertas regiones.'),
  ('Langostinos', 'Crustáceos más grandes que las gambas, de sabor intenso.'),
  ('Lechuga', 'Hojas verdes variadas, base de ensaladas.'),
  ('Leche', 'Líquido nutritivo de origen animal, base de lácteos y salsas.'),
  ('Leche de almendra', 'Bebida vegetal hecha con almendras, sin lactosa.'),
  ('Leche de coco', 'Líquido obtenido de la pulpa de coco, base de curries y postres.'),
  ('Levadura', 'Microorganismo que hace fermentar masas de pan y otros productos.'),
  ('Lentejas', 'Legumbres ricas en proteínas, muy utilizadas en guisos y sopas.'),
  ('Lima', 'Fruta cítrica muy ácida, usada en cócteles y aderezos.'),
  ('Mango', 'Fruta tropical dulce, de pulpa anaranjada y aroma intenso.'),
  ('Manzana', 'Fruta muy común, dulce o ácida, usada en postres y ensaladas.'),
  ('Manteca de cerdo', 'Grasa procedente del cerdo, usada en algunas recetas tradicionales.'),
  ('Mantequilla', 'Grasa derivada de la leche, usada en repostería y salsas.'),
  ('Mantequilla de almendras', 'Pasta untable hecha de almendras molidas.'),
  ('Mantequilla de cacahuete', 'Pasta untable hecha de cacahuetes molidos.'),
  ('Maracuyá', 'Fruta tropical aromática, usada en jugos y postres.'),
  ('Mariscos', 'Conjunto de crustáceos y moluscos, usados en sopas o ensaladas.'),
  ('Mascarpone', 'Queso italiano muy cremoso, usado en postres como el tiramisú.'),
  ('Masa quebrada', 'Masa básica crujiente para tartas saladas o dulces.'),
  ('Masa de pizza', 'Base de pan para pizzas, habitualmente de harina refinada.'),
  ('Masa de tarta', 'Masa hojaldrada o quebrada, base para quiches o tartas.'),
  ('Masa fresca', 'Pasta hecha a mano o recién elaborada, más suave y sabrosa.'),
  ('Mayonesa', 'Salsa emulsionada a base de huevo, aceite y vinagre o limón.'),
  ('Melocotón', 'Fruta de piel aterciopelada y pulpa dulce.'),
  ('Melón', 'Fruta refrescante de pulpa dulce y jugosa.'),
  ('Menta', 'Hierba fresca y aromática, usada en bebidas y postres.'),
  ('Miel', 'Sustancia dulce producida por abejas, usada como endulzante natural.'),
  ('Migas de pan', 'Trozos de pan desmenuzado, usados para empanar.'),
  ('Mojama', 'Atún en salazón, típico de la gastronomía española.'),
  ('Mostaza', 'Salsa picante y ácida, hecha con semillas de mostaza y vinagre.'),
  ('Mozzarella', 'Queso fresco italiano de textura suave, ideal para pizzas y ensaladas.'),
  ('Mozzarella di Bufala', 'Variante de mozzarella elaborada con leche de búfala, sabor intenso y cremoso.'),
  ('Nabo', 'Raíz de sabor ligero y un punto picante, usada en sopas y guisos.'),
  ('Naranja', 'Fruta cítrica rica en vitamina C y de sabor dulce-ácido.'),
  ('Nectarina', 'Fruta con piel lisa y pulpa jugosa, similar al melocotón.'),
  ('Nueces', 'Fruto seco crujiente y nutritivo, rico en grasas saludables.'),
  ('Orégano', 'Hierba aromática mediterránea de sabor intenso.'),
  ('Pan', 'Base elaborada con harina, agua y levadura.'),
  ('Pan integral', 'Pan con harina integral, más rico en fibra.'),
  ('Pan rallado', 'Pan seco triturado para empanar o espesar.'),
  ('Papaya', 'Fruta tropical anaranjada y dulce, alta en papaína.'),
  ('Parmigiano Reggiano', 'Queso italiano duro, con sabor fuerte y salado.'),
  ('Pasta', 'Producto a base de harina de trigo, de múltiples formas.'),
  ('Patata', 'Tubérculo básico, usado frito, cocido o asado.'),
  ('Pavo', 'Carne de ave magra, ideal para dietas saludables.'),
  ('Pepino', 'Hortaliza fresca y crujiente, compuesta mayormente por agua.'),
  ('Pera', 'Fruta dulce y jugosa, usada en ensaladas o postres.'),
  ('Pesto', 'Salsa italiana de albahaca, piñones, queso y aceite de oliva.'),
  ('Piña', 'Fruta tropical ácida y dulce, ideal para ensaladas o jugos.'),
  ('Pimentón', 'Polvo rojo de pimientos secos, dulce o picante, usado en embutidos.'),
  ('Pimientos', 'Hortalizas de varios colores, con sabor dulce o picante.'),
  ('Pimientos asados', 'Pimientos cocinados al horno o a la brasa, con sabor dulce.'),
  ('Pimientos del piquillo', 'Variedad de pimientos rojos asados, habituales para rellenar.'),
  ('Pimienta negra', 'Especia molida con sabor picante, muy usada en cocciones.'),
  ('Piñones', 'Semillas del piñonero, usadas en pesto y ensaladas.'),
  ('Pipas de girasol', 'Semillas de girasol comestibles, ricas en grasas saludables.'),
  ('Plátano', 'Fruta tropical dulce de pulpa suave, rica en potasio.'),
  ('Pollo', 'Carne blanca magra, muy versátil en la cocina.'),
  ('Pomelo', 'Fruta cítrica con sabor amargo y ligeramente dulce.'),
  ('Prosciutto', 'Jamón curado italiano, de sabor delicado y aromático.'),
  ('Prosciutto crudo', 'Jamón curado italiano, similar al jamón serrano.'),
  ('Puerro', 'Hortaliza de la familia de la cebolla, sabor suave y dulce.'),
  ('Queso azul', 'Categoría de quesos con vetas de moho, sabor fuerte y salado.'),
  ('Queso brie', 'Queso francés de pasta blanda, corteza blanca y sabor suave.'),
  ('Queso cabrales', 'Queso azul asturiano de sabor intenso y picante.'),
  ('Queso cheddar', 'Queso inglés semiduro, sabor variable de suave a intenso.'),
  ('Queso cottage', 'Queso fresco y suave, bajo en calorías.'),
  ('Queso de cabra', 'Queso cremoso y ligeramente ácido elaborado con leche de cabra.'),
  ('Queso de Radiquero', 'Queso artesanal de cabra, suave y fundente.'),
  ('Queso de Tetilla', 'Queso gallego cremoso, forma cónica, ideal para fundir.'),
  ('Queso fresco', 'Queso suave y de sabor delicado, con alto contenido de agua.'),
  ('Queso gorgonzola', 'Queso azul italiano de sabor fuerte y textura cremosa.'),
  ('Queso idiazábal', 'Queso ahumado de oveja, típico del País Vasco.'),
  ('Queso manchego', 'Queso de oveja español, sabor mantecoso y curación variable.'),
  ('Queso mascarpone', 'Queso cremoso italiano, esencial en tiramisú.'),
  ('Queso mozzarella', 'Queso fresco italiano de leche de vaca, suave y elástico.'),
  ('Queso parmesano', 'Queso italiano duro y salado, muy usado rallado.'),
  ('Queso pecorino', 'Queso italiano de oveja, sabor fuerte y salado.'),
  ('Queso ricotta', 'Queso italiano suave y granuloso, elaborado a partir de suero.'),
  ('Quinoa', 'Pseudocereal alto en proteínas, libre de gluten.'),
  ('Rábanos', 'Raíces pequeñas de sabor picante, usadas en ensaladas.'),
  ('Radicchio', 'Variedad de achicoria roja, sabor amargo.'),
  ('Romero', 'Hierba aromática de sabor intenso, usada en carnes y guisos.'),
  ('Rúcula', 'Hoja verde de sabor ligeramente picante.'),
  ('Salmón', 'Pescado azul rico en ácidos grasos omega-3.'),
  ('Sal', 'Condimento básico para realzar sabores.'),
  ('Salchichón', 'Embutido curado de carne de cerdo, sabor suave y especiado.'),
  ('Salsa de soja', 'Salsa fermentada de soja, aporta sabor umami a los platos.'),
  ('Sardinas', 'Pescado azul pequeño, muy consumido en asados y conservas.'),
  ('Semillas de lino', 'Semillas ricas en fibra y omega-3, usadas en panadería.'),
  ('Setas', 'Hongos comestibles, ricos en sabor y textura.'),
  ('Sidra', 'Bebida alcohólica hecha de manzanas fermentadas.'),
  ('Soja', 'Leguminosa base de tofu, tempeh y salsa de soja.'),
  ('Tomate', 'Fruto jugoso y versátil, base de salsas y ensaladas.'),
  ('Tomates asados', 'Tomates cocinados al horno o sartén, sabor dulce.'),
  ('Tomates cherry', 'Variedad de tomate pequeño y dulce.'),
  ('Tomates secos', 'Tomates deshidratados con sabor concentrado.'),
  ('Trufa', 'Hongo subterráneo muy apreciado, sabor y aroma intensos.'),
  ('Uvas', 'Fruta dulce en racimos, base del vino y muy versátil en recetas.'),
  ('Vainilla', 'Vaina aromática usada para dar sabor dulce a postres.'),
  ('Vinagre', 'Condimento ácido usado en aderezos y marinados.'),
  ('Vinagre de Jerez', 'Variedad de vinagre española, sabor fuerte y aromático.'),
  ('Vinagre de sidra', 'Vinagre derivado de la sidra, usado en aderezos y encurtidos.'),
  ('Vino blanco', 'Bebida alcohólica de uvas blancas, usado para cocinar y marinar.'),
  ('Vino tinto', 'Vino de uvas negras, aporta color y sabor a guisos y salsas.'),
  ('Xantana', 'Espesante alimentario usado en salsas y postres.'),
  ('Yogur', 'Producto lácteo fermentado, base para aderezos y postres.'),
  ('Yogur griego', 'Variedad de yogur más espeso y cremoso, alto en proteínas.'),
  ('Yogur natural', 'Lácteo fresco y suave, sin azúcar añadido.'),
  ('Zanahoria', 'Raíz naranja rica en betacaroteno, usada en sopas y ensaladas.'),
  ('Zumo de limón', 'Jugo de limón para aderezos, marinados y bebidas.'),
  ('Caldo de verduras', 'Caldo preparado con una variedad de verduras, ideal para sopas, risottos y guisos.'),
  ('Tofu', 'Producto a base de soja, rico en proteínas y de textura firme, utilizado como sustituto de la carne.'),
  ('Limón', 'Fruta cítrica rica en vitamina C, utilizada para aderezar, marinar y dar frescura a los platos.'),
  ('Perejil', 'Hierba aromática fresca que aporta un toque de color y sabor ligero.'),
  ('Curry', 'Mezcla de especias exóticas que confiere un sabor picante y aromático a las recetas.'),
  ('Caldo de pescado', 'Caldo elaborado con pescado y verduras, ideal para sopas y risottos de mariscos.'),
  ('Salsa barbacoa', 'Salsa dulce y ahumada, perfecta para glasear carnes a la parrilla.'),
  ('Espinacas', 'Hojas verdes ricas en nutrientes, usadas en ensaladas, salteados y sopas.'),
  ('Tahini', 'Pasta de semillas de sésamo, esencial para preparar hummus y aderezos orientales.');


/*******************************************************************************
  6) RELACIONES EN LA TABLA INTERMEDIA "receta_ingredientes"
     USANDO EL PROCEDIMIENTO ALMACENADO InsertarIngredienteEnReceta
*******************************************************************************/



DELIMITER $$

-- 1) Borra las dos versiones del SP
DROP PROCEDURE IF EXISTS sp_insert_receta_ingrediente $$
DROP PROCEDURE IF EXISTS InsertarIngredienteEnReceta $$

-- 2) Crea de nuevo InsertarIngredienteEnReceta
CREATE PROCEDURE InsertarIngredienteEnReceta(
    IN p_receta      VARCHAR(150),
    IN p_ingrediente VARCHAR(150),
    IN p_cantidad    DECIMAL(10,2),
    IN p_unidad      VARCHAR(20)
)
BEGIN
    DECLARE vRecetaId      INT;
    DECLARE vIngredienteId INT;
    DECLARE vUnidadId      TINYINT UNSIGNED;

    -- Busca los IDs
    SELECT id INTO vRecetaId
      FROM recetas
     WHERE nombre = p_receta
     LIMIT 1;

    SELECT id INTO vIngredienteId
      FROM ingredientes
     WHERE nombre = p_ingrediente
     LIMIT 1;

    SELECT id INTO vUnidadId
      FROM unidades
     WHERE nombre = p_unidad
     LIMIT 1;

    -- Si alguno no existe, lanzamos error
    IF vRecetaId IS NULL OR vIngredienteId IS NULL OR vUnidadId IS NULL THEN
        SIGNAL SQLSTATE '45000'
               SET MESSAGE_TEXT = 'Receta, ingrediente o unidad inexistente';
    END IF;

    -- Inserta usando unidad_id
    INSERT INTO receta_ingredientes
        (receta_id, ingrediente_id, cantidad, unidad_id)
    VALUES
        (vRecetaId, vIngredienteId, p_cantidad, vUnidadId);
END$$

DELIMITER ;


/*                       1) SETAS (categoria_id = 1) */

/* 1) Setas Salteadas con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Setas Salteadas con Ajo y Perejil','Setas',200,'g');
CALL InsertarIngredienteEnReceta('Setas Salteadas con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Setas Salteadas con Ajo y Perejil','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Setas Salteadas con Ajo y Perejil','Sal',1,'pizca');

/* 2) Crema de Setas Saludable */
CALL InsertarIngredienteEnReceta('Crema de Setas Saludable','Setas',200,'g');
CALL InsertarIngredienteEnReceta('Crema de Setas Saludable','Cebolla',1,'unidad');
CALL InsertarIngredienteEnReceta('Crema de Setas Saludable','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Setas Saludable','Aceite de oliva',1,'cda');

/* 3) Pizza de Setas y Espinacas */
CALL InsertarIngredienteEnReceta('Pizza de Setas y Espinacas','Base de pizza integral',1,'base');
CALL InsertarIngredienteEnReceta('Pizza de Setas y Espinacas','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Pizza de Setas y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Setas y Espinacas','Queso bajo en grasa',50,'g');

/* 4) Revuelto de Setas con Tofu */
CALL InsertarIngredienteEnReceta('Revuelto de Setas con Tofu','Setas',150,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Setas con Tofu','Tofu',100,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Setas con Tofu','Aceite de oliva',1,'cda');

/* 5) Ensalada de Setas y Espárragos */
CALL InsertarIngredienteEnReceta('Ensalada de Setas y Espárragos','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Setas y Espárragos','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Setas y Espárragos','Rúcula',50,'g');

/* 6) Setas al Horno con Limón y Romero */
CALL InsertarIngredienteEnReceta('Setas al Horno con Limón y Romero','Setas',200,'g');
CALL InsertarIngredienteEnReceta('Setas al Horno con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Setas al Horno con Limón y Romero','Romero',1,'cdita');

/* 7) Risotto de Setas y Espárragos */
CALL InsertarIngredienteEnReceta('Risotto de Setas y Espárragos','Arroz para risotto',150,'g');
CALL InsertarIngredienteEnReceta('Risotto de Setas y Espárragos','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Risotto de Setas y Espárragos','Espárragos',80,'g');
CALL InsertarIngredienteEnReceta('Risotto de Setas y Espárragos','Caldo de verduras',500,'ml');

/* 8) Setas en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Setas en Salsa de Vino Blanco','Setas',200,'g');
CALL InsertarIngredienteEnReceta('Setas en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Setas en Salsa de Vino Blanco','Cebolla',1,'unidad');

/* 9) Brochetas de Setas y Verduras */
CALL InsertarIngredienteEnReceta('Brochetas de Setas y Verduras','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Setas y Verduras','Pimientos',80,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Setas y Verduras','Calabacín',80,'g');

/* 10) Setas al Ajillo */
CALL InsertarIngredienteEnReceta('Setas al Ajillo','Setas',200,'g');
CALL InsertarIngredienteEnReceta('Setas al Ajillo','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Setas al Ajillo','Aceite de oliva',1,'cda');


/*                       2) CARNE (categoria_id = 2) */

/* Filete de Ternera a la Parrilla con Espárragos */
CALL InsertarIngredienteEnReceta('Filete de Ternera a la Parrilla con Espárragos','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Filete de Ternera a la Parrilla con Espárragos','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Filete de Ternera a la Parrilla con Espárragos','Aceite de oliva',1,'cda');

/* Stir Fry de Ternera con Verduras */
CALL InsertarIngredienteEnReceta('Stir Fry de Ternera con Verduras','Carne de ternera',150,'g');
CALL InsertarIngredienteEnReceta('Stir Fry de Ternera con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Stir Fry de Ternera con Verduras','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Stir Fry de Ternera con Verduras','Brócoli',100,'g');

/* Hamburguesas de Ternera a la Parrilla */
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera a la Parrilla','Carne de ternera',150,'g');
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera a la Parrilla','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera a la Parrilla','Lechuga',1,'hoja');

/* Carne de Ternera con Verduras al Horno */
CALL InsertarIngredienteEnReceta('Carne de Ternera con Verduras al Horno','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Carne de Ternera con Verduras al Horno','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Carne de Ternera con Verduras al Horno','Pimiento',1,'unidad');

/* Guiso de Ternera con Champiñones */
CALL InsertarIngredienteEnReceta('Guiso de Ternera con Champiñones','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Guiso de Ternera con Champiñones','Champiñones',100,'g');
CALL InsertarIngredienteEnReceta('Guiso de Ternera con Champiñones','Cebolla',1,'unidad');

/* Ternera en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Ternera en Salsa de Mostaza y Miel','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Ternera en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Ternera en Salsa de Mostaza y Miel','Miel',1,'cda');

/* Albóndigas de Ternera con Tomate */
CALL InsertarIngredienteEnReceta('Albóndigas de Ternera con Tomate','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Albóndigas de Ternera con Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Albóndigas de Ternera con Tomate','Aceite de oliva',1,'cda');

/* Carne de Ternera a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Carne de Ternera a la Plancha con Ensalada','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Carne de Ternera a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Carne de Ternera a la Plancha con Ensalada','Tomate',1,'unidad');

/* Estofado de Ternera con Verduras */
CALL InsertarIngredienteEnReceta('Estofado de Ternera con Verduras','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Estofado de Ternera con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Estofado de Ternera con Verduras','Patata',1,'unidad');

/* Bistec de Ternera a la Parrilla */
CALL InsertarIngredienteEnReceta('Bistec de Ternera a la Parrilla','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Bistec de Ternera a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Bistec de Ternera a la Parrilla','Sal',1,'pizca');


/*                3) CORDERO (categoria_id = 3) = TERNASCO           */

/* Asado de Ternasco al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Asado de Ternasco al Horno con Hierbas','Carne de cordero',300,'g');
CALL InsertarIngredienteEnReceta('Asado de Ternasco al Horno con Hierbas','Romero',1,'cdita');
CALL InsertarIngredienteEnReceta('Asado de Ternasco al Horno con Hierbas','Tomillo',1,'cdita');

/* Ternasco a la Parrilla con Limón y Romero */
CALL InsertarIngredienteEnReceta('Ternasco a la Parrilla con Limón y Romero','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Ternasco a la Parrilla con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Ternasco a la Parrilla con Limón y Romero','Romero',1,'cdita');

/* Estofado de Ternasco con Patatas y Verduras */
CALL InsertarIngredienteEnReceta('Estofado de Ternasco con Patatas y Verduras','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Estofado de Ternasco con Patatas y Verduras','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Estofado de Ternasco con Patatas y Verduras','Zanahoria',1,'unidad');

/* Brochetas de Ternasco con Pimientos */
CALL InsertarIngredienteEnReceta('Brochetas de Ternasco con Pimientos','Carne de cordero',200,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Ternasco con Pimientos','Pimiento rojo',1,'unidad');
CALL InsertarIngredienteEnReceta('Brochetas de Ternasco con Pimientos','Pimiento verde',1,'unidad');

/* Ragú de Ternasco con Tomate */
CALL InsertarIngredienteEnReceta('Ragú de Ternasco con Tomate','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Ragú de Ternasco con Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ragú de Ternasco con Tomate','Cebolla',1,'unidad');

/* Ternasco a la Mostaza con Puré de Zanahorias */
CALL InsertarIngredienteEnReceta('Ternasco a la Mostaza con Puré de Zanahorias','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Ternasco a la Mostaza con Puré de Zanahorias','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Ternasco a la Mostaza con Puré de Zanahorias','Zanahoria',2,'unidad');

/* Costillas de Ternasco a la Barbacoa */
CALL InsertarIngredienteEnReceta('Costillas de Ternasco a la Barbacoa','Carne de cordero',300,'g');
CALL InsertarIngredienteEnReceta('Costillas de Ternasco a la Barbacoa','Salsa barbacoa',2,'cda');

/* Ternasco a la Plancha con Ensalada Mediterránea */
CALL InsertarIngredienteEnReceta('Ternasco a la Plancha con Ensalada Mediterránea','Carne de cordero',200,'g');
CALL InsertarIngredienteEnReceta('Ternasco a la Plancha con Ensalada Mediterránea','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ternasco a la Plancha con Ensalada Mediterránea','Pepino',50,'g');

/* Ternasco Guisado con Garbanzos */
CALL InsertarIngredienteEnReceta('Ternasco Guisado con Garbanzos','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Ternasco Guisado con Garbanzos','Garbanzos',100,'g');
CALL InsertarIngredienteEnReceta('Ternasco Guisado con Garbanzos','Cebolla',1,'unidad');

/* Ternasco al Ajillo */
CALL InsertarIngredienteEnReceta('Ternasco al Ajillo','Carne de cordero',250,'g');
CALL InsertarIngredienteEnReceta('Ternasco al Ajillo','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Ternasco al Ajillo','Aceite de oliva',1,'cda');

/*                   4) CONEJO (categoria_id = 4) */
/* Conejo al Ajillo */
CALL InsertarIngredienteEnReceta('Conejo al Ajillo','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo al Ajillo','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Conejo al Ajillo','Vino blanco',100,'ml');

/* Conejo a la Cazadora */
CALL InsertarIngredienteEnReceta('Conejo a la Cazadora','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo a la Cazadora','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Conejo a la Cazadora','Pimiento',1,'unidad');

/* Conejo Asado con Romero */
CALL InsertarIngredienteEnReceta('Conejo Asado con Romero','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo Asado con Romero','Romero',1,'cda');
CALL InsertarIngredienteEnReceta('Conejo Asado con Romero','Aceite de oliva',1,'cda');

/* Estofado de Conejo con Patatas */
CALL InsertarIngredienteEnReceta('Estofado de Conejo con Patatas','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Estofado de Conejo con Patatas','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Estofado de Conejo con Patatas','Zanahoria',1,'unidad');

/* Conejo al Horno con Verduras */
CALL InsertarIngredienteEnReceta('Conejo al Horno con Verduras','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo al Horno con Verduras','Cebolla',1,'unidad');
CALL InsertarIngredienteEnReceta('Conejo al Horno con Verduras','Pimiento',1,'unidad');

/* Conejo a la Mostaza */
CALL InsertarIngredienteEnReceta('Conejo a la Mostaza','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo a la Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Conejo a la Mostaza','Crema de leche',50,'ml');

/* Conejo con Setas */
CALL InsertarIngredienteEnReceta('Conejo con Setas','Conejo',250,'g');
CALL InsertarIngredienteEnReceta('Conejo con Setas','Setas',150,'g');
CALL InsertarIngredienteEnReceta('Conejo con Setas','Vino blanco',100,'ml');

/* Conejo en Salsa de Vino */
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Vino','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Vino','Vino tinto',100,'ml');
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Vino','Cebolla',1,'unidad');

/* Conejo con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Conejo con Tomate y Albahaca','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Conejo con Tomate y Albahaca','Albahaca',1,'cda');

/* Conejo en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Mostaza y Miel','Conejo',300,'g');
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Conejo en Salsa de Mostaza y Miel','Miel',1,'cda');


/*                   5) CERDO (categoria_id = 5) */

/* Lomo de Cerdo Asado con Manzanas */
CALL InsertarIngredienteEnReceta('Lomo de Cerdo Asado con Manzanas','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Lomo de Cerdo Asado con Manzanas','Manzana',1,'unidad');
CALL InsertarIngredienteEnReceta('Lomo de Cerdo Asado con Manzanas','Aceite de oliva',1,'cda');

/* Costillas de Cerdo a la Barbacoa */
CALL InsertarIngredienteEnReceta('Costillas de Cerdo a la Barbacoa','Carne de cerdo',400,'g');
CALL InsertarIngredienteEnReceta('Costillas de Cerdo a la Barbacoa','Salsa barbacoa',2,'cda');

/* Cerdo a la Cazadora */
CALL InsertarIngredienteEnReceta('Cerdo a la Cazadora','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Cerdo a la Cazadora','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Cerdo a la Cazadora','Zanahoria',1,'unidad');

/* Chuletas de Cerdo a la Parrilla */
CALL InsertarIngredienteEnReceta('Chuletas de Cerdo a la Parrilla','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Chuletas de Cerdo a la Parrilla','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Chuletas de Cerdo a la Parrilla','Pimienta negra',1,'pizca');

/* Cerdo en Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Mostaza','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Mostaza','Miel',1,'cda');

/* Cerdo a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Cerdo a la Plancha con Ensalada','Carne de cerdo',200,'g');
CALL InsertarIngredienteEnReceta('Cerdo a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Cerdo a la Plancha con Ensalada','Tomate',1,'unidad');

/* Estofado de Cerdo con Verduras */
CALL InsertarIngredienteEnReceta('Estofado de Cerdo con Verduras','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Estofado de Cerdo con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Estofado de Cerdo con Verduras','Patata',1,'unidad');

/* Cerdo en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Vino Blanco','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Cerdo en Salsa de Vino Blanco','Cebolla',1,'unidad');

/* Cerdo al Horno con Romero y Ajo */
CALL InsertarIngredienteEnReceta('Cerdo al Horno con Romero y Ajo','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Cerdo al Horno con Romero y Ajo','Romero',1,'cda');
CALL InsertarIngredienteEnReceta('Cerdo al Horno con Romero y Ajo','Ajo',2,'diente');

/* Albóndigas de Cerdo con Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Albóndigas de Cerdo con Salsa de Tomate','Carne de cerdo',300,'g');
CALL InsertarIngredienteEnReceta('Albóndigas de Cerdo con Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Albóndigas de Cerdo con Salsa de Tomate','Cebolla',1,'unidad');


/*                    6) AVES (categoria_id = 6) */

/* Pollo al Horno con Limón y Hierbas */
CALL InsertarIngredienteEnReceta('Pollo al Horno con Limón y Hierbas','Pollo',300,'g');
CALL InsertarIngredienteEnReceta('Pollo al Horno con Limón y Hierbas','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Pollo al Horno con Limón y Hierbas','Hierbas aromáticas',1,'cda');

/* Pechugas de Pollo a la Parrilla */
CALL InsertarIngredienteEnReceta('Pechugas de Pollo a la Parrilla','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pechugas de Pollo a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Pechugas de Pollo a la Parrilla','Pimienta negra',1,'pizca');

/* Pollo al Curry con Arroz */
CALL InsertarIngredienteEnReceta('Pollo al Curry con Arroz','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo al Curry con Arroz','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Pollo al Curry con Arroz','Arroz',100,'g');

/* Pollo en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Tomate','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Tomate','Cebolla',1,'unidad');

/* Pollo a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Pollo a la Plancha con Ensalada','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Pollo a la Plancha con Ensalada','Tomate',1,'unidad');

/* Pollo a la Barbacoa */
CALL InsertarIngredienteEnReceta('Pollo a la Barbacoa','Pollo',300,'g');
CALL InsertarIngredienteEnReceta('Pollo a la Barbacoa','Salsa barbacoa',2,'cda');

/* Pollo al Ajillo */
CALL InsertarIngredienteEnReceta('Pollo al Ajillo','Pollo',300,'g');
CALL InsertarIngredienteEnReceta('Pollo al Ajillo','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Pollo al Ajillo','Aceite de oliva',1,'cda');

/* Pollo en Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Mostaza','Pollo',300,'g');
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Pollo en Salsa de Mostaza','Miel',1,'cda');

/* Tacos de Pollo */
CALL InsertarIngredienteEnReceta('Tacos de Pollo','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Tacos de Pollo','Tortillas de trigo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tacos de Pollo','Cebolla',1,'unidad');

/* Pollo a la Naranja */
CALL InsertarIngredienteEnReceta('Pollo a la Naranja','Pollo',300,'g');
CALL InsertarIngredienteEnReceta('Pollo a la Naranja','Naranja',2,'unidad');
CALL InsertarIngredienteEnReceta('Pollo a la Naranja','Aceite de oliva',1,'cda');

/* Pavo a la Plancha con Limón y Ajo */
CALL InsertarIngredienteEnReceta('Pavo a la Plancha con Limón y Ajo','Pavo',200,'g');
CALL InsertarIngredienteEnReceta('Pavo a la Plancha con Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Pavo a la Plancha con Limón y Ajo','Ajo',2,'diente');

/* Albóndigas de Pavo con Tomate */
CALL InsertarIngredienteEnReceta('Albóndigas de Pavo con Tomate','Pavo',200,'g');
CALL InsertarIngredienteEnReceta('Albóndigas de Pavo con Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Albóndigas de Pavo con Tomate','Aceite de oliva',1,'cda');

/* Ensalada de Pavo y Aguacate */
CALL InsertarIngredienteEnReceta('Ensalada de Pavo y Aguacate','Pavo',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pavo y Aguacate','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pavo y Aguacate','Lechuga',50,'g');

/* Tacos de Pavo con Guacamole */
CALL InsertarIngredienteEnReceta('Tacos de Pavo con Guacamole','Pavo',150,'g');
CALL InsertarIngredienteEnReceta('Tacos de Pavo con Guacamole','Guacamole',2,'cda');
CALL InsertarIngredienteEnReceta('Tacos de Pavo con Guacamole','Tortillas de trigo',2,'unidad');

/* Pavo al Horno con Verduras */
CALL InsertarIngredienteEnReceta('Pavo al Horno con Verduras','Pavo',300,'g');
CALL InsertarIngredienteEnReceta('Pavo al Horno con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Pavo al Horno con Verduras','Patata',1,'unidad');

/* Pavo a la Barbacoa */
CALL InsertarIngredienteEnReceta('Pavo a la Barbacoa','Pavo',300,'g');
CALL InsertarIngredienteEnReceta('Pavo a la Barbacoa','Salsa barbacoa',2,'cda');

/* Estofado de Pavo con Verduras */
CALL InsertarIngredienteEnReceta('Estofado de Pavo con Verduras','Pavo',300,'g');
CALL InsertarIngredienteEnReceta('Estofado de Pavo con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Estofado de Pavo con Verduras','Patata',1,'unidad');

/* Pavo al Curry con Arroz Integral */
CALL InsertarIngredienteEnReceta('Pavo al Curry con Arroz Integral','Pavo',250,'g');
CALL InsertarIngredienteEnReceta('Pavo al Curry con Arroz Integral','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Pavo al Curry con Arroz Integral','Arroz integral',100,'g');

/* Pavo en Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Pavo en Salsa de Mostaza','Pavo',250,'g');
CALL InsertarIngredienteEnReceta('Pavo en Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Pavo en Salsa de Mostaza','Miel',1,'cda');

/* Hamburguesas de Pavo con Espinacas */
CALL InsertarIngredienteEnReceta('Hamburguesas de Pavo con Espinacas','Pavo',150,'g');
CALL InsertarIngredienteEnReceta('Hamburguesas de Pavo con Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Hamburguesas de Pavo con Espinacas','Pan',1,'unidad');


/*                    7) PESCADO (categoria_id = 7)                 */
/*        Se incluyen aquí todos los pescados, completando 10      */
/*        recetas por cada especie, con 2-4 ingredientes clave.     */

/* ----- VERDEL (10 recetas) ----- */

/* 1) Verdel a la Parrilla con Limón y Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Verdel a la Parrilla con Limón y Aceite de Oliva','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel a la Parrilla con Limón y Aceite de Oliva','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Verdel a la Parrilla con Limón y Aceite de Oliva','Aceite de oliva',1,'cda');

/* 2) Verdel al Horno con Hierbas Aromáticas */
CALL InsertarIngredienteEnReceta('Verdel al Horno con Hierbas Aromáticas','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel al Horno con Hierbas Aromáticas','Tomillo',1,'cdita');
CALL InsertarIngredienteEnReceta('Verdel al Horno con Hierbas Aromáticas','Romero',1,'cdita');

/* 3) Verdel en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Verdel en Salsa de Tomate','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Verdel en Salsa de Tomate','Ajo',2,'diente');

/* 4) Verdel con Pesto de Albahaca y Piñones */
CALL InsertarIngredienteEnReceta('Verdel con Pesto de Albahaca y Piñones','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel con Pesto de Albahaca y Piñones','Pesto',2,'cda');
CALL InsertarIngredienteEnReceta('Verdel con Pesto de Albahaca y Piñones','Piñones',20,'g');

/* 5) Verdel al Vapor con Verduras */
CALL InsertarIngredienteEnReceta('Verdel al Vapor con Verduras','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel al Vapor con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Verdel al Vapor con Verduras','Calabacín',100,'g');

/* 6) Verdel con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Mostaza y Miel','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 7) Verdel al Horno con Papas y Romero */
CALL InsertarIngredienteEnReceta('Verdel al Horno con Papas y Romero','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel al Horno con Papas y Romero','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Verdel al Horno con Papas y Romero','Romero',1,'cdita');

/* 8) Verdel con Arroz Integral */
CALL InsertarIngredienteEnReceta('Verdel con Arroz Integral','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel con Arroz Integral','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Verdel con Arroz Integral','Aceite de oliva',1,'cda');

/* 9) Verdel con Salsa de Ajo y Vino Blanco */
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Ajo y Vino Blanco','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Ajo y Vino Blanco','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Verdel con Salsa de Ajo y Vino Blanco','Vino blanco',100,'ml');

/* 10) Verdel a la Cazuela con Pimientos */
CALL InsertarIngredienteEnReceta('Verdel a la Cazuela con Pimientos','Verdel',200,'g');
CALL InsertarIngredienteEnReceta('Verdel a la Cazuela con Pimientos','Pimiento rojo',1,'unidad');
CALL InsertarIngredienteEnReceta('Verdel a la Cazuela con Pimientos','Tomate',1,'unidad');


/* ----- TRUCHA (10 recetas) ----- */

/* 1) Trucha a la Plancha con Limón y Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Trucha a la Plancha con Limón y Aceite de Oliva','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha a la Plancha con Limón y Aceite de Oliva','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Trucha a la Plancha con Limón y Aceite de Oliva','Aceite de oliva',1,'cda');

/* 2) Trucha al Horno con Hierbas Aromáticas */
CALL InsertarIngredienteEnReceta('Trucha al Horno con Hierbas Aromáticas','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha al Horno con Hierbas Aromáticas','Romero',1,'cdita');
CALL InsertarIngredienteEnReceta('Trucha al Horno con Hierbas Aromáticas','Tomillo',1,'cdita');

/* 3) Trucha con Salsa de Almendras */
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Almendras','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Almendras','Almendras',20,'g');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Almendras','Ajo',2,'diente');

/* 4) Trucha a la Parrilla con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Trucha a la Parrilla con Salsa de Mostaza y Miel','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha a la Parrilla con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Trucha a la Parrilla con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 5) Trucha al Vapor con Verduras */
CALL InsertarIngredienteEnReceta('Trucha al Vapor con Verduras','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha al Vapor con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Trucha al Vapor con Verduras','Calabacín',80,'g');

/* 6) Trucha con Arroz Integral y Espinacas */
CALL InsertarIngredienteEnReceta('Trucha con Arroz Integral y Espinacas','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha con Arroz Integral y Espinacas','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Trucha con Arroz Integral y Espinacas','Espinacas',50,'g');

/* 7) Trucha con Salsa de Limón y Alcaparras */
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Limón y Alcaparras','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Limón y Alcaparras','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Limón y Alcaparras','Alcaparras',1,'cda');

/* 8) Trucha con Pesto de Albahaca */
CALL InsertarIngredienteEnReceta('Trucha con Pesto de Albahaca','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha con Pesto de Albahaca','Pesto',2,'cda');
CALL InsertarIngredienteEnReceta('Trucha con Pesto de Albahaca','Aceite de oliva',1,'cda');

/* 9) Trucha al Curry con Arroz Basmati */
CALL InsertarIngredienteEnReceta('Trucha al Curry con Arroz Basmati','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha al Curry con Arroz Basmati','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Trucha al Curry con Arroz Basmati','Arroz basmati',80,'g');

/* 10) Trucha con Salsa de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Tomate y Albahaca','Trucha',200,'g');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Trucha con Salsa de Tomate y Albahaca','Albahaca',1,'cda');


/* ----- SARGO (10 recetas) ----- */

/* 1) Sargo a la Plancha con Aceite de Oliva y Ajo */
CALL InsertarIngredienteEnReceta('Sargo a la Plancha con Aceite de Oliva y Ajo','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo a la Plancha con Aceite de Oliva y Ajo','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Sargo a la Plancha con Aceite de Oliva y Ajo','Ajo',2,'diente');

/* 2) Sargo al Horno con Hierbas Provenzales */
CALL InsertarIngredienteEnReceta('Sargo al Horno con Hierbas Provenzales','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo al Horno con Hierbas Provenzales','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Sargo al Horno con Hierbas Provenzales','Aceite de oliva',1,'cda');

/* 3) Sargo a la Parrilla con Salsa de Manteca de Cerdo */
CALL InsertarIngredienteEnReceta('Sargo a la Parrilla con Salsa de Manteca de Cerdo','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo a la Parrilla con Salsa de Manteca de Cerdo','Manteca de cerdo',1,'cda');
CALL InsertarIngredienteEnReceta('Sargo a la Parrilla con Salsa de Manteca de Cerdo','Pimienta negra',1,'pizca');

/* 4) Sargo al Vapor con Limón y Ajo */
CALL InsertarIngredienteEnReceta('Sargo al Vapor con Limón y Ajo','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo al Vapor con Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Sargo al Vapor con Limón y Ajo','Ajo',2,'diente');

/* 5) Sargo con Ensalada de Hortalizas */
CALL InsertarIngredienteEnReceta('Sargo con Ensalada de Hortalizas','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo con Ensalada de Hortalizas','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Sargo con Ensalada de Hortalizas','Tomate',1,'unidad');

/* 6) Sargo con Salsa de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Sargo con Salsa de Tomate y Albahaca','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo con Salsa de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Sargo con Salsa de Tomate y Albahaca','Albahaca',1,'cda');

/* 7) Sargo al Horno con Papas y Pimientos */
CALL InsertarIngredienteEnReceta('Sargo al Horno con Papas y Pimientos','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo al Horno con Papas y Pimientos','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Sargo al Horno con Papas y Pimientos','Pimiento',1,'unidad');

/* 8) Sargo con Arroz Integral y Espinacas */
CALL InsertarIngredienteEnReceta('Sargo con Arroz Integral y Espinacas','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo con Arroz Integral y Espinacas','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Sargo con Arroz Integral y Espinacas','Espinacas',50,'g');

/* 9) Sargo en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Sargo en Salsa de Vino Blanco','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Sargo en Salsa de Vino Blanco','Ajo',2,'diente');

/* 10) Sargo con Pesto de Albahaca */
CALL InsertarIngredienteEnReceta('Sargo con Pesto de Albahaca','Sargo',200,'g');
CALL InsertarIngredienteEnReceta('Sargo con Pesto de Albahaca','Pesto',2,'cda');
CALL InsertarIngredienteEnReceta('Sargo con Pesto de Albahaca','Aceite de oliva',1,'cda');


/* ----- SARDINAS (10 recetas) ----- */

/* 1) Sardinas a la Plancha con Limón y Ajo */
CALL InsertarIngredienteEnReceta('Sardinas a la Plancha con Limón y Ajo','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas a la Plancha con Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Sardinas a la Plancha con Limón y Ajo','Ajo',2,'diente');

/* 2) Sardinas al Horno con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Tomate y Albahaca','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Tomate y Albahaca','Albahaca',1,'cda');

/* 3) Ensalada de Sardinas y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Sardinas y Garbanzos','Sardinas',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Sardinas y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Sardinas y Garbanzos','Cebolla',1,'unidad');

/* 4) Sardinas a la Parrilla con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Sardinas a la Parrilla con Salsa de Mostaza y Miel','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas a la Parrilla con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Sardinas a la Parrilla con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 5) Sardinas Fritas con Ensalada de Tomate */
CALL InsertarIngredienteEnReceta('Sardinas Fritas con Ensalada de Tomate','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas Fritas con Ensalada de Tomate','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Sardinas Fritas con Ensalada de Tomate','Tomate',1,'unidad');

/* 6) Sardinas con Pimientos y Calabacín */
CALL InsertarIngredienteEnReceta('Sardinas con Pimientos y Calabacín','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas con Pimientos y Calabacín','Pimientos',80,'g');
CALL InsertarIngredienteEnReceta('Sardinas con Pimientos y Calabacín','Calabacín',80,'g');

/* 7) Sardinas con Puré de Patatas y Ensalada */
CALL InsertarIngredienteEnReceta('Sardinas con Puré de Patatas y Ensalada','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas con Puré de Patatas y Ensalada','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Sardinas con Puré de Patatas y Ensalada','Lechuga',50,'g');

/* 8) Sardinas al Horno con Limón y Romero */
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Limón y Romero','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Sardinas al Horno con Limón y Romero','Romero',1,'cdita');

/* 9) Sardinas con Ensalada de Quinoa */
CALL InsertarIngredienteEnReceta('Sardinas con Ensalada de Quinoa','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas con Ensalada de Quinoa','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Sardinas con Ensalada de Quinoa','Tomate',1,'unidad');

/* 10) Sardinas en Salsa de Tomate Picante */
CALL InsertarIngredienteEnReceta('Sardinas en Salsa de Tomate Picante','Sardinas',200,'g');
CALL InsertarIngredienteEnReceta('Sardinas en Salsa de Tomate Picante','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Sardinas en Salsa de Tomate Picante','Guindilla',1,'unidad');


/* ----- SALMÓNETE (10 recetas) ----- */

/* 1) Salmónete a la Plancha con Ajo y Limón */
CALL InsertarIngredienteEnReceta('Salmónete a la Plancha con Ajo y Limón','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete a la Plancha con Ajo y Limón','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Salmónete a la Plancha con Ajo y Limón','Limón',1,'unidad');

/* 2) Salmónete al Horno con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Salmónete al Horno con Tomate y Albahaca','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete al Horno con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Salmónete al Horno con Tomate y Albahaca','Albahaca',1,'cda');

/* 3) Salmónete a la Parrilla con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Salmónete a la Parrilla con Salsa de Mostaza y Miel','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete a la Parrilla con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Salmónete a la Parrilla con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 4) Ensalada de Salmónete y Espárragos */
CALL InsertarIngredienteEnReceta('Ensalada de Salmónete y Espárragos','Salmónete',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Salmónete y Espárragos','Espárragos',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Salmónete y Espárragos','Aguacate',1,'unidad');

/* 5) Salmónete con Puré de Patata y Ensalada de Lechuga */
CALL InsertarIngredienteEnReceta('Salmónete con Puré de Patata y Ensalada de Lechuga','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete con Puré de Patata y Ensalada de Lechuga','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmónete con Puré de Patata y Ensalada de Lechuga','Lechuga',50,'g');

/* 6) Salmónete en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Salmónete en Salsa de Vino Blanco','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Salmónete en Salsa de Vino Blanco','Cebolla',1,'unidad');

/* 7) Salmónete Frito con Patatas */
CALL InsertarIngredienteEnReceta('Salmónete Frito con Patatas','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete Frito con Patatas','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Salmónete Frito con Patatas','Patata',1,'unidad');

/* 8) Salmónete con Salsa de Limón y Eneldo */
CALL InsertarIngredienteEnReceta('Salmónete con Salsa de Limón y Eneldo','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete con Salsa de Limón y Eneldo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmónete con Salsa de Limón y Eneldo','Eneldo',1,'cdita');

/* 9) Salmónete con Verduras al Horno */
CALL InsertarIngredienteEnReceta('Salmónete con Verduras al Horno','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete con Verduras al Horno','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmónete con Verduras al Horno','Pimiento',1,'unidad');

/* 10) Salmónete con Ensalada de Quinoa y Aguacate */
CALL InsertarIngredienteEnReceta('Salmónete con Ensalada de Quinoa y Aguacate','Salmónete',200,'g');
CALL InsertarIngredienteEnReceta('Salmónete con Ensalada de Quinoa y Aguacate','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Salmónete con Ensalada de Quinoa y Aguacate','Aguacate',1,'unidad');


/* ----- SALMÓN (10 recetas) ----- */

/* 1) Salmón a la Parrilla con Limón y Eneldo */
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Limón y Eneldo','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Limón y Eneldo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Limón y Eneldo','Eneldo',1,'cdita');

/* 2) Salmón al Horno con Miel y Mostaza */
CALL InsertarIngredienteEnReceta('Salmón al Horno con Miel y Mostaza','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón al Horno con Miel y Mostaza','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Salmón al Horno con Miel y Mostaza','Mostaza',1,'cda');

/* 3) Ensalada de Salmón Ahumado y Aguacate */
CALL InsertarIngredienteEnReceta('Ensalada de Salmón Ahumado y Aguacate','Salmón',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Salmón Ahumado y Aguacate','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Salmón Ahumado y Aguacate','Espinacas',50,'g');

/* 4) Salmón con Salsa de Limón y Alcaparras */
CALL InsertarIngredienteEnReceta('Salmón con Salsa de Limón y Alcaparras','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón con Salsa de Limón y Alcaparras','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmón con Salsa de Limón y Alcaparras','Alcaparras',1,'cda');

/* 5) Salmón con Puré de Patata y Espárragos */
CALL InsertarIngredienteEnReceta('Salmón con Puré de Patata y Espárragos','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón con Puré de Patata y Espárragos','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Salmón con Puré de Patata y Espárragos','Espárragos verdes',100,'g');

/* 6) Salmón en Salsa de Vino Blanco y Ajo */
CALL InsertarIngredienteEnReceta('Salmón en Salsa de Vino Blanco y Ajo','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón en Salsa de Vino Blanco y Ajo','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Salmón en Salsa de Vino Blanco y Ajo','Ajo',2,'diente');

/* 7) Salmón a la Parrilla con Ensalada de Quinoa */
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Ensalada de Quinoa','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Ensalada de Quinoa','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Salmón a la Parrilla con Ensalada de Quinoa','Tomate',1,'unidad');

/* 8) Salmón al Horno con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Salmón al Horno con Tomate y Albahaca','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón al Horno con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Salmón al Horno con Tomate y Albahaca','Albahaca',1,'cda');

/* 9) Salmón en Salsa Teriyaki */
CALL InsertarIngredienteEnReceta('Salmón en Salsa Teriyaki','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón en Salsa Teriyaki','Salsa de soja',2,'cda');
CALL InsertarIngredienteEnReceta('Salmón en Salsa Teriyaki','Miel',1,'cda');

/* 10) Salmón con Espinacas Salteadas y Almendras */
CALL InsertarIngredienteEnReceta('Salmón con Espinacas Salteadas y Almendras','Salmón',200,'g');
CALL InsertarIngredienteEnReceta('Salmón con Espinacas Salteadas y Almendras','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Salmón con Espinacas Salteadas y Almendras','Almendras',20,'g');


/* ----- RODABALLO (10 recetas) ----- */

/* 1) Rodaballo a la Parrilla con Limón y Ajo */
CALL InsertarIngredienteEnReceta('Rodaballo a la Parrilla con Limón y Ajo','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo a la Parrilla con Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo a la Parrilla con Limón y Ajo','Ajo',2,'diente');

/* 2) Rodaballo al Horno con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Tomate y Albahaca','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Tomate y Albahaca','Albahaca',1,'cda');

/* 3) Rodaballo en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Mostaza y Miel','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Mostaza y Miel','Miel',1,'cda');

/* 4) Rodaballo con Salsa de Vino Blanco y Ajo */
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Vino Blanco y Ajo','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Vino Blanco y Ajo','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Vino Blanco y Ajo','Ajo',2,'diente');

/* 5) Rodaballo a la Plancha con Espárragos */
CALL InsertarIngredienteEnReceta('Rodaballo a la Plancha con Espárragos','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo a la Plancha con Espárragos','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Rodaballo a la Plancha con Espárragos','Aceite de oliva',1,'cda');

/* 6) Rodaballo al Horno con Pimientos */
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Pimientos','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Pimientos','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Pimientos','Cebolla',1,'unidad');

/* 7) Rodaballo con Salsa de Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Ajo y Perejil','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Rodaballo con Salsa de Ajo y Perejil','Perejil',1,'cda');

/* 8) Rodaballo en Salsa de Piquillos */
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Piquillos','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Piquillos','Pimientos del piquillo',2,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo en Salsa de Piquillos','Cebolla',1,'unidad');

/* 9) Rodaballo con Ensalada de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Rodaballo con Ensalada de Tomate y Albahaca','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo con Ensalada de Tomate y Albahaca','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo con Ensalada de Tomate y Albahaca','Albahaca',1,'cda');

/* 10) Rodaballo al Horno con Limón y Romero */
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Limón y Romero','Rodaballo',200,'g');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Rodaballo al Horno con Limón y Romero','Romero',1,'cdita');


/* ----- PEZ ESPADA (10 recetas) ----- */

/* 1) Pez Espada a la Parrilla con Ajo y Limón */
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Ajo y Limón','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Ajo y Limón','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Ajo y Limón','Limón',1,'unidad');

/* 2) Pez Espada al Horno con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Pez Espada al Horno con Tomate y Albahaca','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada al Horno con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Pez Espada al Horno con Tomate y Albahaca','Albahaca',1,'cda');

/* 3) Pez Espada en Salsa de Naranja y Miel */
CALL InsertarIngredienteEnReceta('Pez Espada en Salsa de Naranja y Miel','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada en Salsa de Naranja y Miel','Naranja',2,'unidad');
CALL InsertarIngredienteEnReceta('Pez Espada en Salsa de Naranja y Miel','Miel',1,'cda');

/* 4) Pez Espada con Ensalada de Mango y Aguacate */
CALL InsertarIngredienteEnReceta('Pez Espada con Ensalada de Mango y Aguacate','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada con Ensalada de Mango y Aguacate','Mango',1,'unidad');
CALL InsertarIngredienteEnReceta('Pez Espada con Ensalada de Mango y Aguacate','Aguacate',1,'unidad');

/* 5) Pez Espada a la Plancha con Espárragos */
CALL InsertarIngredienteEnReceta('Pez Espada a la Plancha con Espárragos','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada a la Plancha con Espárragos','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Pez Espada a la Plancha con Espárragos','Aceite de oliva',1,'cda');

/* 6) Pez Espada con Salsa de Vino Blanco y Ajo */
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Vino Blanco y Ajo','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Vino Blanco y Ajo','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Vino Blanco y Ajo','Ajo',2,'diente');

/* 7) Pez Espada a la Parrilla con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Pimientos Asados','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Pez Espada a la Parrilla con Pimientos Asados','Aceite de oliva',1,'cda');

/* 8) Pez Espada con Salsa de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Tomate y Albahaca','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Tomate y Albahaca','Albahaca',1,'cda');

/* 9) Pez Espada con Verduras al Horno */
CALL InsertarIngredienteEnReceta('Pez Espada con Verduras al Horno','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada con Verduras al Horno','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Pez Espada con Verduras al Horno','Calabacín',100,'g');

/* 10) Pez Espada con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Mostaza y Miel','Pez Espada',200,'g');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Pez Espada con Salsa de Mostaza y Miel','Miel',1,'cda');


/* ----- PARGO (10 recetas) ----- */

/* 1) Pargo a la Parrilla con Ajo y Limón */
CALL InsertarIngredienteEnReceta('Pargo a la Parrilla con Ajo y Limón','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo a la Parrilla con Ajo y Limón','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Pargo a la Parrilla con Ajo y Limón','Limón',1,'unidad');

/* 2) Pargo al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Pargo al Horno con Hierbas','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Hierbas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Hierbas','Aceite de oliva',1,'cda');

/* 3) Pargo en Salsa de Naranja y Miel */
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Naranja y Miel','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Naranja y Miel','Naranja',2,'unidad');
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Naranja y Miel','Miel',1,'cda');

/* 4) Pargo a la Plancha con Ensalada de Tomate */
CALL InsertarIngredienteEnReceta('Pargo a la Plancha con Ensalada de Tomate','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo a la Plancha con Ensalada de Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Pargo a la Plancha con Ensalada de Tomate','Aceite de oliva',1,'cda');

/* 5) Pargo en Salsa de Vino Blanco y Ajo */
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Vino Blanco y Ajo','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Vino Blanco y Ajo','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Pargo en Salsa de Vino Blanco y Ajo','Ajo',2,'diente');

/* 6) Pargo al Horno con Papas y Cebolla */
CALL InsertarIngredienteEnReceta('Pargo al Horno con Papas y Cebolla','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Papas y Cebolla','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Papas y Cebolla','Cebolla',1,'unidad');

/* 7) Pargo con Salsa de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Pargo con Salsa de Tomate y Albahaca','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo con Salsa de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Pargo con Salsa de Tomate y Albahaca','Albahaca',1,'cda');

/* 8) Pargo al Grill con Espárragos */
CALL InsertarIngredienteEnReceta('Pargo al Grill con Espárragos','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo al Grill con Espárragos','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Pargo al Grill con Espárragos','Aceite de oliva',1,'cda');

/* 9) Pargo con Ensalada de Mango y Aguacate */
CALL InsertarIngredienteEnReceta('Pargo con Ensalada de Mango y Aguacate','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo con Ensalada de Mango y Aguacate','Mango',1,'unidad');
CALL InsertarIngredienteEnReceta('Pargo con Ensalada de Mango y Aguacate','Aguacate',1,'unidad');

/* 10) Pargo al Horno con Limón y Pimentón */
CALL InsertarIngredienteEnReceta('Pargo al Horno con Limón y Pimentón','Pargo',200,'g');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Limón y Pimentón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Pargo al Horno con Limón y Pimentón','Pimentón',1,'cdita');


/* ----- PALOMETA (10 recetas) ----- */

/* 1) Palometa a la Parrilla */
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla','Sal',1,'pizca');

/* 2) Palometa al Horno con Limón */
CALL InsertarIngredienteEnReceta('Palometa al Horno con Limón','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa al Horno con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Palometa al Horno con Limón','Ajo',2,'diente');

/* 3) Palometa con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Palometa con Salsa de Mostaza y Miel','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Palometa con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 4) Palometa a la Plancha con Tomate */
CALL InsertarIngredienteEnReceta('Palometa a la Plancha con Tomate','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa a la Plancha con Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Palometa a la Plancha con Tomate','Aceite de oliva',1,'cda');

/* 5) Palometa con Verduras al Vapor */
CALL InsertarIngredienteEnReceta('Palometa con Verduras al Vapor','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa con Verduras al Vapor','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Palometa con Verduras al Vapor','Calabacín',80,'g');

/* 6) Palometa en Salsa de Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Ajo y Perejil','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Ajo y Perejil','Perejil',1,'cda');

/* 7) Palometa al Horno con Papas */
CALL InsertarIngredienteEnReceta('Palometa al Horno con Papas','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa al Horno con Papas','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Palometa al Horno con Papas','Cebolla',1,'unidad');

/* 8) Palometa con Ensalada de Mango y Aguacate */
CALL InsertarIngredienteEnReceta('Palometa con Ensalada de Mango y Aguacate','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa con Ensalada de Mango y Aguacate','Mango',1,'unidad');
CALL InsertarIngredienteEnReceta('Palometa con Ensalada de Mango y Aguacate','Aguacate',1,'unidad');

/* 9) Palometa en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Vino Blanco','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Palometa en Salsa de Vino Blanco','Ajo',2,'diente');

/* 10) Palometa a la Parrilla con Ensalada de Arroz Integral */
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla con Ensalada de Arroz Integral','Palometa',200,'g');
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla con Ensalada de Arroz Integral','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Palometa a la Parrilla con Ensalada de Arroz Integral','Tomate',1,'unidad');


/* ----- MUJOL (10 recetas) ----- */

/* 1) Mujol a la Plancha */
CALL InsertarIngredienteEnReceta('Mujol a la Plancha','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Mujol a la Plancha','Sal',1,'pizca');

/* 2) Mujol en Salsa de Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Ajo y Perejil','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Ajo y Perejil','Perejil',1,'cda');

/* 3) Mujol al Horno con Limón */
CALL InsertarIngredienteEnReceta('Mujol al Horno con Limón','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol al Horno con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Mujol al Horno con Limón','Tomillo',1,'cdita');

/* 4) Mujol con Verduras al Vapor */
CALL InsertarIngredienteEnReceta('Mujol con Verduras al Vapor','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol con Verduras al Vapor','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Mujol con Verduras al Vapor','Calabacín',80,'g');

/* 5) Mujol con Arroz Integral */
CALL InsertarIngredienteEnReceta('Mujol con Arroz Integral','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol con Arroz Integral','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Mujol con Arroz Integral','Aceite de oliva',1,'cda');

/* 6) Mujol en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Mostaza y Miel','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Mostaza y Miel','Miel',1,'cda');

/* 7) Mujol al Horno con Papas */
CALL InsertarIngredienteEnReceta('Mujol al Horno con Papas','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol al Horno con Papas','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Mujol al Horno con Papas','Romero',1,'cdita');

/* 8) Mujol con Ensalada de Tomate y Pepino */
CALL InsertarIngredienteEnReceta('Mujol con Ensalada de Tomate y Pepino','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol con Ensalada de Tomate y Pepino','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Mujol con Ensalada de Tomate y Pepino','Pepino',1,'unidad');

/* 9) Mujol en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Vino Blanco','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Mujol en Salsa de Vino Blanco','Ajo',2,'diente');

/* 10) Mujol a la Parrilla con Especias */
CALL InsertarIngredienteEnReceta('Mujol a la Parrilla con Especias','Mujol',200,'g');
CALL InsertarIngredienteEnReceta('Mujol a la Parrilla con Especias','Pimentón',1,'cdita');
CALL InsertarIngredienteEnReceta('Mujol a la Parrilla con Especias','Pimienta negra',1,'pizca');


/* ----- MELVA (10 recetas) ----- */

/* 1) Melva a la Plancha */
CALL InsertarIngredienteEnReceta('Melva a la Plancha','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Melva a la Plancha','Sal',1,'pizca');

/* 2) Melva en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Melva en Salsa de Tomate','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Melva en Salsa de Tomate','Cebolla',1,'unidad');

/* 3) Melva a la Parrilla con Limón */
CALL InsertarIngredienteEnReceta('Melva a la Parrilla con Limón','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva a la Parrilla con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Melva a la Parrilla con Limón','Aceite de oliva',1,'cda');

/* 4) Melva en Escabeche */
CALL InsertarIngredienteEnReceta('Melva en Escabeche','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva en Escabeche','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Melva en Escabeche','Cebolla',1,'unidad');

/* 5) Melva con Arroz Integral */
CALL InsertarIngredienteEnReceta('Melva con Arroz Integral','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva con Arroz Integral','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Melva con Arroz Integral','Pimiento',1,'unidad');

/* 6) Melva con Verduras Salteadas */
CALL InsertarIngredienteEnReceta('Melva con Verduras Salteadas','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva con Verduras Salteadas','Calabacín',80,'g');
CALL InsertarIngredienteEnReceta('Melva con Verduras Salteadas','Pimiento',80,'g');

/* 7) Melva al Horno con Tomate y Ajo */
CALL InsertarIngredienteEnReceta('Melva al Horno con Tomate y Ajo','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva al Horno con Tomate y Ajo','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Melva al Horno con Tomate y Ajo','Ajo',2,'diente');

/* 8) Melva con Patatas a lo Pobre */
CALL InsertarIngredienteEnReceta('Melva con Patatas a lo Pobre','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva con Patatas a lo Pobre','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Melva con Patatas a lo Pobre','Pimiento',1,'unidad');

/* 9) Melva en Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Melva en Salsa de Mostaza','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva en Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Melva en Salsa de Mostaza','Miel',1,'cda');

/* 10) Melva con Ensalada de Quinoa */
CALL InsertarIngredienteEnReceta('Melva con Ensalada de Quinoa','Melva',200,'g');
CALL InsertarIngredienteEnReceta('Melva con Ensalada de Quinoa','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Melva con Ensalada de Quinoa','Pepino',1,'unidad');


/* ----- LAMPREA (10 recetas) ----- */

/* 1) Lamprea a la Parrilla */
CALL InsertarIngredienteEnReceta('Lamprea a la Parrilla','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea a la Parrilla','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Lamprea a la Parrilla','Limón',1,'unidad');

/* 2) Lamprea en Salsa de Vino Tinto */
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Vino Tinto','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Vino Tinto','Vino tinto',100,'ml');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Vino Tinto','Cebolla',1,'unidad');

/* 3) Lamprea a la Plancha con Ensalada Verde */
CALL InsertarIngredienteEnReceta('Lamprea a la Plancha con Ensalada Verde','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea a la Plancha con Ensalada Verde','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Lamprea a la Plancha con Ensalada Verde','Tomate',1,'unidad');

/* 4) Lamprea con Patatas al Horno */
CALL InsertarIngredienteEnReceta('Lamprea con Patatas al Horno','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea con Patatas al Horno','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Lamprea con Patatas al Horno','Tomillo',1,'cdita');

/* 5) Lamprea en Salsa de Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Ajo y Perejil','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Ajo y Perejil','Perejil',1,'cda');

/* 6) Lamprea a la Cerveza */
CALL InsertarIngredienteEnReceta('Lamprea a la Cerveza','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea a la Cerveza','Cerveza',100,'ml');
CALL InsertarIngredienteEnReceta('Lamprea a la Cerveza','Cebolla',1,'unidad');

/* 7) Lamprea con Verduras Salteadas */
CALL InsertarIngredienteEnReceta('Lamprea con Verduras Salteadas','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea con Verduras Salteadas','Calabacín',80,'g');
CALL InsertarIngredienteEnReceta('Lamprea con Verduras Salteadas','Pimiento',1,'unidad');

/* 8) Lamprea en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Mostaza y Miel','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Lamprea en Salsa de Mostaza y Miel','Miel',1,'cda');

/* 9) Lamprea con Arroz */
CALL InsertarIngredienteEnReceta('Lamprea con Arroz','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea con Arroz','Arroz',80,'g');
CALL InsertarIngredienteEnReceta('Lamprea con Arroz','Perejil',1,'cda');

/* 10) Lamprea en Escabeche */
CALL InsertarIngredienteEnReceta('Lamprea en Escabeche','Lamprea',200,'g');
CALL InsertarIngredienteEnReceta('Lamprea en Escabeche','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Lamprea en Escabeche','Cebolla',1,'unidad');


/* ----- JUREL (10 recetas) ----- */

/* 1) Jurel a la Parrilla */
CALL InsertarIngredienteEnReceta('Jurel a la Parrilla','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel a la Parrilla','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Jurel a la Parrilla','Especias',1,'cdita');

/* 2) Jurel al Horno con Ajo y Romero */
CALL InsertarIngredienteEnReceta('Jurel al Horno con Ajo y Romero','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel al Horno con Ajo y Romero','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Jurel al Horno con Ajo y Romero','Romero',1,'cdita');

/* 3) Jurel en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Mostaza y Miel','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Mostaza y Miel','Miel',1,'cda');

/* 4) Jurel a la Plancha con Ensalada de Tomate */
CALL InsertarIngredienteEnReceta('Jurel a la Plancha con Ensalada de Tomate','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel a la Plancha con Ensalada de Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Jurel a la Plancha con Ensalada de Tomate','Aceite de oliva',1,'cda');

/* 5) Jurel al Vapor con Limón */
CALL InsertarIngredienteEnReceta('Jurel al Vapor con Limón','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel al Vapor con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Jurel al Vapor con Limón','Sal',1,'pizca');

/* 6) Jurel en Salsa de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Tomate y Albahaca','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Tomate y Albahaca','Albahaca',1,'cda');

/* 7) Jurel con Verduras Salteadas */
CALL InsertarIngredienteEnReceta('Jurel con Verduras Salteadas','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel con Verduras Salteadas','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Jurel con Verduras Salteadas','Calabacín',80,'g');

/* 8) Jurel en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Vino Blanco','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Jurel en Salsa de Vino Blanco','Cebolla',1,'unidad');

/* 9) Jurel en Escabeche */
CALL InsertarIngredienteEnReceta('Jurel en Escabeche','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel en Escabeche','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Jurel en Escabeche','Zanahoria',1,'unidad');

/* 10) Jurel con Papas al Horno */
CALL InsertarIngredienteEnReceta('Jurel con Papas al Horno','Jurel',200,'g');
CALL InsertarIngredienteEnReceta('Jurel con Papas al Horno','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Jurel con Papas al Horno','Tomillo',1,'cdita');


/* ----- JAPUTA (10 recetas) ----- */

/* 1) Japuta a la Parrilla */
CALL InsertarIngredienteEnReceta('Japuta a la Parrilla','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta a la Parrilla','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Japuta a la Parrilla','Ajo',2,'diente');

/* 2) Japuta al Horno con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Japuta al Horno con Ajo y Perejil','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta al Horno con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Japuta al Horno con Ajo y Perejil','Perejil',1,'cda');

/* 3) Japuta en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Tomate','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Tomate','Cebolla',1,'unidad');

/* 4) Japuta con Pimientos y Cebolla */
CALL InsertarIngredienteEnReceta('Japuta con Pimientos y Cebolla','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta con Pimientos y Cebolla','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Japuta con Pimientos y Cebolla','Cebolla',1,'unidad');

/* 5) Japuta a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Japuta a la Plancha con Ensalada','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Japuta a la Plancha con Ensalada','Tomate',1,'unidad');

/* 6) Japuta en Salsa de Limón y Alcaparras */
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Limón y Alcaparras','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Limón y Alcaparras','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Japuta en Salsa de Limón y Alcaparras','Alcaparras',1,'cda');

/* 7) Japuta con Papas al Horno */
CALL InsertarIngredienteEnReceta('Japuta con Papas al Horno','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta con Papas al Horno','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Japuta con Papas al Horno','Romero',1,'cdita');

/* 8) Japuta en Salsa Verde */
CALL InsertarIngredienteEnReceta('Japuta en Salsa Verde','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta en Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Japuta en Salsa Verde','Ajo',2,'diente');

/* 9) Japuta con Verduras Asadas */
CALL InsertarIngredienteEnReceta('Japuta con Verduras Asadas','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta con Verduras Asadas','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Japuta con Verduras Asadas','Calabacín',80,'g');

/* 10) Japuta a la Sal */
CALL InsertarIngredienteEnReceta('Japuta a la Sal','Japuta',200,'g');
CALL InsertarIngredienteEnReceta('Japuta a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Japuta a la Sal','Limón',1,'unidad');


/* ----- EMPERADOR (10 recetas) ----- */

/* 1) Emperador a la Parrilla */
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla','Limón',1,'unidad');

/* 2) Emperador al Horno con Ajo */
CALL InsertarIngredienteEnReceta('Emperador al Horno con Ajo','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador al Horno con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Emperador al Horno con Ajo','Vino blanco',100,'ml');

/* 3) Emperador en Salsa de Limón */
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Limón','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Limón','Alcaparras',1,'cda');

/* 4) Emperador a la Plancha con Verduras */
CALL InsertarIngredienteEnReceta('Emperador a la Plancha con Verduras','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Plancha con Verduras','Calabacín',80,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Plancha con Verduras','Pimiento',80,'g');

/* 5) Emperador en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Tomate','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Tomate','Hierbas aromáticas',1,'cdita');

/* 6) Emperador con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Emperador con Salsa de Mostaza y Miel','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Emperador con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 7) Emperador a la Sal */
CALL InsertarIngredienteEnReceta('Emperador a la Sal','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Sal','Limón',1,'unidad');

/* 8) Emperador en Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Vino Blanco','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Emperador en Salsa de Vino Blanco','Ajo',2,'diente');

/* 9) Emperador a la Parrilla con Hierbas Aromáticas */
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla con Hierbas Aromáticas','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla con Hierbas Aromáticas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Emperador a la Parrilla con Hierbas Aromáticas','Aceite de oliva',1,'cda');

/* 10) Emperador con Pimientos y Tomate */
CALL InsertarIngredienteEnReceta('Emperador con Pimientos y Tomate','Emperador',200,'g');
CALL InsertarIngredienteEnReceta('Emperador con Pimientos y Tomate','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Emperador con Pimientos y Tomate','Tomate',1,'unidad');


/* ----- CONGRIO (10 recetas) ----- */

/* 1) Congrio a la Parrilla */
CALL InsertarIngredienteEnReceta('Congrio a la Parrilla','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Congrio a la Parrilla','Especias',1,'cdita');

/* 2) Congrio al Horno con Limón */
CALL InsertarIngredienteEnReceta('Congrio al Horno con Limón','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio al Horno con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Congrio al Horno con Limón','Tomillo',1,'cdita');

/* 3) Congrio en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Tomate','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Tomate','Cebolla',1,'unidad');

/* 4) Congrio a la Plancha con Ajo */
CALL InsertarIngredienteEnReceta('Congrio a la Plancha con Ajo','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio a la Plancha con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Congrio a la Plancha con Ajo','Aceite de oliva',1,'cda');

/* 5) Congrio en Salsa Verde */
CALL InsertarIngredienteEnReceta('Congrio en Salsa Verde','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio en Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Congrio en Salsa Verde','Vino blanco',100,'ml');

/* 6) Congrio a la Sal */
CALL InsertarIngredienteEnReceta('Congrio a la Sal','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Congrio a la Sal','Limón',1,'unidad');

/* 7) Congrio con Verduras al Vapor */
CALL InsertarIngredienteEnReceta('Congrio con Verduras al Vapor','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio con Verduras al Vapor','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Congrio con Verduras al Vapor','Brócoli',80,'g');

/* 8) Congrio en Brochetas */
CALL InsertarIngredienteEnReceta('Congrio en Brochetas','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio en Brochetas','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Congrio en Brochetas','Cebolla',1,'unidad');

/* 9) Congrio al Vapor con Ajo y Limón */
CALL InsertarIngredienteEnReceta('Congrio al Vapor con Ajo y Limón','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio al Vapor con Ajo y Limón','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Congrio al Vapor con Ajo y Limón','Limón',1,'unidad');

/* 10) Congrio en Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Mostaza','Congrio',200,'g');
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Congrio en Salsa de Mostaza','Vino blanco',100,'ml');


/* ----- CHOBA (10 recetas) ----- */

/* 1) Choba a la Plancha */
CALL InsertarIngredienteEnReceta('Choba a la Plancha','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba a la Plancha','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Choba a la Plancha','Aceite de oliva',1,'cda');

/* 2) Choba al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Choba al Horno con Hierbas','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba al Horno con Hierbas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Choba al Horno con Hierbas','Ajo',2,'diente');

/* 3) Choba en Salsa de Limón y Ajo */
CALL InsertarIngredienteEnReceta('Choba en Salsa de Limón y Ajo','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba en Salsa de Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Choba en Salsa de Limón y Ajo','Ajo',2,'diente');

/* 4) Choba a la Parrilla con Tomate */
CALL InsertarIngredienteEnReceta('Choba a la Parrilla con Tomate','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba a la Parrilla con Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Choba a la Parrilla con Tomate','Aceite de oliva',1,'cda');

/* 5) Choba en Salsa Verde */
CALL InsertarIngredienteEnReceta('Choba en Salsa Verde','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba en Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Choba en Salsa Verde','Vino blanco',100,'ml');

/* 6) Choba a la Sal */
CALL InsertarIngredienteEnReceta('Choba a la Sal','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Choba a la Sal','Limón',1,'unidad');

/* 7) Choba con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Choba con Pimientos Asados','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Choba con Pimientos Asados','Aceite de oliva',1,'cda');

/* 8) Choba al Vapor con Verduras */
CALL InsertarIngredienteEnReceta('Choba al Vapor con Verduras','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba al Vapor con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Choba al Vapor con Verduras','Calabacín',80,'g');

/* 9) Choba Frita con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Choba Frita con Ajo y Perejil','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba Frita con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Choba Frita con Ajo y Perejil','Perejil',1,'cda');

/* 10) Choba con Ensalada Fresca */
CALL InsertarIngredienteEnReceta('Choba con Ensalada Fresca','Choba',200,'g');
CALL InsertarIngredienteEnReceta('Choba con Ensalada Fresca','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Choba con Ensalada Fresca','Tomate',1,'unidad');


/* ----- CHICHARRO (10 recetas) ----- */

/* 1) Chicharro a la Plancha */
CALL InsertarIngredienteEnReceta('Chicharro a la Plancha','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Chicharro a la Plancha','Limón',1,'unidad');

/* 2) Chicharro al Horno con Ajo y Romero */
CALL InsertarIngredienteEnReceta('Chicharro al Horno con Ajo y Romero','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro al Horno con Ajo y Romero','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Chicharro al Horno con Ajo y Romero','Romero',1,'cdita');

/* 3) Chicharro en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Chicharro en Salsa de Tomate','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Chicharro en Salsa de Tomate','Cebolla',1,'unidad');

/* 4) Chicharro a la Parrilla */
CALL InsertarIngredienteEnReceta('Chicharro a la Parrilla','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Chicharro a la Parrilla','Limón',1,'unidad');

/* 5) Chicharro en Salsa Verde */
CALL InsertarIngredienteEnReceta('Chicharro en Salsa Verde','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro en Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Chicharro en Salsa Verde','Vino blanco',100,'ml');

/* 6) Chicharro a la Sal */
CALL InsertarIngredienteEnReceta('Chicharro a la Sal','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Chicharro a la Sal','Limón',1,'unidad');

/* 7) Chicharro con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Chicharro con Pimientos Asados','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Chicharro con Pimientos Asados','Aceite de oliva',1,'cda');

/* 8) Chicharro al Vapor con Verduras */
CALL InsertarIngredienteEnReceta('Chicharro al Vapor con Verduras','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro al Vapor con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Chicharro al Vapor con Verduras','Calabacín',80,'g');

/* 9) Chicharro Frito con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Chicharro Frito con Ajo y Perejil','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro Frito con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Chicharro Frito con Ajo y Perejil','Perejil',1,'cda');

/* 10) Chicharro con Ensalada de Tomate */
CALL InsertarIngredienteEnReceta('Chicharro con Ensalada de Tomate','Chicharro',200,'g');
CALL InsertarIngredienteEnReceta('Chicharro con Ensalada de Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Chicharro con Ensalada de Tomate','Aceite de oliva',1,'cda');


/* ----- CAZÓN (10 recetas) ----- */

/* 1) Cazón a la Plancha */
CALL InsertarIngredienteEnReceta('Cazón a la Plancha','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Cazón a la Plancha','Sal',1,'pizca');

/* 2) Cazón en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Cazón en Salsa de Tomate','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Cazón en Salsa de Tomate','Cebolla',1,'unidad');

/* 3) Cazón al Horno con Limón y Ajo */
CALL InsertarIngredienteEnReceta('Cazón al Horno con Limón y Ajo','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón al Horno con Limón y Ajo','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Cazón al Horno con Limón y Ajo','Ajo',2,'diente');

/* 4) Cazón en Adobo */
CALL InsertarIngredienteEnReceta('Cazón en Adobo','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón en Adobo','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Cazón en Adobo','Pimentón',1,'cdita');

/* 5) Cazón a la Parrilla con Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Cazón a la Parrilla con Aceite de Oliva','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Parrilla con Aceite de Oliva','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Cazón a la Parrilla con Aceite de Oliva','Sal',1,'pizca');

/* 6) Cazón a la Andaluza */
CALL InsertarIngredienteEnReceta('Cazón a la Andaluza','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Andaluza','Harina',50,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Andaluza','Aceite de oliva',1,'cda');

/* 7) Cazón en Salsa Verde */
CALL InsertarIngredienteEnReceta('Cazón en Salsa Verde','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón en Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Cazón en Salsa Verde','Ajo',2,'diente');

/* 8) Cazón con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Cazón con Pimientos Asados','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Cazón con Pimientos Asados','Aceite de oliva',1,'cda');

/* 9) Cazón a la Sal */
CALL InsertarIngredienteEnReceta('Cazón a la Sal','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Cazón a la Sal','Limón',1,'unidad');

/* 10) Cazón con Verduras al Vapor */
CALL InsertarIngredienteEnReceta('Cazón con Verduras al Vapor','Cazón',200,'g');
CALL InsertarIngredienteEnReceta('Cazón con Verduras al Vapor','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Cazón con Verduras al Vapor','Calabacín',80,'g');


/* ----- CARPA (10 recetas) ----- */

/* 1) Carpa a la Plancha */
CALL InsertarIngredienteEnReceta('Carpa a la Plancha','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Carpa a la Plancha','Limón',1,'unidad');

/* 2) Carpa al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Carpa al Horno con Hierbas','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa al Horno con Hierbas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Carpa al Horno con Hierbas','Ajo',2,'diente');

/* 3) Carpa en Salsa de Soja y Jengibre */
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Soja y Jengibre','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Soja y Jengibre','Salsa de soja',2,'cda');
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Soja y Jengibre','Jengibre',1,'cdita');

/* 4) Carpa a la Parrilla con Limón */
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Limón','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Limón','Aceite de oliva',1,'cda');

/* 5) Carpa al Vino Blanco */
CALL InsertarIngredienteEnReceta('Carpa al Vino Blanco','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa al Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Carpa al Vino Blanco','Ajo',2,'diente');

/* 6) Ensalada de Carpa con Verduras */
CALL InsertarIngredienteEnReceta('Ensalada de Carpa con Verduras','Carpa',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Carpa con Verduras','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Carpa con Verduras','Pepino',1,'unidad');

/* 7) Carpa a la Mostaza */
CALL InsertarIngredienteEnReceta('Carpa a la Mostaza','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa a la Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Carpa a la Mostaza','Cebolla',1,'unidad');

/* 8) Carpa en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Tomate','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Carpa en Salsa de Tomate','Hierbas aromáticas',1,'cda');

/* 9) Carpa a la Parrilla con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Ajo y Perejil','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Carpa a la Parrilla con Ajo y Perejil','Perejil',1,'cda');

/* 10) Carpa al Curry */
CALL InsertarIngredienteEnReceta('Carpa al Curry','Carpa',200,'g');
CALL InsertarIngredienteEnReceta('Carpa al Curry','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Carpa al Curry','Cebolla',1,'unidad');


/* ----- CABALLA (10 recetas) ----- */

/* 1) Caballa a la Plancha */
CALL InsertarIngredienteEnReceta('Caballa a la Plancha','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Caballa a la Plancha','Limón',1,'unidad');

/* 2) Caballa en Salsa Verde */
CALL InsertarIngredienteEnReceta('Caballa en Salsa Verde','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa en Salsa Verde','Salsa verde',1,'cda');
CALL InsertarIngredienteEnReceta('Caballa en Salsa Verde','Perejil',1,'cda');

/* 3) Caballa al Horno con Limón */
CALL InsertarIngredienteEnReceta('Caballa al Horno con Limón','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa al Horno con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Caballa al Horno con Limón','Orégano',1,'cdita');

/* 4) Caballa en Escabeche */
CALL InsertarIngredienteEnReceta('Caballa en Escabeche','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa en Escabeche','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Caballa en Escabeche','Cebolla',1,'unidad');

/* 5) Caballa a la Parrilla */
CALL InsertarIngredienteEnReceta('Caballa a la Parrilla','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Caballa a la Parrilla','Ajo',2,'diente');

/* 6) Ensalada de Caballa con Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Caballa con Tomate','Caballa',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Caballa con Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Caballa con Tomate','Aceite de oliva',1,'cda');

/* 7) Caballa a la Mostaza */
CALL InsertarIngredienteEnReceta('Caballa a la Mostaza','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa a la Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Caballa a la Mostaza','Sal',1,'pizca');

/* 8) Caballa a la Miel */
CALL InsertarIngredienteEnReceta('Caballa a la Miel','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa a la Miel','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Caballa a la Miel','Pimienta negra',1,'pizca');

/* 9) Caballa al Vino Blanco */
CALL InsertarIngredienteEnReceta('Caballa al Vino Blanco','Caballa',200,'g');
CALL InsertarIngredienteEnReceta('Caballa al Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Caballa al Vino Blanco','Ajo',2,'diente');

/* 10) Caballa en Tartar */
CALL InsertarIngredienteEnReceta('Caballa en Tartar','Caballa',100,'g');
CALL InsertarIngredienteEnReceta('Caballa en Tartar','Cebolla',1,'unidad');
CALL InsertarIngredienteEnReceta('Caballa en Tartar','Limón',1,'unidad');


/* ----- BOQUERONES (10 recetas) ----- */

/* 1) Boquerones en Vinagre */
CALL InsertarIngredienteEnReceta('Boquerones en Vinagre','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones en Vinagre','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Boquerones en Vinagre','Ajo',2,'diente');

/* 2) Boquerones a la Plancha */
CALL InsertarIngredienteEnReceta('Boquerones a la Plancha','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Boquerones a la Plancha','Limón',1,'unidad');

/* 3) Boquerones Fritos */
CALL InsertarIngredienteEnReceta('Boquerones Fritos','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones Fritos','Harina',50,'g');
CALL InsertarIngredienteEnReceta('Boquerones Fritos','Aceite de oliva',1,'cda');

/* 4) Boquerones al Horno con Ajo */
CALL InsertarIngredienteEnReceta('Boquerones al Horno con Ajo','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones al Horno con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Boquerones al Horno con Ajo','Perejil',1,'cda');

/* 5) Boquerones en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Boquerones en Salsa de Tomate','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Boquerones en Salsa de Tomate','Sal',1,'pizca');

/* 6) Boquerones con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Boquerones con Pimientos Asados','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Boquerones con Pimientos Asados','Aceite de oliva',1,'cda');

/* 7) Boquerones a la Andaluza */
CALL InsertarIngredienteEnReceta('Boquerones a la Andaluza','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones a la Andaluza','Harina',50,'g');
CALL InsertarIngredienteEnReceta('Boquerones a la Andaluza','Aceite de oliva',1,'cda');

/* 8) Boquerones con Ensalada de Tomate */
CALL InsertarIngredienteEnReceta('Boquerones con Ensalada de Tomate','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones con Ensalada de Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Boquerones con Ensalada de Tomate','Cebolla',1,'unidad');

/* 9) Boquerones en Aceite */
CALL InsertarIngredienteEnReceta('Boquerones en Aceite','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones en Aceite','Aceite de oliva',3,'cda');
CALL InsertarIngredienteEnReceta('Boquerones en Aceite','Ajo',2,'diente');

/* 10) Boquerones al Vinagre de Jerez */
CALL InsertarIngredienteEnReceta('Boquerones al Vinagre de Jerez','Boquerones',200,'g');
CALL InsertarIngredienteEnReceta('Boquerones al Vinagre de Jerez','Vinagre de Jerez',50,'ml');
CALL InsertarIngredienteEnReceta('Boquerones al Vinagre de Jerez','Ajo',2,'diente');


/* ----- BESUGO (10 recetas) ----- */

/* 1) Besugo al Horno con Limón y Romero */
CALL InsertarIngredienteEnReceta('Besugo al Horno con Limón y Romero','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo al Horno con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Besugo al Horno con Limón y Romero','Romero',1,'cdita');

/* 2) Besugo a la Parrilla con Ajo y Perejil */
CALL InsertarIngredienteEnReceta('Besugo a la Parrilla con Ajo y Perejil','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo a la Parrilla con Ajo y Perejil','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Besugo a la Parrilla con Ajo y Perejil','Perejil',1,'cda');

/* 3) Besugo a la Sal */
CALL InsertarIngredienteEnReceta('Besugo a la Sal','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo a la Sal','Sal',300,'g');
CALL InsertarIngredienteEnReceta('Besugo a la Sal','Limón',1,'unidad');

/* 4) Besugo con Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Mostaza y Miel','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Mostaza y Miel','Miel',1,'cda');

/* 5) Besugo al Vapor con Verduras */
CALL InsertarIngredienteEnReceta('Besugo al Vapor con Verduras','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo al Vapor con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Besugo al Vapor con Verduras','Cebolla',1,'unidad');

/* 6) Besugo con Salsa de Vino Blanco */
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Vino Blanco','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Vino Blanco','Vino blanco',100,'ml');
CALL InsertarIngredienteEnReceta('Besugo con Salsa de Vino Blanco','Cebolla',1,'unidad');

/* 7) Besugo a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Besugo a la Plancha con Ensalada','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Besugo a la Plancha con Ensalada','Tomate',1,'unidad');

/* 8) Besugo con Salsa Verde */
CALL InsertarIngredienteEnReceta('Besugo con Salsa Verde','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo con Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Besugo con Salsa Verde','Ajo',2,'diente');

/* 9) Besugo al Horno con Pimientos */
CALL InsertarIngredienteEnReceta('Besugo al Horno con Pimientos','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo al Horno con Pimientos','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Besugo al Horno con Pimientos','Cebolla',1,'unidad');

/* 10) Besugo con Tomates Cherry */
CALL InsertarIngredienteEnReceta('Besugo con Tomates Cherry','Besugo',200,'g');
CALL InsertarIngredienteEnReceta('Besugo con Tomates Cherry','Tomates cherry',100,'g');
CALL InsertarIngredienteEnReceta('Besugo con Tomates Cherry','Aceite de oliva',1,'cda');


/* ----- ATÚN (10 recetas) ----- */

/* 1) Ensalada de Atún y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Atún y Garbanzos','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Atún y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Atún y Garbanzos','Cebolla',1,'unidad');

/* 2) Atún a la Parrilla con Limón */
CALL InsertarIngredienteEnReceta('Atún a la Parrilla con Limón','Atún',200,'g');
CALL InsertarIngredienteEnReceta('Atún a la Parrilla con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Atún a la Parrilla con Limón','Aceite de oliva',1,'cda');

/* 3) Tartar de Atún */
CALL InsertarIngredienteEnReceta('Tartar de Atún','Atún',100,'g');
CALL InsertarIngredienteEnReceta('Tartar de Atún','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Tartar de Atún','Salsa de soja',1,'cda');

/* 4) Atún al Horno con Verduras */
CALL InsertarIngredienteEnReceta('Atún al Horno con Verduras','Atún',200,'g');
CALL InsertarIngredienteEnReceta('Atún al Horno con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Atún al Horno con Verduras','Cebolla',1,'unidad');

/* 5) Ensalada de Atún con Pimientos */
CALL InsertarIngredienteEnReceta('Ensalada de Atún con Pimientos','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Atún con Pimientos','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Atún con Pimientos','Cebolla',1,'unidad');

/* 6) Atún con Salsa de Soja y Sésamo */
CALL InsertarIngredienteEnReceta('Atún con Salsa de Soja y Sésamo','Atún',200,'g');
CALL InsertarIngredienteEnReceta('Atún con Salsa de Soja y Sésamo','Salsa de soja',2,'cda');
CALL InsertarIngredienteEnReceta('Atún con Salsa de Soja y Sésamo','Semillas de sésamo',1,'cda');

/* 7) Croquetas de Atún */
CALL InsertarIngredienteEnReceta('Croquetas de Atún','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Atún','Bechamel',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Atún','Pan rallado',50,'g');

/* 8) Atún a la Plancha con Ensalada */
CALL InsertarIngredienteEnReceta('Atún a la Plancha con Ensalada','Atún',200,'g');
CALL InsertarIngredienteEnReceta('Atún a la Plancha con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Atún a la Plancha con Ensalada','Tomate',1,'unidad');

/* 9) Sopa de Atún */
CALL InsertarIngredienteEnReceta('Sopa de Atún','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Atún','Caldo de pescado',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Atún','Zanahoria',1,'unidad');

/* 10) Pizza de Atún */
CALL InsertarIngredienteEnReceta('Pizza de Atún','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Atún','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Pizza de Atún','Tomate',2,'unidad');


/* ----- ARENQUE (10 recetas) ----- */

/* 1) Arenque Ahumado con Ensalada */
CALL InsertarIngredienteEnReceta('Arenque Ahumado con Ensalada','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Arenque Ahumado con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Arenque Ahumado con Ensalada','Cebolla',1,'unidad');

/* 2) Arenque en Escabeche */
CALL InsertarIngredienteEnReceta('Arenque en Escabeche','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Arenque en Escabeche','Vinagre',50,'ml');
CALL InsertarIngredienteEnReceta('Arenque en Escabeche','Especias',1,'cdita');

/* 3) Arenque a la Parrilla */
CALL InsertarIngredienteEnReceta('Arenque a la Parrilla','Arenque',200,'g');
CALL InsertarIngredienteEnReceta('Arenque a la Parrilla','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Arenque a la Parrilla','Ajo',2,'diente');

/* 4) Ensalada de Arenque y Patata */
CALL InsertarIngredienteEnReceta('Ensalada de Arenque y Patata','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Arenque y Patata','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Arenque y Patata','Mayonesa',1,'cda');

/* 5) Arenque al Horno con Verduras */
CALL InsertarIngredienteEnReceta('Arenque al Horno con Verduras','Arenque',200,'g');
CALL InsertarIngredienteEnReceta('Arenque al Horno con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Arenque al Horno con Verduras','Cebolla',1,'unidad');

/* 6) Tartar de Arenque */
CALL InsertarIngredienteEnReceta('Tartar de Arenque','Arenque',100,'g');
CALL InsertarIngredienteEnReceta('Tartar de Arenque','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Tartar de Arenque','Pepinillos',30,'g');

/* 7) Arenque con Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Arenque con Salsa de Mostaza','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Arenque con Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Arenque con Salsa de Mostaza','Miel',1,'cda');

/* 8) Arenque con Pan de Centeno */
CALL InsertarIngredienteEnReceta('Arenque con Pan de Centeno','Arenque',100,'g');
CALL InsertarIngredienteEnReceta('Arenque con Pan de Centeno','Pan de centeno',2,'rebanada');
CALL InsertarIngredienteEnReceta('Arenque con Pan de Centeno','Cebolla morada',1,'unidad');

/* 9) Sopa de Arenque */
CALL InsertarIngredienteEnReceta('Sopa de Arenque','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Arenque','Caldo de pescado',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Arenque','Patata',1,'unidad');

/* 10) Arenque con Huevo Cocido */
CALL InsertarIngredienteEnReceta('Arenque con Huevo Cocido','Arenque',150,'g');
CALL InsertarIngredienteEnReceta('Arenque con Huevo Cocido','Huevo',1,'unidad');
CALL InsertarIngredienteEnReceta('Arenque con Huevo Cocido','Pepino',1,'unidad');


/* ----- ANGULA (10 recetas) ----- */

/* 1) Angula a la Plancha */
CALL InsertarIngredienteEnReceta('Angula a la Plancha','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula a la Plancha','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Angula a la Plancha','Aceite de oliva',1,'cda');

/* 2) Tartar de Angula */
CALL InsertarIngredienteEnReceta('Tartar de Angula','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Tartar de Angula','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Tartar de Angula','Cebolla morada',1,'unidad');

/* 3) Angula a la Sidra */
CALL InsertarIngredienteEnReceta('Angula a la Sidra','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula a la Sidra','Sidra',100,'ml');
CALL InsertarIngredienteEnReceta('Angula a la Sidra','Ajo',2,'diente');

/* 4) Ensalada de Angula y Piquillos */
CALL InsertarIngredienteEnReceta('Ensalada de Angula y Piquillos','Angula',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Angula y Piquillos','Pimientos del piquillo',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Angula y Piquillos','Lechuga',30,'g');

/* 5) Angula con Huevos Rotos */
CALL InsertarIngredienteEnReceta('Angula con Huevos Rotos','Angula',80,'g');
CALL InsertarIngredienteEnReceta('Angula con Huevos Rotos','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Angula con Huevos Rotos','Patata',1,'unidad');

/* 6) Angula a la Plancha con Limón */
CALL InsertarIngredienteEnReceta('Angula a la Plancha con Limón','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula a la Plancha con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Angula a la Plancha con Limón','Aceite de oliva',1,'cda');

/* 7) Angula con Piquillos y Jamón */
CALL InsertarIngredienteEnReceta('Angula con Piquillos y Jamón','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula con Piquillos y Jamón','Pimientos del piquillo',2,'unidad');
CALL InsertarIngredienteEnReceta('Angula con Piquillos y Jamón','Jamón serrano',30,'g');

/* 8) Angula al Ajillo */
CALL InsertarIngredienteEnReceta('Angula al Ajillo','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula al Ajillo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Angula al Ajillo','Guindilla',1,'unidad');

/* 9) Angula con Arroz Integral */
CALL InsertarIngredienteEnReceta('Angula con Arroz Integral','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula con Arroz Integral','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Angula con Arroz Integral','Zanahoria',1,'unidad');

/* 10) Angula a la Vinagreta */
CALL InsertarIngredienteEnReceta('Angula a la Vinagreta','Angula',100,'g');
CALL InsertarIngredienteEnReceta('Angula a la Vinagreta','Vinagre',20,'ml');
CALL InsertarIngredienteEnReceta('Angula a la Vinagreta','Mostaza',1,'cda');


/* ----- ANGUILA (10 recetas) ----- */

/* 1) Anguila a la Parrilla */
CALL InsertarIngredienteEnReceta('Anguila a la Parrilla','Anguila',200,'g');
CALL InsertarIngredienteEnReceta('Anguila a la Parrilla','Sal',1,'pizca');
CALL InsertarIngredienteEnReceta('Anguila a la Parrilla','Pimienta negra',1,'pizca');

/* 2) Sushi de Anguila */
CALL InsertarIngredienteEnReceta('Sushi de Anguila','Anguila',100,'g');
CALL InsertarIngredienteEnReceta('Sushi de Anguila','Arroz para sushi',80,'g');
CALL InsertarIngredienteEnReceta('Sushi de Anguila','Alga nori',1,'hoja');

/* 3) Anguila Ahumada con Ensalada */
CALL InsertarIngredienteEnReceta('Anguila Ahumada con Ensalada','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Anguila Ahumada con Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Anguila Ahumada con Ensalada','Aceite de oliva',1,'cda');

/* 4) Anguila al Horno con Limón y Romero */
CALL InsertarIngredienteEnReceta('Anguila al Horno con Limón y Romero','Anguila',200,'g');
CALL InsertarIngredienteEnReceta('Anguila al Horno con Limón y Romero','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Anguila al Horno con Limón y Romero','Romero',1,'cdita');

/* 5) Anguila a la Salsa Teriyaki */
CALL InsertarIngredienteEnReceta('Anguila a la Salsa Teriyaki','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Anguila a la Salsa Teriyaki','Salsa de soja',2,'cda');
CALL InsertarIngredienteEnReceta('Anguila a la Salsa Teriyaki','Miel',1,'cda');

/* 6) Brochetas de Anguila y Verduras */
CALL InsertarIngredienteEnReceta('Brochetas de Anguila y Verduras','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Anguila y Verduras','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Brochetas de Anguila y Verduras','Cebolla',1,'unidad');

/* 7) Anguila en Salsa de Mostaza y Miel */
CALL InsertarIngredienteEnReceta('Anguila en Salsa de Mostaza y Miel','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Anguila en Salsa de Mostaza y Miel','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Anguila en Salsa de Mostaza y Miel','Miel',1,'cda');

/* 8) Anguila al Curry */
CALL InsertarIngredienteEnReceta('Anguila al Curry','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Anguila al Curry','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Anguila al Curry','Leche de coco',100,'ml');

/* 9) Anguila con Verduras al Vapor */
CALL InsertarIngredienteEnReceta('Anguila con Verduras al Vapor','Anguila',150,'g');
CALL InsertarIngredienteEnReceta('Anguila con Verduras al Vapor','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Anguila con Verduras al Vapor','Brócoli',80,'g');

/* 10) Ensalada de Anguila y Mango */
CALL InsertarIngredienteEnReceta('Ensalada de Anguila y Mango','Anguila',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Anguila y Mango','Mango',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Anguila y Mango','Cebolla morada',1,'unidad');


/* ----- ANCHOAS (10 recetas) ----- */

/* 1) Ensalada de Anchoas y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Tomate','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Tomate','Aceite de oliva',1,'cda');

/* 2) Pizza de Anchoas */
CALL InsertarIngredienteEnReceta('Pizza de Anchoas','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Anchoas','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Anchoas','Tomate',2,'unidad');

/* 3) Pasta con Anchoas y Ajo */
CALL InsertarIngredienteEnReceta('Pasta con Anchoas y Ajo','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta con Anchoas y Ajo','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Pasta con Anchoas y Ajo','Ajo',2,'diente');

/* 4) Ensalada de Anchoas y Judías Verdes */
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Judías Verdes','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Judías Verdes','Judías verdes',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Anchoas y Judías Verdes','Tomate',1,'unidad');

/* 5) Tostadas de Pan con Anchoas */
CALL InsertarIngredienteEnReceta('Tostadas de Pan con Anchoas','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Tostadas de Pan con Anchoas','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Tostadas de Pan con Anchoas','Tomate',1,'unidad');

/* 6) Anchoas con Pimientos Asados */
CALL InsertarIngredienteEnReceta('Anchoas con Pimientos Asados','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Anchoas con Pimientos Asados','Pimientos asados',100,'g');
CALL InsertarIngredienteEnReceta('Anchoas con Pimientos Asados','Aceite de oliva',1,'cda');

/* 7) Pizza de Anchoas y Aceitunas */
CALL InsertarIngredienteEnReceta('Pizza de Anchoas y Aceitunas','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Anchoas y Aceitunas','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Anchoas y Aceitunas','Aceitunas',20,'g');

/* 8) Revuelto de Huevo con Anchoas */
CALL InsertarIngredienteEnReceta('Revuelto de Huevo con Anchoas','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Huevo con Anchoas','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Huevo con Anchoas','Cebolla',1,'unidad');

/* 9) Espárragos con Anchoas */
CALL InsertarIngredienteEnReceta('Espárragos con Anchoas','Espárragos verdes',100,'g');
CALL InsertarIngredienteEnReceta('Espárragos con Anchoas','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Espárragos con Anchoas','Aceite de oliva',1,'cda');

/* 10) Anchoas a la Salsa Verde */
CALL InsertarIngredienteEnReceta('Anchoas a la Salsa Verde','Anchoas',50,'g');
CALL InsertarIngredienteEnReceta('Anchoas a la Salsa Verde','Perejil',1,'cda');
CALL InsertarIngredienteEnReceta('Anchoas a la Salsa Verde','Ajo',1,'diente');


/* =======================================================
   LLAMADAS A InsertarIngredienteEnReceta para recetas de VERDURAS 
   (categoria_id = 8)
   ======================================================= */

/* 1) Ensalada de Pimientos Asados */
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos Asados','Pimientos asados',200,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos Asados','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos Asados','Sal',1,'pizca');

/* 2) Fajitas de Pollo y Pimientos */
CALL InsertarIngredienteEnReceta('Fajitas de Pollo y Pimientos','Pollo',150,'g');
CALL InsertarIngredienteEnReceta('Fajitas de Pollo y Pimientos','Pimientos',100,'g');
CALL InsertarIngredienteEnReceta('Fajitas de Pollo y Pimientos','Tortillas de trigo',2,'unidad');

/* 3) Pimientos Rellenos de Quinoa y Verduras */
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Quinoa y Verduras','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Quinoa y Verduras','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Quinoa y Verduras','Calabacín',50,'g');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Quinoa y Verduras','Zanahoria',1,'unidad');

/* 4) Pimientos Rellenos de Atún y Arroz Integral */
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Atún y Arroz Integral','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Atún y Arroz Integral','Atún',100,'g');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Atún y Arroz Integral','Arroz integral',80,'g');

/* 5) Salteado de Pimientos con Tofu */
CALL InsertarIngredienteEnReceta('Salteado de Pimientos con Tofu','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Salteado de Pimientos con Tofu','Tofu',150,'g');
CALL InsertarIngredienteEnReceta('Salteado de Pimientos con Tofu','Salsa de soja',1,'cda');

/* 6) Pimientos al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Pimientos al Horno con Hierbas','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos al Horno con Hierbas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Pimientos al Horno con Hierbas','Aceite de oliva',1,'cda');

/* 7) Ensalada de Pimientos y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos y Garbanzos','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pimientos y Garbanzos','Cebolla',1,'unidad');

/* 8) Revuelto de Pimientos y Huevos */
CALL InsertarIngredienteEnReceta('Revuelto de Pimientos y Huevos','Pimientos',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Pimientos y Huevos','Huevos',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Pimientos y Huevos','Aceite de oliva',1,'cda');

/* 9) Pimientos y Calabacín Salteados con Ajo */
CALL InsertarIngredienteEnReceta('Pimientos y Calabacín Salteados con Ajo','Pimientos',1,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos y Calabacín Salteados con Ajo','Calabacín',1,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos y Calabacín Salteados con Ajo','Ajo',2,'diente');

/* 10) Pimientos Asados con Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Pimientos Asados con Aceite de Oliva','Pimientos asados',200,'g');
CALL InsertarIngredienteEnReceta('Pimientos Asados con Aceite de Oliva','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Pimientos Asados con Aceite de Oliva','Sal',1,'pizca');

/* 11) Puré de Patatas Saludable */
CALL InsertarIngredienteEnReceta('Puré de Patatas Saludable','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Puré de Patatas Saludable','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Puré de Patatas Saludable','Sal',1,'pizca');

/* 12) Patatas Asadas con Romero */
CALL InsertarIngredienteEnReceta('Patatas Asadas con Romero','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas Asadas con Romero','Romero',1,'cdita');
CALL InsertarIngredienteEnReceta('Patatas Asadas con Romero','Aceite de oliva',1,'cda');

/* 13) Patatas al Vapor con Perejil */
CALL InsertarIngredienteEnReceta('Patatas al Vapor con Perejil','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas al Vapor con Perejil','Perejil',1,'cda');

/* 14) Patatas Rellenas de Verduras */
CALL InsertarIngredienteEnReceta('Patatas Rellenas de Verduras','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas Rellenas de Verduras','Pimientos',1,'unidad');
CALL InsertarIngredienteEnReceta('Patatas Rellenas de Verduras','Zanahoria',1,'unidad');

/* 15) Ensalada de Patatas y Judías Verdes */
CALL InsertarIngredienteEnReceta('Ensalada de Patatas y Judías Verdes','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Patatas y Judías Verdes','Judías verdes',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Patatas y Judías Verdes','Aceite de oliva',1,'cda');

/* 16) Tortilla de Patatas Saludable */
CALL InsertarIngredienteEnReceta('Tortilla de Patatas Saludable','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Patatas Saludable','Huevo',3,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Patatas Saludable','Aceite de oliva',1,'cda');

/* 17) Patatas al Horno con Pimientos */
CALL InsertarIngredienteEnReceta('Patatas al Horno con Pimientos','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas al Horno con Pimientos','Pimientos',1,'unidad');
CALL InsertarIngredienteEnReceta('Patatas al Horno con Pimientos','Aceite de oliva',1,'cda');

/* 18) Patatas a la Provenzal */
CALL InsertarIngredienteEnReceta('Patatas a la Provenzal','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas a la Provenzal','Orégano',1,'cdita');
CALL InsertarIngredienteEnReceta('Patatas a la Provenzal','Aceite de oliva',1,'cda');

/* 19) Guiso de Patatas y Espinacas */
CALL InsertarIngredienteEnReceta('Guiso de Patatas y Espinacas','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Guiso de Patatas y Espinacas','Espinacas',80,'g');
CALL InsertarIngredienteEnReceta('Guiso de Patatas y Espinacas','Tomate',1,'unidad');

/* 20) Patatas Salteadas con Champiñones */
CALL InsertarIngredienteEnReceta('Patatas Salteadas con Champiñones','Patata',2,'unidad');
CALL InsertarIngredienteEnReceta('Patatas Salteadas con Champiñones','Champiñones',80,'g');
CALL InsertarIngredienteEnReceta('Patatas Salteadas con Champiñones','Ajo',2,'diente');

/* 21) Puré de Zanahorias Saludable */
CALL InsertarIngredienteEnReceta('Puré de Zanahorias Saludable','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Puré de Zanahorias Saludable','Aceite de oliva',1,'cda');

/* 22) Zanahorias Asadas con Miel y Tomillo */
CALL InsertarIngredienteEnReceta('Zanahorias Asadas con Miel y Tomillo','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias Asadas con Miel y Tomillo','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Zanahorias Asadas con Miel y Tomillo','Tomillo',1,'cdita');

/* 23) Ensalada de Zanahorias y Manzana */
CALL InsertarIngredienteEnReceta('Ensalada de Zanahorias y Manzana','Zanahoria',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Zanahorias y Manzana','Manzana',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Zanahorias y Manzana','Aceite de oliva',1,'cda');

/* 24) Zanahorias al Vapor con Especias */
CALL InsertarIngredienteEnReceta('Zanahorias al Vapor con Especias','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias al Vapor con Especias','Cúrcuma',1,'pizca');
CALL InsertarIngredienteEnReceta('Zanahorias al Vapor con Especias','Pimienta',1,'pizca');

/* 25) Zanahorias Ralladas con Limón y Perejil */
CALL InsertarIngredienteEnReceta('Zanahorias Ralladas con Limón y Perejil','Zanahoria',2,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias Ralladas con Limón y Perejil','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias Ralladas con Limón y Perejil','Perejil',1,'cda');

/* 26) Sopa de Zanahoria y Jengibre */
CALL InsertarIngredienteEnReceta('Sopa de Zanahoria y Jengibre','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Zanahoria y Jengibre','Jengibre',1,'cdita');
CALL InsertarIngredienteEnReceta('Sopa de Zanahoria y Jengibre','Caldo de verduras',500,'ml');

/* 27) Zanahorias Glaseadas con Sésamo */
CALL InsertarIngredienteEnReceta('Zanahorias Glaseadas con Sésamo','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias Glaseadas con Sésamo','Aceite de sésamo',1,'cda');
CALL InsertarIngredienteEnReceta('Zanahorias Glaseadas con Sésamo','Semillas de sésamo',1,'cda');

/* 28) Revuelto de Zanahoria y Espinacas */
CALL InsertarIngredienteEnReceta('Revuelto de Zanahoria y Espinacas','Zanahoria',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Zanahoria y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Zanahoria y Espinacas','Huevo',2,'unidad');

/* 29) Zanahorias al Horno con Comino */
CALL InsertarIngredienteEnReceta('Zanahorias al Horno con Comino','Zanahoria',3,'unidad');
CALL InsertarIngredienteEnReceta('Zanahorias al Horno con Comino','Comino',1,'cdita');
CALL InsertarIngredienteEnReceta('Zanahorias al Horno con Comino','Aceite de oliva',1,'cda');

/* 30) Batido de Zanahoria y Naranja */
CALL InsertarIngredienteEnReceta('Batido de Zanahoria y Naranja','Zanahoria',2,'unidad');
CALL InsertarIngredienteEnReceta('Batido de Zanahoria y Naranja','Naranja',1,'unidad');
CALL InsertarIngredienteEnReceta('Batido de Zanahoria y Naranja','Agua',200,'ml');

/* 31) Judías Verdes al Vapor con Limón */
CALL InsertarIngredienteEnReceta('Judías Verdes al Vapor con Limón','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes al Vapor con Limón','Limón',1,'unidad');

/* 32) Ensalada de Judías Verdes y Tomate Cherry */
CALL InsertarIngredienteEnReceta('Ensalada de Judías Verdes y Tomate Cherry','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Judías Verdes y Tomate Cherry','Tomates cherry',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Judías Verdes y Tomate Cherry','Aceite de oliva',1,'cda');

/* 33) Judías Verdes Salteadas con Ajo */
CALL InsertarIngredienteEnReceta('Judías Verdes Salteadas con Ajo','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes Salteadas con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Judías Verdes Salteadas con Ajo','Aceite de oliva',1,'cda');

/* 34) Judías Verdes con Jamón Serrano */
CALL InsertarIngredienteEnReceta('Judías Verdes con Jamón Serrano','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes con Jamón Serrano','Jamón serrano',50,'g');

/* 35) Judías Verdes al Horno con Queso Parmesano */
CALL InsertarIngredienteEnReceta('Judías Verdes al Horno con Queso Parmesano','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes al Horno con Queso Parmesano','Queso parmesano',40,'g');

/* 36) Guiso de Judías Verdes y Patatas */
CALL InsertarIngredienteEnReceta('Guiso de Judías Verdes y Patatas','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Guiso de Judías Verdes y Patatas','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Guiso de Judías Verdes y Patatas','Tomate',1,'unidad');

/* 37) Judías Verdes con Almendras Tostadas */
CALL InsertarIngredienteEnReceta('Judías Verdes con Almendras Tostadas','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes con Almendras Tostadas','Almendras',30,'g');

/* 38) Salteado de Judías Verdes y Champiñones */
CALL InsertarIngredienteEnReceta('Salteado de Judías Verdes y Champiñones','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Salteado de Judías Verdes y Champiñones','Champiñones',80,'g');
CALL InsertarIngredienteEnReceta('Salteado de Judías Verdes y Champiñones','Ajo',2,'diente');

/* 39) Judías Verdes con Salsa de Yogur */
CALL InsertarIngredienteEnReceta('Judías Verdes con Salsa de Yogur','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes con Salsa de Yogur','Yogur natural',50,'g');

/* 40) Judías Verdes con Huevo Duro */
CALL InsertarIngredienteEnReceta('Judías Verdes con Huevo Duro','Judías verdes',150,'g');
CALL InsertarIngredienteEnReceta('Judías Verdes con Huevo Duro','Huevo',1,'unidad');

/* 41) Sopa de Cebolla Ligera */
CALL InsertarIngredienteEnReceta('Sopa de Cebolla Ligera','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Cebolla Ligera','Caldo de verduras',500,'ml');

/* 42) Ensalada de Cebolla y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Tomate','Cebolla morada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Tomate','Aceite de oliva',1,'cda');

/* 43) Cebolla Caramelizada */
CALL InsertarIngredienteEnReceta('Cebolla Caramelizada','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla Caramelizada','Vinagre balsámico',1,'cda');
CALL InsertarIngredienteEnReceta('Cebolla Caramelizada','Azúcar',1,'cda');

/* 44) Tarta de Cebolla y Espinacas */
CALL InsertarIngredienteEnReceta('Tarta de Cebolla y Espinacas','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Cebolla y Espinacas','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Tarta de Cebolla y Espinacas','Espinacas',80,'g');
CALL InsertarIngredienteEnReceta('Tarta de Cebolla y Espinacas','Queso bajo en grasa',50,'g');

/* 45) Cebollas Rellenas de Verduras */
CALL InsertarIngredienteEnReceta('Cebollas Rellenas de Verduras','Cebolla grande',2,'unidad');
CALL InsertarIngredienteEnReceta('Cebollas Rellenas de Verduras','Pimientos',1,'unidad');
CALL InsertarIngredienteEnReceta('Cebollas Rellenas de Verduras','Calabacín',1,'unidad');

/* 46) Cebolla al Horno con Hierbas */
CALL InsertarIngredienteEnReceta('Cebolla al Horno con Hierbas','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla al Horno con Hierbas','Hierbas aromáticas',1,'cda');
CALL InsertarIngredienteEnReceta('Cebolla al Horno con Hierbas','Aceite de oliva',1,'cda');

/* 47) Cebolla en Agridulce */
CALL InsertarIngredienteEnReceta('Cebolla en Agridulce','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla en Agridulce','Vinagre',1,'cda');
CALL InsertarIngredienteEnReceta('Cebolla en Agridulce','Azúcar',1,'cda');

/* 48) Cebolla Salteada con Pimientos */
CALL InsertarIngredienteEnReceta('Cebolla Salteada con Pimientos','Cebolla',1,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla Salteada con Pimientos','Pimientos',1,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla Salteada con Pimientos','Aceite de oliva',1,'cda');

/* 49) Ensalada de Cebolla y Aguacate */
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Aguacate','Cebolla morada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Aguacate','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Cebolla y Aguacate','Limón',1,'unidad');

/* 50) Cebolla Gratinada */
CALL InsertarIngredienteEnReceta('Cebolla Gratinada','Cebolla',2,'unidad');
CALL InsertarIngredienteEnReceta('Cebolla Gratinada','Queso rallado',50,'g');
CALL InsertarIngredienteEnReceta('Cebolla Gratinada','Pan rallado',20,'g');

/* 51) Ensalada de Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Ensalada de Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Tomate y Albahaca','Albahaca',1,'cda');
CALL InsertarIngredienteEnReceta('Ensalada de Tomate y Albahaca','Aceite de oliva',1,'cda');

/* 52) Salsa de Tomate Casera */
CALL InsertarIngredienteEnReceta('Salsa de Tomate Casera','Tomate',4,'unidad');
CALL InsertarIngredienteEnReceta('Salsa de Tomate Casera','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Salsa de Tomate Casera','Cebolla',1,'unidad');

/* 53) Tomate Relleno de Atún */
CALL InsertarIngredienteEnReceta('Tomate Relleno de Atún','Tomate grande',1,'unidad');
CALL InsertarIngredienteEnReceta('Tomate Relleno de Atún','Atún',80,'g');
CALL InsertarIngredienteEnReceta('Tomate Relleno de Atún','Aceite de oliva',1,'cda');

/* 54) Gazpacho Andaluz */
CALL InsertarIngredienteEnReceta('Gazpacho Andaluz','Tomate',4,'unidad');
CALL InsertarIngredienteEnReceta('Gazpacho Andaluz','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Gazpacho Andaluz','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Gazpacho Andaluz','Pan',50,'g');

/* 55) Tomates Asados al Horno */
CALL InsertarIngredienteEnReceta('Tomates Asados al Horno','Tomate',4,'unidad');
CALL InsertarIngredienteEnReceta('Tomates Asados al Horno','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Tomates Asados al Horno','Aceite de oliva',1,'cda');

/* 56) Ensalada Caprese */
CALL InsertarIngredienteEnReceta('Ensalada Caprese','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada Caprese','Mozzarella baja en grasa',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada Caprese','Albahaca',1,'cda');

/* 57) Sopa de Tomate */
CALL InsertarIngredienteEnReceta('Sopa de Tomate','Tomate',4,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Tomate','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Tomate','Aceite de oliva',1,'cda');

/* 58) Tomate a la Parrilla */
CALL InsertarIngredienteEnReceta('Tomate a la Parrilla','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Tomate a la Parrilla','Aceite de oliva',1,'cda');

/* 59) Tomate y Pepino en Ensalada */
CALL InsertarIngredienteEnReceta('Tomate y Pepino en Ensalada','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Tomate y Pepino en Ensalada','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Tomate y Pepino en Ensalada','Limón',1,'unidad');

/* 60) Tomate Frito Casero */
CALL InsertarIngredienteEnReceta('Tomate Frito Casero','Tomate',4,'unidad');
CALL InsertarIngredienteEnReceta('Tomate Frito Casero','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Tomate Frito Casero','Ajo',2,'diente');

/* 61) Acelga Salteada con Ajo */
CALL InsertarIngredienteEnReceta('Acelga Salteada con Ajo','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Acelga Salteada con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Acelga Salteada con Ajo','Aceite de oliva',1,'cda');

/* 62) Sopa de Acelga y Patata */
CALL InsertarIngredienteEnReceta('Sopa de Acelga y Patata','Acelga',100,'g');
CALL InsertarIngredienteEnReceta('Sopa de Acelga y Patata','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Acelga y Patata','Caldo de verduras',500,'ml');

/* 63) Tortilla de Acelga */
CALL InsertarIngredienteEnReceta('Tortilla de Acelga','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Tortilla de Acelga','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Acelga','Cebolla',1,'unidad');

/* 64) Ensalada de Acelga y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Acelga y Garbanzos','Acelga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Acelga y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Acelga y Garbanzos','Tomate',1,'unidad');

/* 65) Acelga al Vapor con Limón */
CALL InsertarIngredienteEnReceta('Acelga al Vapor con Limón','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Acelga al Vapor con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Acelga al Vapor con Limón','Aceite de oliva',1,'cda');

/* 66) Empanada de Acelga y Atún */
CALL InsertarIngredienteEnReceta('Empanada de Acelga y Atún','Masa de empanada',1,'base');
CALL InsertarIngredienteEnReceta('Empanada de Acelga y Atún','Acelga',100,'g');
CALL InsertarIngredienteEnReceta('Empanada de Acelga y Atún','Atún',80,'g');

/* 67) Acelga con Garbanzos y Tomate */
CALL InsertarIngredienteEnReceta('Acelga con Garbanzos y Tomate','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Acelga con Garbanzos y Tomate','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Acelga con Garbanzos y Tomate','Tomate',1,'unidad');

/* 68) Acelga con Huevo Pochado */
CALL InsertarIngredienteEnReceta('Acelga con Huevo Pochado','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Acelga con Huevo Pochado','Huevo',1,'unidad');
CALL InsertarIngredienteEnReceta('Acelga con Huevo Pochado','Aceite de oliva',1,'cda');

/* 69) Guiso de Acelga con Almejas */
CALL InsertarIngredienteEnReceta('Guiso de Acelga con Almejas','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Guiso de Acelga con Almejas','Almejas',100,'g');
CALL InsertarIngredienteEnReceta('Guiso de Acelga con Almejas','Caldo de pescado',500,'ml');

/* 70) Croquetas de Acelga y Patata */
CALL InsertarIngredienteEnReceta('Croquetas de Acelga y Patata','Acelga',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Acelga y Patata','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Croquetas de Acelga y Patata','Harina',30,'g');

/* 71) Berenjenas al Horno con Ajo y Romero */
CALL InsertarIngredienteEnReceta('Berenjenas al Horno con Ajo y Romero','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas al Horno con Ajo y Romero','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Berenjenas al Horno con Ajo y Romero','Romero',1,'cdita');

/* 72) Moussaka de Berenjena */
CALL InsertarIngredienteEnReceta('Moussaka de Berenjena','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Moussaka de Berenjena','Carne picada',150,'g');
CALL InsertarIngredienteEnReceta('Moussaka de Berenjena','Bechamel',100,'ml');

/* 73) Berenjenas a la Plancha con Limón */
CALL InsertarIngredienteEnReceta('Berenjenas a la Plancha con Limón','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas a la Plancha con Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas a la Plancha con Limón','Aceite de oliva',1,'cda');

/* 74) Berenjenas Rellenas de Quinoa y Verduras */
CALL InsertarIngredienteEnReceta('Berenjenas Rellenas de Quinoa y Verduras','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas Rellenas de Quinoa y Verduras','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Berenjenas Rellenas de Quinoa y Verduras','Calabacín',50,'g');
CALL InsertarIngredienteEnReceta('Berenjenas Rellenas de Quinoa y Verduras','Zanahoria',1,'unidad');

/* 75) Curry de Berenjena */
CALL InsertarIngredienteEnReceta('Curry de Berenjena','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Curry de Berenjena','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Curry de Berenjena','Leche de coco',150,'ml');

/* 76) Berenjenas Fritas con Yogur */
CALL InsertarIngredienteEnReceta('Berenjenas Fritas con Yogur','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas Fritas con Yogur','Yogur natural',50,'g');
CALL InsertarIngredienteEnReceta('Berenjenas Fritas con Yogur','Harina',30,'g');

/* 77) Lasagna de Berenjena (sin pasta) */
CALL InsertarIngredienteEnReceta('Lasagna de Berenjena','Berenjena',3,'unidad');
CALL InsertarIngredienteEnReceta('Lasagna de Berenjena','Queso bajo en grasa',80,'g');
CALL InsertarIngredienteEnReceta('Lasagna de Berenjena','Salsa de tomate',150,'ml');

/* 78) Berenjenas en Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Berenjenas en Salsa de Tomate','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas en Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Berenjenas en Salsa de Tomate','Ajo',2,'diente');

/* 79) Tarta Salada de Berenjena */
CALL InsertarIngredienteEnReceta('Tarta Salada de Berenjena','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Tarta Salada de Berenjena','Berenjena',2,'unidad');
CALL InsertarIngredienteEnReceta('Tarta Salada de Berenjena','Queso fresco',80,'g');

/* 80) Ensalada de Berenjena con Tomate y Albahaca */
CALL InsertarIngredienteEnReceta('Ensalada de Berenjena con Tomate y Albahaca','Berenjena asada',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Berenjena con Tomate y Albahaca','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Berenjena con Tomate y Albahaca','Albahaca',1,'cda');

/* 81) Ensalada de Lechuga y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Tomate','Lechuga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Tomate','Aceite de oliva',1,'cda');

/* 82) Tacos de Lechuga con Pollo */
CALL InsertarIngredienteEnReceta('Tacos de Lechuga con Pollo','Hojas de lechuga',4,'unidad');
CALL InsertarIngredienteEnReceta('Tacos de Lechuga con Pollo','Pollo',150,'g');
CALL InsertarIngredienteEnReceta('Tacos de Lechuga con Pollo','Salsa picante',1,'cda');

/* 83) Ensalada César con Lechuga */
CALL InsertarIngredienteEnReceta('Ensalada César con Lechuga','Lechuga romana',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada César con Lechuga','Pollo',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada César con Lechuga','Croutons',30,'g');
CALL InsertarIngredienteEnReceta('Ensalada César con Lechuga','Aderezo César',2,'cda');

/* 84) Wraps de Lechuga con Atún */
CALL InsertarIngredienteEnReceta('Wraps de Lechuga con Atún','Hojas de lechuga',4,'unidad');
CALL InsertarIngredienteEnReceta('Wraps de Lechuga con Atún','Atún',150,'g');
CALL InsertarIngredienteEnReceta('Wraps de Lechuga con Atún','Mayonesa',1,'cda');

/* 85) Ensalada de Lechuga, Aguacate y Pepino */
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Aguacate y Pepino','Lechuga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Aguacate y Pepino','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Aguacate y Pepino','Pepino',1,'unidad');

/* 86) Ensalada de Lechuga y Zanahorias */
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Zanahorias','Lechuga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Zanahorias','Zanahoria rallada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga y Zanahorias','Aceite de oliva',1,'cda');

/* 87) Sopa Fría de Lechuga */
CALL InsertarIngredienteEnReceta('Sopa Fría de Lechuga','Lechuga',150,'g');
CALL InsertarIngredienteEnReceta('Sopa Fría de Lechuga','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Sopa Fría de Lechuga','Limón',1,'unidad');

/* 88) Ensalada Mediterránea de Lechuga */
CALL InsertarIngredienteEnReceta('Ensalada Mediterránea de Lechuga','Lechuga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada Mediterránea de Lechuga','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada Mediterránea de Lechuga','Aceitunas',30,'g');

/* 89) Lechuga Rellena de Pollo y Verduras */
CALL InsertarIngredienteEnReceta('Lechuga Rellena de Pollo y Verduras','Hojas de lechuga',4,'unidad');
CALL InsertarIngredienteEnReceta('Lechuga Rellena de Pollo y Verduras','Pollo',150,'g');
CALL InsertarIngredienteEnReceta('Lechuga Rellena de Pollo y Verduras','Zanahoria',1,'unidad');

/* 90) Ensalada de Lechuga, Fresas y Almendras */
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Fresas y Almendras','Lechuga',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Fresas y Almendras','Fresas',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Lechuga, Fresas y Almendras','Almendras',20,'g');

/* 91) Ensalada de Pepino y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Tomate','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Tomate','Aceite de oliva',1,'cda');

/* 92) Tzatziki (Salsa Griega de Pepino) */
CALL InsertarIngredienteEnReceta('Tzatziki (Salsa Griega de Pepino)','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Tzatziki (Salsa Griega de Pepino)','Yogur',100,'g');
CALL InsertarIngredienteEnReceta('Tzatziki (Salsa Griega de Pepino)','Ajo',1,'diente');

/* 93) Ensalada de Pepino con Aguacate */
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Aguacate','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Aguacate','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Aguacate','Limón',1,'unidad');

/* 94) Pepino a la Menta */
CALL InsertarIngredienteEnReceta('Pepino a la Menta','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Pepino a la Menta','Menta',1,'ramita');
CALL InsertarIngredienteEnReceta('Pepino a la Menta','Limón',1,'unidad');

/* 95) Ensalada de Pepino con Yogur */
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Yogur','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Yogur','Yogur',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino con Yogur','Menta',1,'ramita');

/* 96) Gazpacho de Pepino */
CALL InsertarIngredienteEnReceta('Gazpacho de Pepino','Pepino',2,'unidad');
CALL InsertarIngredienteEnReceta('Gazpacho de Pepino','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Gazpacho de Pepino','Pan',50,'g');

/* 97) Rollitos de Pepino con Hummus */
CALL InsertarIngredienteEnReceta('Rollitos de Pepino con Hummus','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Rollitos de Pepino con Hummus','Hummus',2,'cda');

/* 98) Pepino en Vinagre */
CALL InsertarIngredienteEnReceta('Pepino en Vinagre','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Pepino en Vinagre','Vinagre',20,'ml');
CALL InsertarIngredienteEnReceta('Pepino en Vinagre','Sal',1,'pizca');

/* 99) Ensalada de Pepino y Queso Feta */
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Queso Feta','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Queso Feta','Queso feta',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pepino y Queso Feta','Aceite de oliva',1,'cda');

/* 100) Smoothie de Pepino y Limón */
CALL InsertarIngredienteEnReceta('Smoothie de Pepino y Limón','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Smoothie de Pepino y Limón','Limón',1,'unidad');
CALL InsertarIngredienteEnReceta('Smoothie de Pepino y Limón','Agua',200,'ml');

/* 101) Ensalada de Guisantes y Zanahorias */
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes y Zanahorias','Guisantes',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes y Zanahorias','Zanahoria rallada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes y Zanahorias','Aceite de oliva',1,'cda');

/* 102) Sopa de Guisantes Verdes */
CALL InsertarIngredienteEnReceta('Sopa de Guisantes Verdes','Guisantes verdes',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Guisantes Verdes','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Guisantes Verdes','Cebolla',1,'unidad');

/* 103) Guisantes Salteados con Ajo */
CALL InsertarIngredienteEnReceta('Guisantes Salteados con Ajo','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Guisantes Salteados con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Guisantes Salteados con Ajo','Aceite de oliva',1,'cda');

/* 104) Puré de Guisantes */
CALL InsertarIngredienteEnReceta('Puré de Guisantes','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Puré de Guisantes','Mantequilla',1,'cda');
CALL InsertarIngredienteEnReceta('Puré de Guisantes','Caldo de verduras',200,'ml');

/* 105) Guisantes con Jamón */
CALL InsertarIngredienteEnReceta('Guisantes con Jamón','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Guisantes con Jamón','Jamón serrano',50,'g');

/* 106) Guisantes con Huevo */
CALL InsertarIngredienteEnReceta('Guisantes con Huevo','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Guisantes con Huevo','Huevo',1,'unidad');

/* 107) Arroz con Guisantes */
CALL InsertarIngredienteEnReceta('Arroz con Guisantes','Arroz',100,'g');
CALL InsertarIngredienteEnReceta('Arroz con Guisantes','Guisantes',80,'g');
CALL InsertarIngredienteEnReceta('Arroz con Guisantes','Aceite de oliva',1,'cda');

/* 108) Guisantes con Pimientos */
CALL InsertarIngredienteEnReceta('Guisantes con Pimientos','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Guisantes con Pimientos','Pimientos',1,'unidad');

/* 109) Ensalada de Guisantes con Feta */
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes con Feta','Guisantes',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes con Feta','Queso feta',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Guisantes con Feta','Aceite de oliva',1,'cda');

/* 110) Guisantes con Lentejas */
CALL InsertarIngredienteEnReceta('Guisantes con Lentejas','Guisantes',100,'g');
CALL InsertarIngredienteEnReceta('Guisantes con Lentejas','Lentejas',100,'g');
CALL InsertarIngredienteEnReceta('Guisantes con Lentejas','Cebolla',1,'unidad');

/* 111) Ensalada de Brócoli y Almendras */
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli y Almendras','Brócoli',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli y Almendras','Almendras',30,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli y Almendras','Aceite de oliva',1,'cda');

/* 112) Crema de Brócoli */
CALL InsertarIngredienteEnReceta('Crema de Brócoli','Brócoli',200,'g');
CALL InsertarIngredienteEnReceta('Crema de Brócoli','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Brócoli','Cebolla',1,'unidad');

/* 113) Brócoli al Horno con Ajo y Limón */
CALL InsertarIngredienteEnReceta('Brócoli al Horno con Ajo y Limón','Brócoli',200,'g');
CALL InsertarIngredienteEnReceta('Brócoli al Horno con Ajo y Limón','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Brócoli al Horno con Ajo y Limón','Limón',1,'unidad');

/* 114) Brócoli con Queso */
CALL InsertarIngredienteEnReceta('Brócoli con Queso','Brócoli',200,'g');
CALL InsertarIngredienteEnReceta('Brócoli con Queso','Queso rallado',50,'g');

/* 115) Brócoli Salteado con Tofu */
CALL InsertarIngredienteEnReceta('Brócoli Salteado con Tofu','Brócoli',200,'g');
CALL InsertarIngredienteEnReceta('Brócoli Salteado con Tofu','Tofu',100,'g');
CALL InsertarIngredienteEnReceta('Brócoli Salteado con Tofu','Salsa de soja',1,'cda');

/* 116) Ensalada de Brócoli con Tomate y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli con Tomate y Garbanzos','Brócoli',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli con Tomate y Garbanzos','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Brócoli con Tomate y Garbanzos','Garbanzos',80,'g');

/* 117) Brócoli con Pollo y Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Brócoli con Pollo y Salsa de Mostaza','Brócoli',150,'g');
CALL InsertarIngredienteEnReceta('Brócoli con Pollo y Salsa de Mostaza','Pollo',150,'g');
CALL InsertarIngredienteEnReceta('Brócoli con Pollo y Salsa de Mostaza','Mostaza',1,'cda');

/* 118) Brócoli al Vapor con Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Brócoli al Vapor con Aceite de Oliva','Brócoli',200,'g');
CALL InsertarIngredienteEnReceta('Brócoli al Vapor con Aceite de Oliva','Aceite de oliva',1,'cda');

/* 119) Brócoli con Pimientos y Cebolla */
CALL InsertarIngredienteEnReceta('Brócoli con Pimientos y Cebolla','Brócoli',150,'g');
CALL InsertarIngredienteEnReceta('Brócoli con Pimientos y Cebolla','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Brócoli con Pimientos y Cebolla','Cebolla',1,'unidad');

/* 120) Brócoli con Huevo y Queso */
CALL InsertarIngredienteEnReceta('Brócoli con Huevo y Queso','Brócoli',150,'g');
CALL InsertarIngredienteEnReceta('Brócoli con Huevo y Queso','Huevo',1,'unidad');
CALL InsertarIngredienteEnReceta('Brócoli con Huevo y Queso','Queso rallado',40,'g');

/* 121) Ensalada de Remolacha y Naranjas */
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha y Naranjas','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha y Naranjas','Naranja',1,'unidad');

/* 122) Crema de Remolacha */
CALL InsertarIngredienteEnReceta('Crema de Remolacha','Remolacha',200,'g');
CALL InsertarIngredienteEnReceta('Crema de Remolacha','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Remolacha','Cebolla',1,'unidad');

/* 123) Remolacha Asada con Miel y Mostaza */
CALL InsertarIngredienteEnReceta('Remolacha Asada con Miel y Mostaza','Remolacha',200,'g');
CALL InsertarIngredienteEnReceta('Remolacha Asada con Miel y Mostaza','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Remolacha Asada con Miel y Mostaza','Mostaza',1,'cda');

/* 124) Hummus de Remolacha */
CALL InsertarIngredienteEnReceta('Hummus de Remolacha','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Hummus de Remolacha','Garbanzos',100,'g');
CALL InsertarIngredienteEnReceta('Hummus de Remolacha','Tahini',1,'cda');

/* 125) Remolacha al Horno con Ajo y Romero */
CALL InsertarIngredienteEnReceta('Remolacha al Horno con Ajo y Romero','Remolacha',200,'g');
CALL InsertarIngredienteEnReceta('Remolacha al Horno con Ajo y Romero','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Remolacha al Horno con Ajo y Romero','Romero',1,'cdita');

/* 126) Ensalada de Remolacha con Queso de Cabra */
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha con Queso de Cabra','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha con Queso de Cabra','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha con Queso de Cabra','Nueces',20,'g');

/* 127) Remolacha con Arroz Integral */
CALL InsertarIngredienteEnReceta('Remolacha con Arroz Integral','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Remolacha con Arroz Integral','Arroz integral',80,'g');

/* 128) Batido de Remolacha y Manzana */
CALL InsertarIngredienteEnReceta('Batido de Remolacha y Manzana','Remolacha',100,'g');
CALL InsertarIngredienteEnReceta('Batido de Remolacha y Manzana','Manzana',1,'unidad');
CALL InsertarIngredienteEnReceta('Batido de Remolacha y Manzana','Agua',200,'ml');

/* 129) Tarta de Remolacha y Chocolate */
CALL InsertarIngredienteEnReceta('Tarta de Remolacha y Chocolate','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Tarta de Remolacha y Chocolate','Cacao',1,'cda');
CALL InsertarIngredienteEnReceta('Tarta de Remolacha y Chocolate','Harina',50,'g');

/* 130) Ensalada de Remolacha y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha y Garbanzos','Remolacha',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha y Garbanzos','Garbanzos',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Remolacha y Garbanzos','Cebolla',1,'unidad');

/* 131) Crema de Calabaza */
CALL InsertarIngredienteEnReceta('Crema de Calabaza','Calabaza',300,'g');
CALL InsertarIngredienteEnReceta('Crema de Calabaza','Cebolla',1,'unidad');
CALL InsertarIngredienteEnReceta('Crema de Calabaza','Zanahoria',1,'unidad');

/* 132) Ensalada de Calabaza Asada */
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza Asada','Calabaza',300,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza Asada','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza Asada','Nueces',20,'g');

/* 133) Tarta de Calabaza */
CALL InsertarIngredienteEnReceta('Tarta de Calabaza','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Calabaza','Calabaza',300,'g');
CALL InsertarIngredienteEnReceta('Tarta de Calabaza','Canela',1,'cdita');

/* 134) Calabaza Rellena de Quinoa y Verduras */
CALL InsertarIngredienteEnReceta('Calabaza Rellena de Quinoa y Verduras','Calabaza',1,'unidad');
CALL InsertarIngredienteEnReceta('Calabaza Rellena de Quinoa y Verduras','Quinoa',80,'g');
CALL InsertarIngredienteEnReceta('Calabaza Rellena de Quinoa y Verduras','Zanahoria',1,'unidad');

/* 135) Gnocchis de Calabaza */
CALL InsertarIngredienteEnReceta('Gnocchis de Calabaza','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Gnocchis de Calabaza','Harina',100,'g');
CALL InsertarIngredienteEnReceta('Gnocchis de Calabaza','Huevo',1,'unidad');

/* 136) Calabaza al Horno con Romero */
CALL InsertarIngredienteEnReceta('Calabaza al Horno con Romero','Calabaza',300,'g');
CALL InsertarIngredienteEnReceta('Calabaza al Horno con Romero','Romero',1,'cdita');
CALL InsertarIngredienteEnReceta('Calabaza al Horno con Romero','Aceite de oliva',1,'cda');

/* 137) Ensalada de Calabaza y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza y Garbanzos','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Calabaza y Garbanzos','Cebolla',1,'unidad');

/* 138) Puré de Calabaza con Ajo y Jengibre */
CALL InsertarIngredienteEnReceta('Puré de Calabaza con Ajo y Jengibre','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Puré de Calabaza con Ajo y Jengibre','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Puré de Calabaza con Ajo y Jengibre','Jengibre',1,'cdita');

/* 139) Calabaza en Curry */
CALL InsertarIngredienteEnReceta('Calabaza en Curry','Calabaza',300,'g');
CALL InsertarIngredienteEnReceta('Calabaza en Curry','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Calabaza en Curry','Leche de coco',150,'ml');

/* 140) Chips de Calabaza al Horno */
CALL InsertarIngredienteEnReceta('Chips de Calabaza al Horno','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Chips de Calabaza al Horno','Sal',1,'pizca');
CALL InsertarIngredienteEnReceta('Chips de Calabaza al Horno','Aceite de oliva',1,'cda');

/* 141) Cardo a la Navarra */
CALL InsertarIngredienteEnReceta('Cardo a la Navarra','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo a la Navarra','Jamón',50,'g');
CALL InsertarIngredienteEnReceta('Cardo a la Navarra','Huevo',1,'unidad');

/* 142) Cardo con Almendras */
CALL InsertarIngredienteEnReceta('Cardo con Almendras','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo con Almendras','Almendras',30,'g');
CALL InsertarIngredienteEnReceta('Cardo con Almendras','Aceite de oliva',1,'cda');

/* 143) Cardo con Salsa de Tomate */
CALL InsertarIngredienteEnReceta('Cardo con Salsa de Tomate','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo con Salsa de Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Cardo con Salsa de Tomate','Ajo',2,'diente');

/* 144) Cardo en Salsa de Almendras */
CALL InsertarIngredienteEnReceta('Cardo en Salsa de Almendras','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo en Salsa de Almendras','Almendras',30,'g');
CALL InsertarIngredienteEnReceta('Cardo en Salsa de Almendras','Aceite de oliva',1,'cda');

/* 145) Cardo con Setas */
CALL InsertarIngredienteEnReceta('Cardo con Setas','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo con Setas','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Cardo con Setas','Aceite de oliva',1,'cda');

/* 146) Cardo a la Plancha */
CALL InsertarIngredienteEnReceta('Cardo a la Plancha','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo a la Plancha','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Cardo a la Plancha','Sal',1,'pizca');

/* 147) Cardo en Tempura */
CALL InsertarIngredienteEnReceta('Cardo en Tempura','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo en Tempura','Harina',50,'g');
CALL InsertarIngredienteEnReceta('Cardo en Tempura','Agua',100,'ml');

/* 148) Cardo con Piquillos */
CALL InsertarIngredienteEnReceta('Cardo con Piquillos','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo con Piquillos','Pimientos del piquillo',2,'unidad');

/* 149) Cardo a la Crema */
CALL InsertarIngredienteEnReceta('Cardo a la Crema','Cardo',200,'g');
CALL InsertarIngredienteEnReceta('Cardo a la Crema','Crema de leche',50,'ml');
CALL InsertarIngredienteEnReceta('Cardo a la Crema','Sal',1,'pizca');

/* 150) Cardo en Ensalada */
CALL InsertarIngredienteEnReceta('Cardo en Ensalada','Cardo',150,'g');
CALL InsertarIngredienteEnReceta('Cardo en Ensalada','Lechuga',50,'g');
CALL InsertarIngredienteEnReceta('Cardo en Ensalada','Vinagreta',1,'cda');

/* 151) Coliflor al Horno con Ajo y Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Coliflor al Horno con Ajo y Aceite de Oliva','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Coliflor al Horno con Ajo y Aceite de Oliva','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Coliflor al Horno con Ajo y Aceite de Oliva','Aceite de oliva',1,'cda');

/* 152) Coliflor con Bechamel Ligera */
CALL InsertarIngredienteEnReceta('Coliflor con Bechamel Ligera','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Coliflor con Bechamel Ligera','Bechamel',100,'ml');
CALL InsertarIngredienteEnReceta('Coliflor con Bechamel Ligera','Nuez moscada',1,'pizca');

/* 153) Puré de Coliflor */
CALL InsertarIngredienteEnReceta('Puré de Coliflor','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Puré de Coliflor','Mantequilla',1,'cda');
CALL InsertarIngredienteEnReceta('Puré de Coliflor','Caldo de verduras',200,'ml');

/* 154) Coliflor a la Parrilla */
CALL InsertarIngredienteEnReceta('Coliflor a la Parrilla','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Coliflor a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Coliflor a la Parrilla','Sal',1,'pizca');

/* 155) Ensalada de Coliflor y Garbanzos */
CALL InsertarIngredienteEnReceta('Ensalada de Coliflor y Garbanzos','Coliflor',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Coliflor y Garbanzos','Garbanzos',80,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Coliflor y Garbanzos','Aceite de oliva',1,'cda');

/* 156) Coliflor con Curry */
CALL InsertarIngredienteEnReceta('Coliflor con Curry','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Coliflor con Curry','Curry',1,'cda');
CALL InsertarIngredienteEnReceta('Coliflor con Curry','Leche de coco',150,'ml');

/* 157) Croquetas de Coliflor */
CALL InsertarIngredienteEnReceta('Croquetas de Coliflor','Coliflor',150,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Coliflor','Harina',30,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Coliflor','Huevo',1,'unidad');

/* 158) Sopa de Coliflor */
CALL InsertarIngredienteEnReceta('Sopa de Coliflor','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Sopa de Coliflor','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Coliflor','Nata ligera',50,'ml');

/* 159) Coliflor Salteada con Pimientos */
CALL InsertarIngredienteEnReceta('Coliflor Salteada con Pimientos','Coliflor',200,'g');
CALL InsertarIngredienteEnReceta('Coliflor Salteada con Pimientos','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Coliflor Salteada con Pimientos','Aceite de oliva',1,'cda');

/* 160) Pizza de Coliflor */
CALL InsertarIngredienteEnReceta('Pizza de Coliflor','Coliflor triturada',200,'g');
CALL InsertarIngredienteEnReceta('Pizza de Coliflor','Salsa de tomate',100,'ml');
CALL InsertarIngredienteEnReceta('Pizza de Coliflor','Queso bajo en grasa',50,'g');

/* 161) Espárragos Verdes a la Parrilla */
CALL InsertarIngredienteEnReceta('Espárragos Verdes a la Parrilla','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Espárragos Verdes a la Parrilla','Sal',1,'pizca');

/* 162) Crema de Espárragos Verdes */
CALL InsertarIngredienteEnReceta('Crema de Espárragos Verdes','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Crema de Espárragos Verdes','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Espárragos Verdes','Cebolla',1,'unidad');

/* 163) Espárragos Verdes con Jamón Serrano */
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Jamón Serrano','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Jamón Serrano','Jamón serrano',30,'g');

/* 164) Ensalada de Espárragos Verdes y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Espárragos Verdes y Tomate','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Espárragos Verdes y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Espárragos Verdes y Tomate','Aceite de oliva',1,'cda');

/* 165) Espárragos Verdes Salteados con Ajo */
CALL InsertarIngredienteEnReceta('Espárragos Verdes Salteados con Ajo','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes Salteados con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Espárragos Verdes Salteados con Ajo','Aceite de oliva',1,'cda');

/* 166) Espárragos Verdes con Huevo Poché */
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Huevo Poché','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Huevo Poché','Huevo',1,'unidad');

/* 167) Quiche de Espárragos Verdes */
CALL InsertarIngredienteEnReceta('Quiche de Espárragos Verdes','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Quiche de Espárragos Verdes','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Quiche de Espárragos Verdes','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Quiche de Espárragos Verdes','Queso bajo en grasa',50,'g');

/* 168) Espárragos Verdes con Almendras */
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Almendras','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Almendras','Almendras',30,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Almendras','Aceite de oliva',1,'cda');

/* 169) Espárragos Verdes al Horno con Parmesano */
CALL InsertarIngredienteEnReceta('Espárragos Verdes al Horno con Parmesano','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes al Horno con Parmesano','Queso parmesano',40,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes al Horno con Parmesano','Aceite de oliva',1,'cda');

/* 170) Espárragos Verdes con Salsa de Yogur */
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Salsa de Yogur','Espárragos verdes',150,'g');
CALL InsertarIngredienteEnReceta('Espárragos Verdes con Salsa de Yogur','Yogur natural',50,'g');

/* 171) Puerros a la Parrilla */
CALL InsertarIngredienteEnReceta('Puerros a la Parrilla','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Puerros a la Parrilla','Sal',1,'pizca');

/* 172) Crema de Puerro y Patata */
CALL InsertarIngredienteEnReceta('Crema de Puerro y Patata','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Crema de Puerro y Patata','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Crema de Puerro y Patata','Caldo de verduras',500,'ml');

/* 173) Puerros Salteados con Ajo */
CALL InsertarIngredienteEnReceta('Puerros Salteados con Ajo','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros Salteados con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Puerros Salteados con Ajo','Aceite de oliva',1,'cda');

/* 174) Ensalada de Puerros y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Puerros y Tomate','Puerro',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Puerros y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Puerros y Tomate','Aceite de oliva',1,'cda');

/* 175) Tarta de Puerros y Queso */
CALL InsertarIngredienteEnReceta('Tarta de Puerros y Queso','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Puerros y Queso','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Tarta de Puerros y Queso','Queso rallado',50,'g');

/* 176) Puerros con Salsa de Mostaza */
CALL InsertarIngredienteEnReceta('Puerros con Salsa de Mostaza','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros con Salsa de Mostaza','Mostaza',1,'cda');
CALL InsertarIngredienteEnReceta('Puerros con Salsa de Mostaza','Miel',1,'cda');

/* 177) Puerros en Tempura */
CALL InsertarIngredienteEnReceta('Puerros en Tempura','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros en Tempura','Harina',50,'g');
CALL InsertarIngredienteEnReceta('Puerros en Tempura','Agua',100,'ml');

/* 178) Sopa de Puerros y Zanahoria */
CALL InsertarIngredienteEnReceta('Sopa de Puerros y Zanahoria','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Puerros y Zanahoria','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Puerros y Zanahoria','Caldo de verduras',500,'ml');

/* 179) Puerros al Horno con Parmesano */
CALL InsertarIngredienteEnReceta('Puerros al Horno con Parmesano','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros al Horno con Parmesano','Queso parmesano',40,'g');
CALL InsertarIngredienteEnReceta('Puerros al Horno con Parmesano','Aceite de oliva',1,'cda');

/* 180) Puerros con Huevo Pochado */
CALL InsertarIngredienteEnReceta('Puerros con Huevo Pochado','Puerro',2,'unidad');
CALL InsertarIngredienteEnReceta('Puerros con Huevo Pochado','Huevo',1,'unidad');

/* 181) Ensalada de Rábano y Zanahoria */
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Zanahoria','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Zanahoria','Zanahoria rallada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Zanahoria','Vinagreta',1,'cda');

/* 182) Rábanos Asados con Ajo */
CALL InsertarIngredienteEnReceta('Rábanos Asados con Ajo','Rábanos',150,'g');
CALL InsertarIngredienteEnReceta('Rábanos Asados con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Rábanos Asados con Ajo','Aceite de oliva',1,'cda');

/* 183) Tartar de Rábano y Aguacate */
CALL InsertarIngredienteEnReceta('Tartar de Rábano y Aguacate','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Tartar de Rábano y Aguacate','Aguacate',1,'unidad');
CALL InsertarIngredienteEnReceta('Tartar de Rábano y Aguacate','Limón',1,'unidad');

/* 184) Sopa Fría de Rábano y Pepino */
CALL InsertarIngredienteEnReceta('Sopa Fría de Rábano y Pepino','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Sopa Fría de Rábano y Pepino','Pepino',1,'unidad');
CALL InsertarIngredienteEnReceta('Sopa Fría de Rábano y Pepino','Menta',1,'ramita');

/* 185) Ensalada de Rábano y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Tomate','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Tomate','Aceite de oliva',1,'cda');

/* 186) Rábano al Horno con Miel y Mostaza */
CALL InsertarIngredienteEnReceta('Rábano al Horno con Miel y Mostaza','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Rábano al Horno con Miel y Mostaza','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Rábano al Horno con Miel y Mostaza','Mostaza',1,'cda');

/* 187) Rábano en Pickles */
CALL InsertarIngredienteEnReceta('Rábano en Pickles','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Rábano en Pickles','Vinagre',20,'ml');
CALL InsertarIngredienteEnReceta('Rábano en Pickles','Sal',1,'pizca');

/* 188) Rábano con Huevo Pochado */
CALL InsertarIngredienteEnReceta('Rábano con Huevo Pochado','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Rábano con Huevo Pochado','Huevo',1,'unidad');

/* 189) Ensalada de Rábano y Apio */
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Apio','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Rábano y Apio','Apio',1,'unidad');

/* 190) Rábano con Aceite de Sésamo */
CALL InsertarIngredienteEnReceta('Rábano con Aceite de Sésamo','Rábano',100,'g');
CALL InsertarIngredienteEnReceta('Rábano con Aceite de Sésamo','Aceite de sésamo',1,'cda');
CALL InsertarIngredienteEnReceta('Rábano con Aceite de Sésamo','Jengibre',1,'cdita');

/* 191) Ensalada de Repollo y Zanahoria */
CALL InsertarIngredienteEnReceta('Ensalada de Repollo y Zanahoria','Repollo',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Repollo y Zanahoria','Zanahoria rallada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Repollo y Zanahoria','Vinagreta',1,'cda');

/* 192) Repollo Salteado con Ajo */
CALL InsertarIngredienteEnReceta('Repollo Salteado con Ajo','Repollo',150,'g');
CALL InsertarIngredienteEnReceta('Repollo Salteado con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Repollo Salteado con Ajo','Aceite de oliva',1,'cda');

/* 193) Rollitos de Repollo Rellenos de Arroz y Verduras */
CALL InsertarIngredienteEnReceta('Rollitos de Repollo Rellenos de Arroz y Verduras','Repollo',4,'hoja');
CALL InsertarIngredienteEnReceta('Rollitos de Repollo Rellenos de Arroz y Verduras','Arroz integral',80,'g');
CALL InsertarIngredienteEnReceta('Rollitos de Repollo Rellenos de Arroz y Verduras','Verduras mixtas',100,'g');

/* 194) Sopa de Repollo y Lentejas */
CALL InsertarIngredienteEnReceta('Sopa de Repollo y Lentejas','Repollo',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Repollo y Lentejas','Lentejas',100,'g');
CALL InsertarIngredienteEnReceta('Sopa de Repollo y Lentejas','Caldo de verduras',500,'ml');

/* 195) Sopa de Nabo y Patata */
CALL InsertarIngredienteEnReceta('Sopa de Nabo y Patata','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Nabo y Patata','Patata',1,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Nabo y Patata','Caldo de verduras',500,'ml');

/* 196) Nabo al Horno con Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Nabo al Horno con Aceite de Oliva','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Nabo al Horno con Aceite de Oliva','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Nabo al Horno con Aceite de Oliva','Sal',1,'pizca');

/* 197) Ensalada de Nabo y Zanahoria */
CALL InsertarIngredienteEnReceta('Ensalada de Nabo y Zanahoria','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Nabo y Zanahoria','Zanahoria rallada',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Nabo y Zanahoria','Aceite de oliva',1,'cda');

/* 198) Puré de Nabo y Ajo */
CALL InsertarIngredienteEnReceta('Puré de Nabo y Ajo','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Puré de Nabo y Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Puré de Nabo y Ajo','Mantequilla',1,'cda');

/* 199) Nabo Salteado con Tofu */
CALL InsertarIngredienteEnReceta('Nabo Salteado con Tofu','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Nabo Salteado con Tofu','Tofu',100,'g');
CALL InsertarIngredienteEnReceta('Nabo Salteado con Tofu','Salsa de soja',1,'cda');

/* 200) Nabo en Escabeche */
CALL InsertarIngredienteEnReceta('Nabo en Escabeche','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Nabo en Escabeche','Vinagre',20,'ml');
CALL InsertarIngredienteEnReceta('Nabo en Escabeche','Sal',1,'pizca');

/* 201) Guiso de Nabo con Verduras */
CALL InsertarIngredienteEnReceta('Guiso de Nabo con Verduras','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Guiso de Nabo con Verduras','Zanahoria',1,'unidad');
CALL InsertarIngredienteEnReceta('Guiso de Nabo con Verduras','Caldo de verduras',500,'ml');

/* 202) Tacos de Nabo */
CALL InsertarIngredienteEnReceta('Tacos de Nabo','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Tacos de Nabo','Tortillas de maíz',2,'unidad');
CALL InsertarIngredienteEnReceta('Tacos de Nabo','Salsa picante',1,'cda');

/* 203) Nabo y Calabacín a la Plancha */
CALL InsertarIngredienteEnReceta('Nabo y Calabacín a la Plancha','Nabo',1,'unidad');
CALL InsertarIngredienteEnReceta('Nabo y Calabacín a la Plancha','Calabacín',1,'unidad');
CALL InsertarIngredienteEnReceta('Nabo y Calabacín a la Plancha','Aceite de oliva',1,'cda');

/* 204) Ensalada de Nabo con Manzana y Apio */
CALL InsertarIngredienteEnReceta('Ensalada de Nabo con Manzana y Apio','Nabo',150,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Nabo con Manzana y Apio','Manzana',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Nabo con Manzana y Apio','Apio',1,'unidad');

/* 205) Ajo Asado */
CALL InsertarIngredienteEnReceta('Ajo Asado','Ajo',3,'cabeza');
CALL InsertarIngredienteEnReceta('Ajo Asado','Aceite de oliva',1,'cda');

/* 206) Espaguetis al Ajo y Aceite */
CALL InsertarIngredienteEnReceta('Espaguetis al Ajo y Aceite','Espaguetis',100,'g');
CALL InsertarIngredienteEnReceta('Espaguetis al Ajo y Aceite','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Espaguetis al Ajo y Aceite','Aceite de oliva',1,'cda');

/* 207) Pollo al Ajo (aunque incluye pollo, se usa abundante verdura aromática) */
CALL InsertarIngredienteEnReceta('Pollo al Ajo','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo al Ajo','Ajo',4,'diente');
CALL InsertarIngredienteEnReceta('Pollo al Ajo','Aceite de oliva',1,'cda');

/* 208) Crema de Ajo */
CALL InsertarIngredienteEnReceta('Crema de Ajo','Ajo',4,'diente');
CALL InsertarIngredienteEnReceta('Crema de Ajo','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Ajo','Pan',50,'g');

/* 209) Ajo en Aceite de Oliva */
CALL InsertarIngredienteEnReceta('Ajo en Aceite de Oliva','Ajo',4,'diente');
CALL InsertarIngredienteEnReceta('Ajo en Aceite de Oliva','Aceite de oliva',50,'ml');

/* 210) Pan de Ajo */
CALL InsertarIngredienteEnReceta('Pan de Ajo','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Pan de Ajo','Mantequilla de ajo',1,'cda');

/* 211) Sopa de Ajo */
CALL InsertarIngredienteEnReceta('Sopa de Ajo','Ajo',4,'diente');
CALL InsertarIngredienteEnReceta('Sopa de Ajo','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Ajo','Huevo',1,'unidad');

/* 212) Gambas al Ajillo (aunque sea marisco, se acompaña de ajo y verduras) */
CALL InsertarIngredienteEnReceta('Gambas al Ajillo','Gambas',200,'g');
CALL InsertarIngredienteEnReceta('Gambas al Ajillo','Ajo',4,'diente');
CALL InsertarIngredienteEnReceta('Gambas al Ajillo','Aceite de oliva',1,'cda');

/* 213) Ajo Negro en Vinagre */
CALL InsertarIngredienteEnReceta('Ajo Negro en Vinagre','Ajo negro',3,'diente');
CALL InsertarIngredienteEnReceta('Ajo Negro en Vinagre','Vinagre',20,'ml');

/* 214) Verduras al Ajo */
CALL InsertarIngredienteEnReceta('Verduras al Ajo','Verduras mixtas',200,'g');
CALL InsertarIngredienteEnReceta('Verduras al Ajo','Ajo',3,'diente');
CALL InsertarIngredienteEnReceta('Verduras al Ajo','Aceite de oliva',1,'cda');

/* 215) Crema de Calabacín */
CALL InsertarIngredienteEnReceta('Crema de Calabacín','Calabacín',300,'g');
CALL InsertarIngredienteEnReceta('Crema de Calabacín','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Crema de Calabacín','Cebolla',1,'unidad');

/* 216) Calabacín Relleno de Carne */
CALL InsertarIngredienteEnReceta('Calabacín Relleno de Carne','Calabacín',2,'unidad');
CALL InsertarIngredienteEnReceta('Calabacín Relleno de Carne','Carne picada',150,'g');
CALL InsertarIngredienteEnReceta('Calabacín Relleno de Carne','Queso rallado',30,'g');

/* 217) Espaguetis de Calabacín */
CALL InsertarIngredienteEnReceta('Espaguetis de Calabacín','Calabacín (en tiras)',200,'g');
CALL InsertarIngredienteEnReceta('Espaguetis de Calabacín','Aceite de oliva',1,'cda');

/* 218) Calabacín a la Parrilla */
CALL InsertarIngredienteEnReceta('Calabacín a la Parrilla','Calabacín',2,'unidad');
CALL InsertarIngredienteEnReceta('Calabacín a la Parrilla','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Calabacín a la Parrilla','Sal',1,'pizca');

/* 219) Calabacín Salteado con Ajo */
CALL InsertarIngredienteEnReceta('Calabacín Salteado con Ajo','Calabacín',2,'unidad');
CALL InsertarIngredienteEnReceta('Calabacín Salteado con Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Calabacín Salteado con Ajo','Aceite de oliva',1,'cda');

/* 220) Ensalada de Calabacín y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Calabacín y Tomate','Calabacín',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Calabacín y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Calabacín y Tomate','Aceite de oliva',1,'cda');

/* 221) Lasagna de Calabacín */
CALL InsertarIngredienteEnReceta('Lasagna de Calabacín','Calabacín (en láminas)',250,'g');
CALL InsertarIngredienteEnReceta('Lasagna de Calabacín','Salsa de tomate',150,'ml');
CALL InsertarIngredienteEnReceta('Lasagna de Calabacín','Queso rallado',50,'g');

/* 222) Tarta de Calabacín */
CALL InsertarIngredienteEnReceta('Tarta de Calabacín','Masa de tarta',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Calabacín','Calabacín',200,'g');
CALL InsertarIngredienteEnReceta('Tarta de Calabacín','Queso crema',50,'g');

/* 223) Frittata de Calabacín */
CALL InsertarIngredienteEnReceta('Frittata de Calabacín','Calabacín',150,'g');
CALL InsertarIngredienteEnReceta('Frittata de Calabacín','Huevo',3,'unidad');
CALL InsertarIngredienteEnReceta('Frittata de Calabacín','Cebolla',1,'unidad');

/* 224) Sopa de Calabacín y Jengibre */
CALL InsertarIngredienteEnReceta('Sopa de Calabacín y Jengibre','Calabacín',200,'g');
CALL InsertarIngredienteEnReceta('Sopa de Calabacín y Jengibre','Jengibre',1,'cdita');
CALL InsertarIngredienteEnReceta('Sopa de Calabacín y Jengibre','Caldo de verduras',500,'ml');

-- =======================================================
-- FIN DE LAS LLAMADAS PARA VERDURAS
-- =======================================================

/* =======================================================
   LLAMADAS A InsertarIngredienteEnReceta para recetas de EMBUTIDOS 
   (categoria_id = 9)
   ======================================================= */

/* 1) Ensalada de Jamón Ibérico y Rúcula */
CALL InsertarIngredienteEnReceta('Ensalada de Jamón Ibérico y Rúcula','Jamón ibérico',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Jamón Ibérico y Rúcula','Rúcula',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Jamón Ibérico y Rúcula','Aceite de oliva',1,'cda');

/* 2) Tostadas con Tomate y Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Tostadas con Tomate y Jamón Ibérico','Pan integral',2,'rebanada');
CALL InsertarIngredienteEnReceta('Tostadas con Tomate y Jamón Ibérico','Tomate triturado',100,'g');
CALL InsertarIngredienteEnReceta('Tostadas con Tomate y Jamón Ibérico','Jamón ibérico',50,'g');

/* 3) Melón con Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Melón con Jamón Ibérico','Melón',200,'g');
CALL InsertarIngredienteEnReceta('Melón con Jamón Ibérico','Jamón ibérico',50,'g');

/* 4) Huevos Rotos con Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Huevos Rotos con Jamón Ibérico','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Huevos Rotos con Jamón Ibérico','Jamón ibérico',50,'g');
CALL InsertarIngredienteEnReceta('Huevos Rotos con Jamón Ibérico','Pimiento',1,'unidad');

/* 5) Brochetas de Jamón Ibérico y Mozzarella */
CALL InsertarIngredienteEnReceta('Brochetas de Jamón Ibérico y Mozzarella','Jamón ibérico',50,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Jamón Ibérico y Mozzarella','Mozzarella fresca',50,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Jamón Ibérico y Mozzarella','Albahaca fresca',1,'ramita');

/* 6) Alcachofas al Horno con Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Alcachofas al Horno con Jamón Ibérico','Alcachofas',3,'unidad');
CALL InsertarIngredienteEnReceta('Alcachofas al Horno con Jamón Ibérico','Jamón ibérico',30,'g');
CALL InsertarIngredienteEnReceta('Alcachofas al Horno con Jamón Ibérico','Aceite de oliva',1,'cda');

/* 7) Espárragos con Jamón Ibérico y Parmesano */
CALL InsertarIngredienteEnReceta('Espárragos con Jamón Ibérico y Parmesano','Espárragos',200,'g');
CALL InsertarIngredienteEnReceta('Espárragos con Jamón Ibérico y Parmesano','Jamón ibérico',50,'g');
CALL InsertarIngredienteEnReceta('Espárragos con Jamón Ibérico y Parmesano','Queso parmesano',30,'g');

/* 8) Crema de Calabacín con Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Crema de Calabacín con Jamón Ibérico','Calabacín',200,'g');
CALL InsertarIngredienteEnReceta('Crema de Calabacín con Jamón Ibérico','Jamón ibérico',30,'g');
CALL InsertarIngredienteEnReceta('Crema de Calabacín con Jamón Ibérico','Crema de leche',50,'ml');

/* 9) Tortilla de Espinacas y Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Tortilla de Espinacas y Jamón Ibérico','Huevo',3,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Espinacas y Jamón Ibérico','Jamón ibérico',30,'g');
CALL InsertarIngredienteEnReceta('Tortilla de Espinacas y Jamón Ibérico','Espinacas',50,'g');

/* 10) Champiñones Rellenos de Jamón Ibérico */
CALL InsertarIngredienteEnReceta('Champiñones Rellenos de Jamón Ibérico','Champiñones',10,'unidad');
CALL InsertarIngredienteEnReceta('Champiñones Rellenos de Jamón Ibérico','Jamón ibérico',30,'g');
CALL InsertarIngredienteEnReceta('Champiñones Rellenos de Jamón Ibérico','Ajo',1,'diente');

/* =======================================================
   FIN DE LAS LLAMADAS PARA EMBUTIDOS
   ======================================================= */

/* =======================================================
   LLAMADAS A InsertarIngredienteEnReceta para recetas de FRUTAS
   (categoria_id = 10)
   ======================================================= */

/* 1) Ensalada de Fresas y Espinacas */
CALL InsertarIngredienteEnReceta('Ensalada de Fresas y Espinacas','Fresas',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Fresas y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Fresas y Espinacas','Queso de cabra',30,'g');

/* 2) Smoothie de Fresas y Plátano */
CALL InsertarIngredienteEnReceta('Smoothie de Fresas y Plátano','Fresas',100,'g');
CALL InsertarIngredienteEnReceta('Smoothie de Fresas y Plátano','Plátano',1,'unidad');
CALL InsertarIngredienteEnReceta('Smoothie de Fresas y Plátano','Leche de almendra',200,'ml');

/* 3) Tarta de Fresas y Crema */
CALL InsertarIngredienteEnReceta('Tarta de Fresas y Crema','Fresas',150,'g');
CALL InsertarIngredienteEnReceta('Tarta de Fresas y Crema','Crema pastelera',100,'g');
CALL InsertarIngredienteEnReceta('Tarta de Fresas y Crema','Base crujiente',1,'base');

/* 4) Yogur con Fresas y Miel */
CALL InsertarIngredienteEnReceta('Yogur con Fresas y Miel','Fresas',100,'g');
CALL InsertarIngredienteEnReceta('Yogur con Fresas y Miel','Yogur natural',150,'g');
CALL InsertarIngredienteEnReceta('Yogur con Fresas y Miel','Miel',1,'cda');

/* 5) Ensalada de Fresas con Queso Fresco */
CALL InsertarIngredienteEnReceta('Ensalada de Fresas con Queso Fresco','Fresas',100,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Fresas con Queso Fresco','Queso fresco',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Fresas con Queso Fresco','Aceite de oliva',1,'cda');

/* 6) Smoothie de Plátano y Espinacas */
CALL InsertarIngredienteEnReceta('Smoothie de Plátano y Espinacas','Plátano',1,'unidad');
CALL InsertarIngredienteEnReceta('Smoothie de Plátano y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Smoothie de Plátano y Espinacas','Leche de almendra',200,'ml');

/* 7) Panqueques de Plátano */
CALL InsertarIngredienteEnReceta('Panqueques de Plátano','Plátano',1,'unidad');
CALL InsertarIngredienteEnReceta('Panqueques de Plátano','Harina integral',100,'g');
CALL InsertarIngredienteEnReceta('Panqueques de Plátano','Leche',150,'ml');

/* 8) Tarta de Plátano y Chocolate */
CALL InsertarIngredienteEnReceta('Tarta de Plátano y Chocolate','Plátano',1,'unidad');
CALL InsertarIngredienteEnReceta('Tarta de Plátano y Chocolate','Chocolate negro',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Plátano y Chocolate','Base crujiente',1,'base');

/* 9) Plátanos Asados con Miel y Canela */
CALL InsertarIngredienteEnReceta('Plátanos Asados con Miel y Canela','Plátano',2,'unidad');
CALL InsertarIngredienteEnReceta('Plátanos Asados con Miel y Canela','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Plátanos Asados con Miel y Canela','Canela',1,'cdita');

/* 10) Helado de Plátano y Fresas */
CALL InsertarIngredienteEnReceta('Helado de Plátano y Fresas','Plátano',1,'unidad');
CALL InsertarIngredienteEnReceta('Helado de Plátano y Fresas','Fresas',100,'g');
CALL InsertarIngredienteEnReceta('Helado de Plátano y Fresas','Leche',200,'ml');

/* =======================================================
   FIN DE LLAMADAS PARA FRUTAS
   ======================================================= */

/***********************************************
  LLAMADAS A InsertarIngredienteEnReceta para QUESOS
  (categoria_id = 11)
***********************************************/

/* ---------- PECORINO DELLA MAREMMA ---------- */

/* 1) Pasta Cacio e Pepe con Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Pasta Cacio e Pepe con Pecorino della Maremma','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta Cacio e Pepe con Pecorino della Maremma','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Pasta Cacio e Pepe con Pecorino della Maremma','Pimienta negra',1,'cdita');

/* 2) Ensalada de Tomate, Albahaca y Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Ensalada de Tomate, Albahaca y Pecorino della Maremma','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Tomate, Albahaca y Pecorino della Maremma','Albahaca',1,'manojo');
CALL InsertarIngredienteEnReceta('Ensalada de Tomate, Albahaca y Pecorino della Maremma','Pecorino della Maremma',40,'g');

/* 3) Pizza con Pecorino della Maremma y Higos */
CALL InsertarIngredienteEnReceta('Pizza con Pecorino della Maremma y Higos','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza con Pecorino della Maremma y Higos','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Pizza con Pecorino della Maremma y Higos','Higos',3,'unidad');

/* 4) Risotto con Pecorino della Maremma y Setas */
CALL InsertarIngredienteEnReceta('Risotto con Pecorino della Maremma y Setas','Arroz para risotto',150,'g');
CALL InsertarIngredienteEnReceta('Risotto con Pecorino della Maremma y Setas','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Risotto con Pecorino della Maremma y Setas','Setas',100,'g');

/* 5) Tarta de Pecorino della Maremma y Espárragos */
CALL InsertarIngredienteEnReceta('Tarta de Pecorino della Maremma y Espárragos','Base de masa quebrada',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Pecorino della Maremma y Espárragos','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Pecorino della Maremma y Espárragos','Espárragos verdes',80,'g');

/* 6) Croquetas de Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Croquetas de Pecorino della Maremma','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Pecorino della Maremma','Patata',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Pecorino della Maremma','Cebolla',1,'unidad');

/* 7) Sopa de Lentejas con Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Sopa de Lentejas con Pecorino della Maremma','Lentejas',100,'g');
CALL InsertarIngredienteEnReceta('Sopa de Lentejas con Pecorino della Maremma','Pecorino della Maremma',30,'g');
CALL InsertarIngredienteEnReceta('Sopa de Lentejas con Pecorino della Maremma','Caldo de verduras',500,'ml');

/* 8) Ensalada de Pera, Nueces y Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Pecorino della Maremma','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Pecorino della Maremma','Nueces',20,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Pecorino della Maremma','Pecorino della Maremma',40,'g');

/* 9) Pollo al Horno con Pecorino della Maremma */
CALL InsertarIngredienteEnReceta('Pollo al Horno con Pecorino della Maremma','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo al Horno con Pecorino della Maremma','Pecorino della Maremma',50,'g');
CALL InsertarIngredienteEnReceta('Pollo al Horno con Pecorino della Maremma','Hierbas aromáticas',1,'cda');

/* 10) Panini con Pecorino della Maremma y Prosciutto */
CALL InsertarIngredienteEnReceta('Panini con Pecorino della Maremma y Prosciutto','Panini',1,'unidad');
CALL InsertarIngredienteEnReceta('Panini con Pecorino della Maremma y Prosciutto','Pecorino della Maremma',40,'g');
CALL InsertarIngredienteEnReceta('Panini con Pecorino della Maremma y Prosciutto','Prosciutto',50,'g');


/* ---------- MOZZARELLA DI BUFALA ---------- */

/* 1) Ensalada Caprese con Mozzarella di Bufala */
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Mozzarella di Bufala','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Mozzarella di Bufala','Albahaca',1,'manojo');
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Mozzarella di Bufala','Mozzarella di Bufala',50,'g');

/* 2) Pizza Margherita con Mozzarella di Bufala */
CALL InsertarIngredienteEnReceta('Pizza Margherita con Mozzarella di Bufala','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza Margherita con Mozzarella di Bufala','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Pizza Margherita con Mozzarella di Bufala','Mozzarella di Bufala',50,'g');

/* 3) Pasta con Mozzarella di Bufala y Tomates Secos */
CALL InsertarIngredienteEnReceta('Pasta con Mozzarella di Bufala y Tomates Secos','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta con Mozzarella di Bufala y Tomates Secos','Mozzarella di Bufala',50,'g');
CALL InsertarIngredienteEnReceta('Pasta con Mozzarella di Bufala y Tomates Secos','Tomates secos',30,'g');

/* 4) Bruschetta con Mozzarella di Bufala */
CALL InsertarIngredienteEnReceta('Bruschetta con Mozzarella di Bufala','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Bruschetta con Mozzarella di Bufala','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Bruschetta con Mozzarella di Bufala','Mozzarella di Bufala',40,'g');

/* 5) Pollo Relleno de Mozzarella di Bufala y Pesto */
CALL InsertarIngredienteEnReceta('Pollo Relleno de Mozzarella di Bufala y Pesto','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Mozzarella di Bufala y Pesto','Mozzarella di Bufala',40,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Mozzarella di Bufala y Pesto','Pesto',1,'cda');

/* 6) Ensalada de Mozzarella di Bufala con Pera y Nueces */
CALL InsertarIngredienteEnReceta('Ensalada de Mozzarella di Bufala con Pera y Nueces','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Mozzarella di Bufala con Pera y Nueces','Nueces',20,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Mozzarella di Bufala con Pera y Nueces','Mozzarella di Bufala',40,'g');

/* 7) Tortilla de Mozzarella di Bufala y Espinacas */
CALL InsertarIngredienteEnReceta('Tortilla de Mozzarella di Bufala y Espinacas','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Mozzarella di Bufala y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Tortilla de Mozzarella di Bufala y Espinacas','Mozzarella di Bufala',40,'g');

/* 8) Lasagna con Mozzarella di Bufala y Berenjenas */
CALL InsertarIngredienteEnReceta('Lasagna con Mozzarella di Bufala y Berenjenas','Berenjena',150,'g');
CALL InsertarIngredienteEnReceta('Lasagna con Mozzarella di Bufala y Berenjenas','Mozzarella di Bufala',50,'g');
CALL InsertarIngredienteEnReceta('Lasagna con Mozzarella di Bufala y Berenjenas','Salsa de tomate',100,'ml');

/* 9) Sopa Fría de Tomate y Mozzarella di Bufala */
CALL InsertarIngredienteEnReceta('Sopa Fría de Tomate y Mozzarella di Bufala','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Sopa Fría de Tomate y Mozzarella di Bufala','Mozzarella di Bufala',40,'g');
CALL InsertarIngredienteEnReceta('Sopa Fría de Tomate y Mozzarella di Bufala','Aceite de oliva',1,'cda');

/* 10) Panini con Mozzarella di Bufala y Prosciutto */
CALL InsertarIngredienteEnReceta('Panini con Mozzarella di Bufala y Prosciutto','Panini',1,'unidad');
CALL InsertarIngredienteEnReceta('Panini con Mozzarella di Bufala y Prosciutto','Mozzarella di Bufala',40,'g');
CALL InsertarIngredienteEnReceta('Panini con Mozzarella di Bufala y Prosciutto','Prosciutto',50,'g');


/* ---------- PARMIGIANO REGGIANO ---------- */

/* 1) Risotto de Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Risotto de Parmigiano Reggiano','Arroz para risotto',150,'g');
CALL InsertarIngredienteEnReceta('Risotto de Parmigiano Reggiano','Parmigiano Reggiano',40,'g');
CALL InsertarIngredienteEnReceta('Risotto de Parmigiano Reggiano','Caldo de verduras',500,'ml');

/* 2) Ensalada Caprese con Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Parmigiano Reggiano','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Parmigiano Reggiano','Albahaca',1,'manojo');
CALL InsertarIngredienteEnReceta('Ensalada Caprese con Parmigiano Reggiano','Parmigiano Reggiano',40,'g');

/* 3) Lasagna al Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Lasagna al Parmigiano Reggiano','Láminas de pasta',1,'unidad');
CALL InsertarIngredienteEnReceta('Lasagna al Parmigiano Reggiano','Carne de ternera',200,'g');
CALL InsertarIngredienteEnReceta('Lasagna al Parmigiano Reggiano','Parmigiano Reggiano',50,'g');

/* 4) Pollo al Parmigiano */
CALL InsertarIngredienteEnReceta('Pollo al Parmigiano','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo al Parmigiano','Parmigiano Reggiano',50,'g');
CALL InsertarIngredienteEnReceta('Pollo al Parmigiano','Pan rallado',30,'g');

/* 5) Sopa de Tomate con Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Sopa de Tomate con Parmigiano Reggiano','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Sopa de Tomate con Parmigiano Reggiano','Caldo de pollo',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Tomate con Parmigiano Reggiano','Parmigiano Reggiano',40,'g');

/* 6) Espaguetis con Parmigiano Reggiano y Ajo */
CALL InsertarIngredienteEnReceta('Espaguetis con Parmigiano Reggiano y Ajo','Espaguetis',100,'g');
CALL InsertarIngredienteEnReceta('Espaguetis con Parmigiano Reggiano y Ajo','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Espaguetis con Parmigiano Reggiano y Ajo','Parmigiano Reggiano',40,'g');

/* 7) Tarta Salada de Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Tarta Salada de Parmigiano Reggiano','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta Salada de Parmigiano Reggiano','Parmigiano Reggiano',50,'g');
CALL InsertarIngredienteEnReceta('Tarta Salada de Parmigiano Reggiano','Espinacas',50,'g');

/* 8) Croquetas de Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Croquetas de Parmigiano Reggiano','Parmigiano Reggiano',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Parmigiano Reggiano','Patata',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Parmigiano Reggiano','Cebolla',1,'unidad');

/* 9) Bruschetta de Parmigiano Reggiano y Tomate */
CALL InsertarIngredienteEnReceta('Bruschetta de Parmigiano Reggiano y Tomate','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Bruschetta de Parmigiano Reggiano y Tomate','Tomate',1,'unidad');
CALL InsertarIngredienteEnReceta('Bruschetta de Parmigiano Reggiano y Tomate','Parmigiano Reggiano',40,'g');

/* 10) Risotto de Champiñones y Parmigiano Reggiano */
CALL InsertarIngredienteEnReceta('Risotto de Champiñones y Parmigiano Reggiano','Arroz para risotto',150,'g');
CALL InsertarIngredienteEnReceta('Risotto de Champiñones y Parmigiano Reggiano','Champiñones',100,'g');
CALL InsertarIngredienteEnReceta('Risotto de Champiñones y Parmigiano Reggiano','Parmigiano Reggiano',40,'g');


/* ---------- QUESO GORGONZOLA ---------- */

/* 1) Pasta al Gorgonzola */
CALL InsertarIngredienteEnReceta('Pasta al Gorgonzola','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta al Gorgonzola','Gorgonzola',50,'g');
CALL InsertarIngredienteEnReceta('Pasta al Gorgonzola','Crema de leche',50,'ml');

/* 2) Ensalada de Pera, Nueces y Queso Gorgonzola */
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Queso Gorgonzola','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Queso Gorgonzola','Nueces',20,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Nueces y Queso Gorgonzola','Gorgonzola',40,'g');

/* 3) Pizza de Gorgonzola y Pera */
CALL InsertarIngredienteEnReceta('Pizza de Gorgonzola y Pera','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Gorgonzola y Pera','Gorgonzola',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Gorgonzola y Pera','Pera',1,'unidad');

/* 4) Sopa de Calabaza con Queso Gorgonzola */
CALL InsertarIngredienteEnReceta('Sopa de Calabaza con Queso Gorgonzola','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Sopa de Calabaza con Queso Gorgonzola','Gorgonzola',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Calabaza con Queso Gorgonzola','Caldo de verduras',500,'ml');

/* 5) Tarta de Gorgonzola y Espinacas */
CALL InsertarIngredienteEnReceta('Tarta de Gorgonzola y Espinacas','Base de hojaldre',1,'unidad');
CALL InsertarIngredienteEnReceta('Tarta de Gorgonzola y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Gorgonzola y Espinacas','Gorgonzola',50,'g');

/* 6) Rissotto de Gorgonzola y Champiñones */
CALL InsertarIngredienteEnReceta('Rissotto de Gorgonzola y Champiñones','Arroz para risotto',150,'g');
CALL InsertarIngredienteEnReceta('Rissotto de Gorgonzola y Champiñones','Champiñones',100,'g');
CALL InsertarIngredienteEnReceta('Rissotto de Gorgonzola y Champiñones','Gorgonzola',50,'g');

/* 7) Brochetas de Pollo con Gorgonzola */
CALL InsertarIngredienteEnReceta('Brochetas de Pollo con Gorgonzola','Pollo',150,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Pollo con Gorgonzola','Gorgonzola',40,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Pollo con Gorgonzola','Pimiento',1,'unidad');

/* 8) Hamburguesas de Ternera con Gorgonzola */
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera con Gorgonzola','Carne de ternera',150,'g');
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera con Gorgonzola','Gorgonzola',40,'g');
CALL InsertarIngredienteEnReceta('Hamburguesas de Ternera con Gorgonzola','Pan',1,'unidad');

/* 9) Queso Gorgonzola con Miel y Nueces */
CALL InsertarIngredienteEnReceta('Queso Gorgonzola con Miel y Nueces','Gorgonzola',50,'g');
CALL InsertarIngredienteEnReceta('Queso Gorgonzola con Miel y Nueces','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Queso Gorgonzola con Miel y Nueces','Nueces',20,'g');

/* 10) Piquillos Rellenos de Gorgonzola */
CALL InsertarIngredienteEnReceta('Piquillos Rellenos de Gorgonzola','Pimientos del piquillo',4,'unidad');
CALL InsertarIngredienteEnReceta('Piquillos Rellenos de Gorgonzola','Gorgonzola',50,'g');
CALL InsertarIngredienteEnReceta('Piquillos Rellenos de Gorgonzola','Aceite de oliva',1,'cda');


/* ---------- QUESO DE TETILLA ---------- */

/* 1) Croquetas de Queso de Tetilla */
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla','Queso de Tetilla',50,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla','Patata',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla','Cebolla',1,'unidad');

/* 2) Ensalada de Queso de Tetilla y Pera */
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Tetilla y Pera','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Tetilla y Pera','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Tetilla y Pera','Nueces',20,'g');

/* 3) Pizza de Queso de Tetilla y Jamón Serrano */
CALL InsertarIngredienteEnReceta('Pizza de Queso de Tetilla y Jamón Serrano','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Tetilla y Jamón Serrano','Queso de Tetilla',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Tetilla y Jamón Serrano','Jamón serrano',50,'g');

/* 4) Revuelto de Queso de Tetilla y Espinacas */
CALL InsertarIngredienteEnReceta('Revuelto de Queso de Tetilla y Espinacas','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Queso de Tetilla y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Queso de Tetilla y Espinacas','Queso de Tetilla',40,'g');

/* 5) Tarta Salada de Queso de Tetilla y Champiñones */
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Tetilla y Champiñones','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Tetilla y Champiñones','Queso de Tetilla',50,'g');
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Tetilla y Champiñones','Champiñones',80,'g');

/* 6) Panini con Queso de Tetilla y Prosciutto */
CALL InsertarIngredienteEnReceta('Panini con Queso de Tetilla y Prosciutto','Panini',1,'unidad');
CALL InsertarIngredienteEnReceta('Panini con Queso de Tetilla y Prosciutto','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Panini con Queso de Tetilla y Prosciutto','Prosciutto',40,'g');

/* 7) Sopa de Queso de Tetilla y Verduras */
CALL InsertarIngredienteEnReceta('Sopa de Queso de Tetilla y Verduras','Caldo de verduras',500,'ml');
CALL InsertarIngredienteEnReceta('Sopa de Queso de Tetilla y Verduras','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso de Tetilla y Verduras','Cebolla',1,'unidad');

/* 8) Ensalada Templada de Queso de Tetilla con Tomate Seco */
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Tetilla con Tomate Seco','Tomate seco',30,'g');
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Tetilla con Tomate Seco','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Tetilla con Tomate Seco','Lechuga',50,'g');

/* 9) Tostadas de Queso de Tetilla */
CALL InsertarIngredienteEnReceta('Tostadas de Queso de Tetilla','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Tostadas de Queso de Tetilla','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Tostadas de Queso de Tetilla','Miel',1,'cda');

/* 10) Croquetas de Queso de Tetilla y Espinacas */
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla y Espinacas','Queso de Tetilla',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla y Espinacas','Patata',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Tetilla y Espinacas','Espinacas',50,'g');


/* ---------- QUESO DE RADIQUERO ---------- */

/* 1) Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras */
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras','Tomates secos',30,'g');
CALL InsertarIngredienteEnReceta('Ensalada Templada de Queso de Radiquero con Tomates Secos y Almendras','Almendras',20,'g');

/* 2) Pasta Fresca con Queso de Radiquero y Espárragos */
CALL InsertarIngredienteEnReceta('Pasta Fresca con Queso de Radiquero y Espárragos','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta Fresca con Queso de Radiquero y Espárragos','Espárragos verdes',80,'g');
CALL InsertarIngredienteEnReceta('Pasta Fresca con Queso de Radiquero y Espárragos','Queso de Radiquero',40,'g');

/* 3) Tarta Salada de Queso de Radiquero y Pimientos Asados */
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Radiquero y Pimientos Asados','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Radiquero y Pimientos Asados','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Tarta Salada de Queso de Radiquero y Pimientos Asados','Pimientos asados',100,'g');

/* 4) Queso de Radiquero al Horno con Miel y Nueces */
CALL InsertarIngredienteEnReceta('Queso de Radiquero al Horno con Miel y Nueces','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Queso de Radiquero al Horno con Miel y Nueces','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Queso de Radiquero al Horno con Miel y Nueces','Nueces',20,'g');

/* 5) Croquetas de Queso de Radiquero y Jamón Serrano */
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Radiquero y Jamón Serrano','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Radiquero y Jamón Serrano','Jamón serrano',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Radiquero y Jamón Serrano','Patata',100,'g');

/* 6) Brochetas de Queso de Radiquero y Uvas */
CALL InsertarIngredienteEnReceta('Brochetas de Queso de Radiquero y Uvas','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Queso de Radiquero y Uvas','Uvas',50,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Queso de Radiquero y Uvas','Aceite de oliva',1,'cda');

/* 7) Pizza de Queso de Radiquero con Champiñones */
CALL InsertarIngredienteEnReceta('Pizza de Queso de Radiquero con Champiñones','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Radiquero con Champiñones','Champiñones',80,'g');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Radiquero con Champiñones','Queso de Radiquero',40,'g');

/* 8) Sopa de Ajo con Queso de Radiquero Fundido */
CALL InsertarIngredienteEnReceta('Sopa de Ajo con Queso de Radiquero Fundido','Ajo',2,'diente');
CALL InsertarIngredienteEnReceta('Sopa de Ajo con Queso de Radiquero Fundido','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Ajo con Queso de Radiquero Fundido','Caldo de verduras',500,'ml');

/* 9) Tortilla Española con Queso de Radiquero */
CALL InsertarIngredienteEnReceta('Tortilla Española con Queso de Radiquero','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla Española con Queso de Radiquero','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Tortilla Española con Queso de Radiquero','Patata',1,'unidad');

/* 10) Queso de Radiquero con Aceite de Oliva y Romero */
CALL InsertarIngredienteEnReceta('Queso de Radiquero con Aceite de Oliva y Romero','Queso de Radiquero',40,'g');
CALL InsertarIngredienteEnReceta('Queso de Radiquero con Aceite de Oliva y Romero','Aceite de oliva',1,'cda');
CALL InsertarIngredienteEnReceta('Queso de Radiquero con Aceite de Oliva y Romero','Romero',1,'cdita');


/* ---------- QUESO IDIAZÁBAL ---------- */

/* 1) Tarta de Queso Idiazábal y Pimientos */
CALL InsertarIngredienteEnReceta('Tarta de Queso Idiazábal y Pimientos','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Queso Idiazábal y Pimientos','Queso Idiazábal',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Queso Idiazábal y Pimientos','Pimientos asados',100,'g');

/* 2) Ensalada de Queso Idiazábal y Tomate */
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Tomate','Tomate',2,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Tomate','Queso Idiazábal',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Tomate','Aceite de oliva',1,'cda');

/* 3) Croquetas de Queso Idiazábal */
CALL InsertarIngredienteEnReceta('Croquetas de Queso Idiazábal','Queso Idiazábal',50,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso Idiazábal','Patata',100,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso Idiazábal','Harina',30,'g');

/* 4) Pizza de Queso Idiazábal y Jamón Serrano */
CALL InsertarIngredienteEnReceta('Pizza de Queso Idiazábal y Jamón Serrano','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Queso Idiazábal y Jamón Serrano','Queso Idiazábal',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Queso Idiazábal y Jamón Serrano','Jamón serrano',40,'g');

/* 5) Revuelto de Queso Idiazábal y Setas */
CALL InsertarIngredienteEnReceta('Revuelto de Queso Idiazábal y Setas','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Revuelto de Queso Idiazábal y Setas','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Revuelto de Queso Idiazábal y Setas','Queso Idiazábal',40,'g');

/* 6) Brochetas de Queso Idiazábal y Verduras */
CALL InsertarIngredienteEnReceta('Brochetas de Queso Idiazábal y Verduras','Queso Idiazábal',40,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Queso Idiazábal y Verduras','Pimiento',1,'unidad');
CALL InsertarIngredienteEnReceta('Brochetas de Queso Idiazábal y Verduras','Calabacín',80,'g');

/* 7) Ensalada de Queso Idiazábal y Peras */
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Peras','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Peras','Queso Idiazábal',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Idiazábal y Peras','Nueces',20,'g');

/* 8) Sopa de Queso Idiazábal y Calabaza */
CALL InsertarIngredienteEnReceta('Sopa de Queso Idiazábal y Calabaza','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso Idiazábal y Calabaza','Queso Idiazábal',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso Idiazábal y Calabaza','Caldo de verduras',500,'ml');

/* 9) Frittata de Queso Idiazábal y Espinacas */
CALL InsertarIngredienteEnReceta('Frittata de Queso Idiazábal y Espinacas','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Frittata de Queso Idiazábal y Espinacas','Espinacas',50,'g');
CALL InsertarIngredienteEnReceta('Frittata de Queso Idiazábal y Espinacas','Queso Idiazábal',40,'g');

/* 10) Queso Idiazábal al Horno con Miel */
CALL InsertarIngredienteEnReceta('Queso Idiazábal al Horno con Miel','Queso Idiazábal',50,'g');
CALL InsertarIngredienteEnReceta('Queso Idiazábal al Horno con Miel','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Queso Idiazábal al Horno con Miel','Aceite de oliva',1,'cda');


/* ---------- QUESO MANCHEGO ---------- */

/* 1) Ensalada de Queso Manchego y Jamón Serrano */
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Jamón Serrano','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Jamón Serrano','Jamón serrano',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Jamón Serrano','Tomate',2,'unidad');

/* 2) Tarta de Queso Manchego y Espárragos */
CALL InsertarIngredienteEnReceta('Tarta de Queso Manchego y Espárragos','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Queso Manchego y Espárragos','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Queso Manchego y Espárragos','Espárragos',80,'g');

/* 3) Croquetas de Queso Manchego y Trufa */
CALL InsertarIngredienteEnReceta('Croquetas de Queso Manchego y Trufa','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso Manchego y Trufa','Trufa',1,'cdita');
CALL InsertarIngredienteEnReceta('Croquetas de Queso Manchego y Trufa','Patata',100,'g');

/* 4) Pollo Relleno de Queso Manchego y Espinacas */
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso Manchego y Espinacas','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso Manchego y Espinacas','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso Manchego y Espinacas','Espinacas',50,'g');

/* 5) Pizza de Queso Manchego y Setas */
CALL InsertarIngredienteEnReceta('Pizza de Queso Manchego y Setas','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Queso Manchego y Setas','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Queso Manchego y Setas','Setas',100,'g');

/* 6) Bruschetta con Queso Manchego y Pesto */
CALL InsertarIngredienteEnReceta('Bruschetta con Queso Manchego y Pesto','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Bruschetta con Queso Manchego y Pesto','Queso Manchego',40,'g');
CALL InsertarIngredienteEnReceta('Bruschetta con Queso Manchego y Pesto','Pesto',1,'cda');

/* 7) Pimientos Rellenos de Queso Manchego */
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso Manchego','Pimiento rojo',2,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso Manchego','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso Manchego','Cebolla',1,'unidad');

/* 8) Ensalada de Queso Manchego y Peras */
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Peras','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Peras','Queso Manchego',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso Manchego y Peras','Lechuga',50,'g');

/* 9) Tortilla de Queso Manchego y Cebolla Caramelizada */
CALL InsertarIngredienteEnReceta('Tortilla de Queso Manchego y Cebolla Caramelizada','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Queso Manchego y Cebolla Caramelizada','Queso Manchego',40,'g');
CALL InsertarIngredienteEnReceta('Tortilla de Queso Manchego y Cebolla Caramelizada','Cebolla',1,'unidad');

/* 10) Sopa de Queso Manchego y Calabaza */
CALL InsertarIngredienteEnReceta('Sopa de Queso Manchego y Calabaza','Calabaza',200,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso Manchego y Calabaza','Queso Manchego',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso Manchego y Calabaza','Caldo de verduras',500,'ml');


/* ---------- QUESO DE CABRA ---------- */

/* 1) Ensalada de Queso de Cabra y Frutos Secos */
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Frutos Secos','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Frutos Secos','Frutos secos',20,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Frutos Secos','Lechuga',50,'g');

/* 2) Tarta de Queso de Cabra y Tomates Secos */
CALL InsertarIngredienteEnReceta('Tarta de Queso de Cabra y Tomates Secos','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Queso de Cabra y Tomates Secos','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Tarta de Queso de Cabra y Tomates Secos','Tomates secos',30,'g');

/* 3) Croquetas de Queso de Cabra y Miel */
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Cabra y Miel','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Cabra y Miel','Miel',1,'cda');
CALL InsertarIngredienteEnReceta('Croquetas de Queso de Cabra y Miel','Patata',100,'g');

/* 4) Pollo Relleno de Queso de Cabra y Espinacas */
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso de Cabra y Espinacas','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso de Cabra y Espinacas','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Pollo Relleno de Queso de Cabra y Espinacas','Espinacas',50,'g');

/* 5) Pizza de Queso de Cabra, Pera y Rúcula */
CALL InsertarIngredienteEnReceta('Pizza de Queso de Cabra, Pera y Rúcula','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Cabra, Pera y Rúcula','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Pizza de Queso de Cabra, Pera y Rúcula','Pera',1,'unidad');

/* 6) Bruschetta con Queso de Cabra y Miel */
CALL InsertarIngredienteEnReceta('Bruschetta con Queso de Cabra y Miel','Pan',2,'rebanada');
CALL InsertarIngredienteEnReceta('Bruschetta con Queso de Cabra y Miel','Queso de cabra',40,'g');
CALL InsertarIngredienteEnReceta('Bruschetta con Queso de Cabra y Miel','Miel',1,'cda');

/* 7) Pimientos Rellenos de Queso de Cabra */
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso de Cabra','Pimiento rojo',2,'unidad');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso de Cabra','Queso de cabra',50,'g');
CALL InsertarIngredienteEnReceta('Pimientos Rellenos de Queso de Cabra','Cebolla',1,'unidad');

/* 8) Ensalada de Queso de Cabra y Remolacha */
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Remolacha','Remolacha',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Remolacha','Queso de cabra',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Queso de Cabra y Remolacha','Lechuga',50,'g');

/* 9) Tortilla de Queso de Cabra y Cebolla */
CALL InsertarIngredienteEnReceta('Tortilla de Queso de Cabra y Cebolla','Huevo',2,'unidad');
CALL InsertarIngredienteEnReceta('Tortilla de Queso de Cabra y Cebolla','Queso de cabra',40,'g');
CALL InsertarIngredienteEnReceta('Tortilla de Queso de Cabra y Cebolla','Cebolla',1,'unidad');

/* 10) Sopa de Queso de Cabra y Acelga */
CALL InsertarIngredienteEnReceta('Sopa de Queso de Cabra y Acelga','Acelga',150,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso de Cabra y Acelga','Queso de cabra',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Queso de Cabra y Acelga','Caldo de verduras',500,'ml');


/* ---------- QUESO CABRALES ---------- */

/* 1) Tarta de Queso Cabrales y Nueces */
CALL InsertarIngredienteEnReceta('Tarta de Queso Cabrales y Nueces','Base de masa',1,'base');
CALL InsertarIngredienteEnReceta('Tarta de Queso Cabrales y Nueces','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Tarta de Queso Cabrales y Nueces','Nueces',20,'g');

/* 2) Ensalada de Pera, Cabrales y Nueces */
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Cabrales y Nueces','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Cabrales y Nueces','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Ensalada de Pera, Cabrales y Nueces','Nueces',20,'g');

/* 3) Croquetas de Cabrales y Jamón */
CALL InsertarIngredienteEnReceta('Croquetas de Cabrales y Jamón','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Cabrales y Jamón','Jamón serrano',40,'g');
CALL InsertarIngredienteEnReceta('Croquetas de Cabrales y Jamón','Patata',100,'g');

/* 4) Pollo al Cabrales con Puré de Patatas */
CALL InsertarIngredienteEnReceta('Pollo al Cabrales con Puré de Patatas','Pollo',200,'g');
CALL InsertarIngredienteEnReceta('Pollo al Cabrales con Puré de Patatas','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Pollo al Cabrales con Puré de Patatas','Patata',150,'g');

/* 5) Pasta con Cabrales y Espinacas */
CALL InsertarIngredienteEnReceta('Pasta con Cabrales y Espinacas','Pasta',100,'g');
CALL InsertarIngredienteEnReceta('Pasta con Cabrales y Espinacas','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Pasta con Cabrales y Espinacas','Espinacas',50,'g');

/* 6) Sopa de Cabrales y Setas */
CALL InsertarIngredienteEnReceta('Sopa de Cabrales y Setas','Setas',100,'g');
CALL InsertarIngredienteEnReceta('Sopa de Cabrales y Setas','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Sopa de Cabrales y Setas','Caldo de verduras',500,'ml');

/* 7) Empanadas de Cabrales y Piquillos */
CALL InsertarIngredienteEnReceta('Empanadas de Cabrales y Piquillos','Masa de empanada',1,'unidad');
CALL InsertarIngredienteEnReceta('Empanadas de Cabrales y Piquillos','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Empanadas de Cabrales y Piquillos','Pimientos del piquillo',2,'unidad');

/* 8) Brochetas de Ternera con Cabrales */
CALL InsertarIngredienteEnReceta('Brochetas de Ternera con Cabrales','Carne de ternera',150,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Ternera con Cabrales','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Brochetas de Ternera con Cabrales','Pimiento',1,'unidad');

/* 9) Pizza de Cabrales, Pera y Jamón */
CALL InsertarIngredienteEnReceta('Pizza de Cabrales, Pera y Jamón','Base de pizza',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Cabrales, Pera y Jamón','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Pizza de Cabrales, Pera y Jamón','Pera',1,'unidad');
CALL InsertarIngredienteEnReceta('Pizza de Cabrales, Pera y Jamón','Jamón serrano',40,'g');

/* 10) Queso Cabrales a la Parrilla */
CALL InsertarIngredienteEnReceta('Queso Cabrales a la Parrilla','Queso Cabrales',40,'g');
CALL InsertarIngredienteEnReceta('Queso Cabrales a la Parrilla','Pan de campo',2,'rebanada');




SELECT VERSION();

/* 1. CLAVES ÚNICAS E ÍNDICES
   ───────────────────────── */
ALTER TABLE recetas
    ADD CONSTRAINT ux_recetas_nombre        UNIQUE (nombre);

ALTER TABLE ingredientes
    ADD CONSTRAINT ux_ingredientes_nombre   UNIQUE (nombre);

CREATE INDEX idx_ingredientes_nombre ON ingredientes (nombre);
CREATE INDEX idx_recetas_nombre     ON recetas     (nombre);
CREATE INDEX idx_ri_receta          ON receta_ingredientes (receta_id);
CREATE INDEX idx_ri_ingrediente     ON receta_ingredientes (ingrediente_id);



/* 2. TABLA DE UNIDADES
   ──────────────────── */
CREATE TABLE IF NOT EXISTS unidades (
    id            TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre        VARCHAR(20) NOT NULL UNIQUE,
    factor_gramos DECIMAL(10,4)        NULL       -- opcional (por si luego quieres convertir)
);

INSERT IGNORE INTO unidades (nombre, factor_gramos) VALUES
  ('g',      1),
  ('kg',   1000),
  ('ml',     1),
  ('l',   1000),
  ('unidad',NULL),
  ('cucharada', 10),
  ('cucharadita', 5);



/* 3. COLUMNA unidad_id EN receta_ingredientes
   ─────────────────────────────────────────── */
ALTER TABLE receta_ingredientes
    ADD COLUMN unidad_id TINYINT UNSIGNED NOT NULL
              AFTER cantidad;

ALTER TABLE receta_ingredientes
    ADD CONSTRAINT fk_ri_unidades
        FOREIGN KEY (unidad_id) REFERENCES unidades (id);



/* 4. PROCEDIMIENTO ALMACENADO SEGURO
   ────────────────────────────────── */
DELIMITER $$
CREATE OR REPLACE PROCEDURE sp_insert_receta_ingrediente(
        IN p_receta      VARCHAR(100),
        IN p_ingrediente VARCHAR(100),
        IN p_cantidad    DECIMAL(10,2),
        IN p_unidad      VARCHAR(20)
)
BEGIN
    DECLARE vRecetaId      INT;
    DECLARE vIngredienteId INT;
    DECLARE vUnidadId      TINYINT;

    SELECT id INTO vRecetaId      FROM recetas      WHERE nombre = p_receta      LIMIT 1;
    SELECT id INTO vIngredienteId FROM ingredientes WHERE nombre = p_ingrediente LIMIT 1;
    SELECT id INTO vUnidadId      FROM unidades     WHERE nombre = p_unidad      LIMIT 1;

    IF vRecetaId IS NULL OR vIngredienteId IS NULL OR vUnidadId IS NULL THEN
        SIGNAL SQLSTATE '45000'
               SET MESSAGE_TEXT = 'Receta, ingrediente o unidad inexistente';
    END IF;

    INSERT INTO receta_ingredientes (receta_id, ingrediente_id, cantidad, unidad_id)
    VALUES (vRecetaId, vIngredienteId, p_cantidad, vUnidadId);
END$$
DELIMITER ;



/* 5. VISTA DE RECETAS “LISTAS PARA USAR”
   ────────────────────────────────────── */
-- Para MySQL 8
CREATE OR REPLACE VIEW v_recetas_completas AS
SELECT r.id,
       r.nombre,
       GROUP_CONCAT(
           CONCAT(i.nombre, ' ', ri.cantidad, ' ', u.nombre)
           ORDER BY i.nombre
           SEPARATOR ', '
       ) AS ingredientes
FROM   recetas r
JOIN   receta_ingredientes ri ON ri.receta_id = r.id
JOIN   ingredientes       i   ON i.id  = ri.ingrediente_id
JOIN   unidades           u   ON u.id  = ri.unidad_id
GROUP  BY r.id, r.nombre;

-- Si usas MySQL 5.7, cámbialo por:
-- DROP VIEW IF EXISTS v_recetas_completas;
-- CREATE VIEW v_recetas_completas AS (…mismo SELECT…);



/* 6. COMMIT FINAL */
COMMIT;


SELECT DATABASE();


SELECT COUNT(*) AS cnt FROM receta_ingredientes;



