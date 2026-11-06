Actúa como un desarrollador experto en .NET 8 (Minimal APIs), C#, SQL Server y Front-End (HTML5, CSS3, JavaScript con diseño cibernético/hacker). 

Estamos construyendo una aplicación web llamada "Sistema Robot / Carrito 360" que se conecta a una base de datos SQL Server. A continuación te detallo el estado actual del proyecto:

1. ESTRUCTURA DE ARCHIVOS (en la carpeta wwwroot y la raíz):
   - Program.cs: Servidor backend en .NET con Minimal APIs. Configura CORS, archivos estáticos, la ruta raíz (que redirige al Home), el endpoint GET para listar usuarios (/api/usuarios), el endpoint POST de registro (/api/usuarios), y el endpoint POST de inicio de sesión (/api/login) que valida con SQL Server.
   - wwwroot/index.html (Home): Menú principal con diseño futurista/hacker (fondo oscuro, rejillas cibernéticas, efectos láser y botones con brillo de neón al hacer hover). Muestra dinámicamente un menú público (Login, Registro, Ayuda) o un menú privado si el usuario ha iniciado sesión (Consultar Usuarios, Ayuda, Salir) validando con el `localStorage`. Incluye además una ventana modal emergente con un personaje robótico animado ("Asistente Virtual K-9") que explica el propósito del sistema y la advertencia de iniciar sesión o registrarse.
   - wwwroot/login.html: Pantalla de inicio de sesión conectada a la API, que al ser exitosa guarda la sesión en el navegador (`localStorage`) y redirige al Home.
   - wwwroot/registro.html: Pantalla de registro de nuevas unidades con validación de contraseñas e ID automático.
   - wwwroot/usuarios.html: Página de consulta protegida que lista todos los usuarios almacenados en la base de datos en una tabla con la misma estética visual.

2. OBJETIVO DEL SISTEMA:
   - El núcleo del sistema controla un carrito inteligente que toma fotografías en 360 grados en tiempo real y las almacena en la base de datos SQL Server.
   - Requiere autenticación previa (iniciar sesión o registrarse) para acceder a las opciones de consulta.

Por favor, ten en cuenta esta arquitectura y diseño estético (neón, Orbitron/Rajdhani, look cibernético/robótico) para cualquier nueva funcionalidad, mejora o ajuste que te pida a partir de ahora. ¿Has comprendido el contexto del proyecto?


Estamos desarrollando un sistema web de gestión de fotos 360° con una estética cibernética/hacker (neones, fuentes Orbitron/Rajdhani, fondo de rejilla), integrado en un backend de .NET 8 con Minimal APIs y SQL Server.

Estado actual del proyecto:
- El frontend cuenta con index.html (autenticación y menú protegido por localStorage con la llave 'usuarioLogueado'), login.html y registro.html conectados al backend.
- La interfaz de gestión de fotos 360° (wwwroot/fotos360.html) está funcionando actualmente en modo local (utilizando localStorage y Base64 para una entrega rápida sin depender de la base de datos).
- El Program.cs está limpio, configurado con CORS, archivos estáticos y los endpoints funcionales de /api/login y /api/usuarios.

Objetivo para retomar:
Quiero volver a integrar el módulo de Fotos 360° con el backend de .NET 8 y la base de datos SQL Server (tabla Fotos360 con tipo nativo GEOGRAPHY para coordenadas GPS y VARBINARY(MAX) para la imagen), utilizando la librería MetadataExtractor para leer automáticamente la fecha EXIF y las coordenadas GPS al subir las imágenes mediante un formulario multipart/form-data.
