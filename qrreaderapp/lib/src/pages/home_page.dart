import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

                }
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(), // crear lo tabs
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor, // obtenemos el primary color que modificamos en main.dart
      ),
    );
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