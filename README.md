# Blog

Se quiere recrear un diseño para una página que muestra una lista de posteos estilo blog con fotos. Para obtener los posteos se tiene que utilizar la siguiente API de prueba de jsonplacehoder.

https://jsonplaceholder.typicode.com/posts

La página debe utilizar Widgets Material para los elementos. La estructura de la página es la siguiente:
- Título que diga “Blog” seguido de un subtítulo con cualquier texto de ejemplo.
- Un tab bar con 2 tabs, donde en el primer tab sea el principal.
- El tab principal deberá mostrar una lista de posts, implementando un scroll infinito para la carga.
- El segundo tab queda libre para agregar lo que se considere necesario.
- Al realizar un scroll sobre la pantalla principal, el tab bar debe quedar fijo en la parte superior desplazando al título y subtitulo.

Cualquier botón o elemento tapeable de la pantalla puede quedar con una función vacía al presionarse. Tomar cualquier imagen de ejemplo para el post.
El objetivo principal de la prueba es evaluar cómo se ve la página, como se comporta el scroll, la organización de archivos y la arquitectura seleccionada.
Tecnologías a usar:
- Flutter 3.24
- Dart 3.5
- Para el manejo de estado preferentemente usar BLoC en su versión 8.1.4.

> Primer tab se muestra los posts como menciona el ejercico, y el segundo como quedo libre se opto por mostrar los usuarios usando el endpoint jsonplaceholder.typicode.com/users 
