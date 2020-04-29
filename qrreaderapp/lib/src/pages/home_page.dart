import 'dart:io';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/bloc/scan_bloc.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;


class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR SCANNER'),
        actions: <Widget>[
          IconButton(
                icon: Icon(Icons.delete_forever), 
                onPressed: (){
                  scansBloc.borrarScanTODOS;//manda la referencia () por eso se quita los parentesis hast que presione el usuario
                }
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(), // crear lo tabs
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed:() => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor, // obtenemos el primary color que modificamos en main.dart
      ),
    );
  }

  _scanQR(BuildContext context) async{ // escaneo
    print('scanqr.....');
    // generador de qr  https://www.qrcode.es/es/generador-qr-code/
    //leer scanear qr codigos de barra https://pub.dev/packages/barcode_scan#-installing-tab-
    // https://www.facebook.com
    // geo:40.724233047051705,-74.00731459101564

    /*
      instalacion sqflite
      https://pub.dev/packages/sqflite#-installing-tab-  

      direccion donde se encuentra el archivo de la base datos
      instalacion path_provider
      https://pub.dev/packages/path_provider#-installing-tab-
    */



    String futureString;
     try {
       futureString = await BarcodeScanner.scan();
     }catch(e){
       futureString = e.toString();
     }
     print('Future String: $futureString');
     if(futureString != null){
        print('Tenemos Inofrmacion');
     }
     if( futureString != null ){
       final scan = ScanModel(valor: futureString);
       scansBloc.agregarScan(scan);
      // final scan2 = ScanModel(valor: 'geo:40.724233047051705,-74.00731459101564');
      // scansBloc.agregarScan(scan2);
       if(Platform.isIOS) {
            Future.delayed(Duration(milliseconds: 750), () {
                utils.abrirScan(context,scan);
            });
       }else {
          utils.abrirScan(context, scan);
       }
       
     }


     // se instalara la url launcher para que cuando se aprieteel geo o la pagina y abrira la aplicaion respectiva tel, sms, url

  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex, // nos dice que elemento esta activo
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        }, // evento que cuando lo toca lo dispara
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Mapas')
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5),
            title: Text('Direcciones')
          ),
        ],
    );
  }

  Widget _callPage(int paginaActual) {
    switch ( paginaActual ) {
      case 0:        
        return MapasPage();        
      case 1:        
        return DireccionesPage();        
      default:
        return MapasPage();
    }
  }
}