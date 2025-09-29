import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Importa o pacote flutter_map
import 'package:latlong2/latlong.dart'; // Importa a classe LatLng (coordenadas)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa Atividade',
      home: const MapaPage(title: 'Lugares Favoritos'),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key, required this.title}) : super(key: key);

  final String title;
  State<MapaPage> createState() => _MapaPageState();
}
  
// Lista de todos os pontos
final markersPoints = [
  LatLng(-23.52755, -46.69387), // Senac
  LatLng(-23.9945, -46.2569), // Praia do Guarujá
  LatLng(-23.5236, -46.7106), // Última escola
  LatLng(-23.5618, -46.6932), // Trabalho
  LatLng(-23.5571, -46.6617), // Casa
];
final minLat = markersPoints
    .map((p) => p.latitude)
    .reduce((a, b) => a < b ? a : b);
final maxLat = markersPoints
    .map((p) => p.latitude)
    .reduce((a, b) => a > b ? a : b);
final minLng = markersPoints
    .map((p) => p.longitude)
    .reduce((a, b) => a < b ? a : b);
final maxLng = markersPoints
    .map((p) => p.longitude)
    .reduce((a, b) => a > b ? a : b);
// Calcular o centro médio

final centerLat = (minLat + maxLat) / 2;
final centerLng = (minLng + maxLng) / 2;

//^^^ Calculo pra centralizar tudo no meio sem usar o bounds que ta bugado
class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), //Barra do Titulo
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            centerLat,
            centerLng,
          ), //Latitude e Longitude do Senac
          initialZoom: 10.0, //Nivel de zoom
        ),
        children: [
          //Partes do Mapa
          TileLayer(
            //Mapa de Base
            urlTemplate:
                'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=FQnBdKFG3okoP4cXBwbq', //Mapa base tirado do Maptiler
            userAgentPackageName: 'com.example.app', //Identificador do app
            additionalOptions: {
              'referrer': 'https://github.com/PomboVascaino/Projetos',
            },
          ),
          MarkerLayer(
            //Os marcadores
            markers: [
              Marker(
                point: LatLng(-23.52755, -46.69387), //Posição do marcador Senac
                width: 80, //largura do marcador
                height: 80, //altura do marcador
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ), //Personalização do pino
              ),
              Marker(
                point: LatLng(
                  -23.9945,
                  -46.2569,
                ), //Posição do marcador da praia do Guarujá (onde eu vou estar final do ano)
                width: 80,
                height: 80,
                child: Icon(Icons.beach_access, color: Colors.blue, size: 40),
              ),
              Marker(
                point: LatLng(
                  -23.5236,
                  -46.7106,
                ), //Posição do marcador da ultima escola que eu estudei
                width: 80,
                height: 80,
                child: Icon(Icons.school, color: Colors.black, size: 40),
              ),
              Marker(
                point: LatLng(
                  -23.5618,
                  -46.6932,
                ), //Posição do marcador do meu trabalho
                width: 80,
                height: 80,
                child: Icon(Icons.work, color: Colors.purple, size: 40),
              ),
              Marker(
                point: LatLng(
                  -23.5571,
                  -46.6617,
                ), //Posição do estádio do Vasco (São Januario)
                width: 80,
                height: 80,
                child: Icon(Icons.house, color: Colors.green, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
