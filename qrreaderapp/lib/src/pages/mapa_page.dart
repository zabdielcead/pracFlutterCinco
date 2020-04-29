import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';
class MapaPage extends StatefulWidget {
  
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final  map = new MapController();

  String tipoMapa = 'dark'; 
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =  ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
                      icon: Icon(Icons.my_location), 
                      onPressed: () {
                          map.move(scan.getLatlng(), 15);
                      }
                    )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
                      mapController: map,
                      options: MapOptions(
                        center:scan.getLatlng(),
                        zoom: 10
                        
                      ),
                      layers: [
                        
                        _crearMapa(),
                        _crearMarcadores(scan)
                      ],
                    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoiemFiZGllbGNlYWQiLCJhIjoiY2s5ZWhyZjNwMDJmejNocWIyb2tjYzIzbSJ9.vLEW1C4X33fXrOCegqiZ7w',
        'id': 'mapbox.$tipoMapa' // streets, dark, light, outdoors, satellite,   tipos de mapas
      }
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatlng(),
          builder: (contex) => Container(
            child: Icon(Icons.location_on, size:70, color: Theme.of(contex).primaryColor)
          )
          
        )
      ]
    );

  }

  Widget _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
             child: Icon(Icons.repeat),
             backgroundColor: Theme.of(context).primaryColor,
             onPressed: () {
               print('entro factionbutton'+ tipoMapa);
                if(tipoMapa == 'streets'){
                  tipoMapa = 'dark';
                }else if(tipoMapa == 'dark') {
                  tipoMapa = 'light';
                }
                else if(tipoMapa == 'light') {
                  tipoMapa = 'outdoors';
                }
                else if(tipoMapa == 'outdoors') {
                  tipoMapa = 'satellite';
                }else {
                   tipoMapa = 'streets';
                }
               

                setState(() {
                  
                });
             },
            );
  }
}