# Blockchain App in Dart

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Una aplicación de blockchain en Dart que muestra un listado de criptomonedas famosas, utiliza conceptos avanzados como la clase `Either`, paquetes como `json_annotation` y `freezed`, y se integra con **WebSockets** para recibir actualizaciones en tiempo real.

## Características

-   **Listado de Criptos**: Muestra un listado de algunas de las criptomonedas más famosas.
-   **Clase Either**: Implementa la clase `Either` para manejar resultados que pueden ser un éxito o un error de manera funcional.
-   **Uso de `json_annotation` y `freezed`**: Utiliza los paquetes `json_annotation` y `freezed` para generar código boilerplate automáticamente, como serialización/deserialización de JSON y clases inmutables.
-   **WebSockets**: Integra WebSockets para recibir actualizaciones en tiempo real sobre precios o transacciones de criptomonedas.

## Requisitos

-   Dart SDK (versión 3.6.2 o superior)
-   Flutter (versión 3.27.0 o superior)
-   Git (opcional, para clonar el repositorio)

## Instalación

1. Clona el repositorio:

    ```bash
    git clone https://github.com/tu-usuario/blockchain_new.git
    cd blockchain_new

    ```

2. Ejecutar los comandos:

    ```bash
    flutter pub get
    dart run build_runner build -d

    ```

3. Corre el proyecto:

    ```bash
    flutter run
    ```
