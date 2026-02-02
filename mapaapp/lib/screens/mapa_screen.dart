import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapaScreen extends StatefulWidget {
  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Position? _posicion;
  final Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  Future<void> _obtenerUbicacion() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _mostrarMensaje("Activa el GPS");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _mostrarMensaje("Sin permiso no hay mapa 😢");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _mostrarMensaje("Permiso denegado permanentemente");
      return;
    }

    Position posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _posicion = posicion;
      _crearMarcador();
      _crearPolilinea();
    });
  }

  void _crearMarcador() {
    _markers.add(
      Marker(
        markerId: MarkerId("actual"),
        position: LatLng(_posicion!.latitude, _posicion!.longitude),
        infoWindow: InfoWindow(title: "Tu ubicación actual"),
      ),
    );
  }

  void _crearPolilinea() {
    LatLng universidad = LatLng(-4.0079, -79.2113); // ejemplo Loja

    _polylines.add(
      Polyline(
        polylineId: PolylineId("ruta"),
        points: [
          LatLng(_posicion!.latitude, _posicion!.longitude),
          universidad,
        ],
        width: 4,
      ),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  Widget build(BuildContext context) {
    if (_posicion == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Mapa")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Mapa")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_posicion!.latitude, _posicion!.longitude),
          zoom: 16,
        ),
        myLocationEnabled: true,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (controller) => _controller.complete(controller),
      ),
    );
  }
}
