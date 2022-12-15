# Flutter Chanllenge

Desafío de Flutter.

## Instrucciones de instalación

Para correrlo desde código, se puede seguir los siguientes comandos

```sh
git clone https://github.com/marventu94/flutter_challenge.git
cd flutter_challenge
flutter run
```

También se puede instalar el apk ya compilado. Se encuentra en la carpeta raiz con nombre de **app.apk**.

## Estructura de carpetas

- Core: los elementos básicos que se comparten para toda la App
- Features: Son las funcionalidad de la aplicaciones. En este caso, un home, una sección de posteos y otra de usuarios.

## Arquitectura

Para realizar el desafío se siguió el patrón de diseño: **Clean Architecture**.

La idea de este patrón es separar la lógica de la aplicación, de donde proviene la información y la interfaz de usuario. De esta manera, al estar todo desacoplado, es muy sencillo reemplazar cualquier de estas partes sin dañar al resto.

Para su implementación es necesario tres carpetas para cada funcionalidad (feature). A continuación se brinda más detalles sobre las mismas.

### Domain

Lógica de la aplicación. Esta capa no debe depender de nadie más.Su tres sub carpetas son:

- Entities: se encuentran las clases que definen los objetos que vamos a manejar en nuestra App
- Usecases: lista y justifica las necesidades de la features 
- Repositories: El puente entre Domain y Data

### Data

De donde proviene la información que maneja la aplicación. Sus sub carpetas son:

- Repositories: permite la comunicación con el Domain
- Models: Define las clases de los objetos que provienen de las APIs. Puede diferir de las Entities de Domain.
- Datasources: De donde viene la información. Puede ser de internet o local


### Display

La interfaz de usuario (UI) de la aplicación. Sus sub carpetas son:

- Pages: Widgets que define la pantalla
- Widgets: Define los widgets que se utilizan en las pantallas
- Provider: Manejador de estados que nos va a permitir accionar la lógica

## Dependencias

- provider: ^6.0.2
- shared_preferences: ^2.0.13
- dartz: ^0.10.1
- data_connection_checker_tv: ^0.3.5-nullsafety
- dio: ^4.0.4
- equatable: ^2.0.3