# Implementación de servicios de ubicación y mapas en Flutter

## Descripción
Esta aplicación móvil fue desarrollada en Flutter y tiene como objetivo integrar servicios de geolocalización del dispositivo (GPS) junto con la plataforma Google Maps.  
La app obtiene la ubicación actual del usuario, centra el mapa dinámicamente en dicha posición, coloca un marcador y dibuja una polilínea que representa una ruta entre dos puntos.

---

## Funcionalidades
- Obtención de la ubicación actual del dispositivo mediante GPS.
- Solicitud y validación de permisos de ubicación.
- Visualización de Google Maps centrado en la posición actual.
- Marcador en la ubicación del usuario con información descriptiva.
- Dibujo de una polilínea que representa una ruta entre un punto A y un punto B.

---

## Tecnologías utilizadas
- Flutter
- Dart
- google_maps_flutter
- geolocator
- Google Maps Platform

---

## Configuración de Google Cloud
Para el correcto funcionamiento de la aplicación se habilitaron las siguientes APIs en Google Cloud Console:
- Maps SDK for Android
- Maps SDK for iOS

La API Key **no se incluye en el repositorio** por motivos de seguridad.

---

## Ejecución del proyecto

1. Clonar el repositorio:
git clone <URL_DEL_REPOSITORIO>

2. Instalar dependencias: 
flutter pub get 
