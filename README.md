
🎵 Spotify Clone - Laboratorio 4

Este proyecto es una aplicación móvil desarrollada en Flutter que replica algunas funcionalidades de Spotify, permitiendo a los usuarios:

Ver nuevos lanzamientos de álbumes.

Buscar artistas y ver sus canciones.

Explorar y reproducir playlists almacenadas en el backend.

Consultar los tracks de una playlist específica.

Cambiar entre modo oscuro y claro en la configuración.

La aplicación se conecta a la API de Spotify para obtener datos en tiempo real y gestionar las playlists de usuario.

🚀 Tecnologías Utilizadas

📱 Frontend (Flutter/Dart)

Flutter: Framework de desarrollo multiplataforma.

Dart: Lenguaje de programación utilizado en Flutter.

Provider: Manejo del estado global.

Carousel Slider: Implementación de carruseles para mostrar playlists.

http: Para realizar peticiones HTTP a la API de Spotify.

flutter_dotenv: Para manejar variables de entorno como claves de API.



🖥️ Backend (Node.js/Express)

Node.js: Entorno de ejecución del backend.

Express.js: Framework para la gestión de rutas y API REST.

spotify-web-api-node: SDK para interactuar con la API de Spotify.

Axios: Cliente HTTP para realizar peticiones a Spotify.

dotenv: Manejo de variables de entorno.

FS (File System): Para almacenar playlists en archivos JSON.

🔑 Autenticación con Spotify

El sistema maneja dos tipos de autenticación:

Client Credentials: Para acceder a información pública como álbumes y artistas.

Authorization Code Flow: Para autenticar a usuarios y acceder a sus playlists privadas.

El backend gestiona la generación y actualización automática de tokens de acceso para evitar expiraciones frecuentes.
