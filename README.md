
# 🎵 Cantaditas  

Cantaditas Remember es una aplicación móvil desarrollada en **Flutter** que te permite revivir la experiencia de las mejores sesiones musicales de antaño. La app ofrece una interfaz atractiva con imágenes y títulos representativos de cada sesión.

## 🚀 Funcionalidades

- 📚 **Múltiples Sesiones**: Acceso a diferentes sesiones musicales.
- 🖼️ **Imágenes Temáticas**: Cada botón de sesión incluye una imagen personalizada.
- 📝 **Títulos Representativos**: Títulos llamativos y relacionados con el contenido musical.
- 🎤 **Canta y graba tus sesiones**: Uitiliza cantaditas para cantar tus temazon en karaoke.
---

## 📸 Capturas de Pantalla

¡Añade aquí algunas imágenes de la app en funcionamiento! Esto ayuda a que otros usuarios se hagan una idea de la interfaz y funcionalidad.

```markdown
![Inicio](screenshots/inicio.png)
![Sesión 1](screenshots/sesion1.png)
```

---

## 🛠️ Instalación

Para ejecutar este proyecto en tu entorno local, sigue los siguientes pasos:

### Pre-requisitos

- [Flutter](https://docs.flutter.dev/get-started/install) instalado en tu máquina.
- Un editor de código como [Visual Studio Code](https://code.visualstudio.com/) o [Android Studio](https://developer.android.com/studio).

### Pasos

1. Clona el repositorio en tu máquina local:
    ```bash
    git clone https://github.com/tu_usuario/cantaditas_remember.git
    cd cantaditas_remember
    ```

2. Instala las dependencias:
    ```bash
    flutter pub get
    ```

3. Ejecuta la aplicación:
    ```bash
    flutter run
    ```

Si tienes más de un dispositivo conectado, especifica el dispositivo con:
```bash
flutter run -d nombre_dispositivo
```

---

## 📂 Estructura del Proyecto

```
lib/
│
├── main.dart             # Punto de entrada principal de la app
├── Sesion1.dart          # Pantalla de la sesión 1
├── Sesion2.dart          # Pantalla de la sesión 2
└── Sesion3.dart          # Pantalla de la sesión 3
```

---

## 📁 Recursos

Asegúrate de tener las imágenes necesarias en el directorio correcto:

```
assets/
└── images/
    ├── soda.jpg
    ├── el_ultimo.jpg
    └── remember.jpg
```

Si aún no lo has hecho, agrega las imágenes en el archivo `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/images/soda.jpg
    - assets/images/el_ultimo.jpg
    - assets/images/remember.jpg
```

---

## 📌 Navegación

La navegación entre pantallas se maneja utilizando:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SesionX()),
);
```

Donde `SesionX()` es el nombre de la pantalla a la que deseas navegar.

---

## 🛠️ Tecnologías Utilizadas

- **Flutter** - Framework para el desarrollo de aplicaciones móviles.
- **Dart** - Lenguaje de programación utilizado en Flutter.

---

## 🚀 Despliegue

Para generar un APK de producción, ejecuta:
```bash
flutter build apk --release
```

El APK se generará en:
```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 💡 Contribuciones

¡Las contribuciones son bienvenidas! Si deseas colaborar:
1. Haz un fork del proyecto.
2. Crea una nueva rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza los cambios y haz commit (`git commit -m 'Añadir nueva funcionalidad'`).
4. Envía tus cambios (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

---

## 📹 Video

Descubre como funciona:

- **Video**: https://youtu.be/AD5NtwvyIwQ

---

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más información.

---

## 🎉 Agradecimientos

A todos los amantes de la música remember y aquellos que mantienen viva la llama de los clásicos.
