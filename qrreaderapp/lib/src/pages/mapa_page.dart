import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';
class MapaPage extends StatelessWidget {
  

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

                      }
                    )
        ],
      ),
      body: _crearFlutterMap(scan)
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
                      options: MapOptions(
                        center:scan.getLatlng(),
                        zoom: 10
                      ),
                      layers: [
                        _crearMapa(),
                      ],
                    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken' : 'pk.eyJ1IjoiemFiZGllbGNlYWQiLCJhIjoiY2s5ZWhyZjNwMDJmejNocWIyb2tjYzIzbSJ9.vLEW1C4X33fXrOCegqiZ7w',
        'id': 'mapbox.streets'
      }
    );
  }
}