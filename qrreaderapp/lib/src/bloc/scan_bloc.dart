import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc with Validators{
 //toda esta forma es crear una sola instancia de scansbloc a lo largo de toda la aplicación sin importar que se haga new en varios lugares

 /*
 static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal(){
    // obtener scans de la base de datos
  }
}
  */

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal(){
    // obtener scans de la base de datos
    obtnerScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast(); //porque en varios lugares van escuchar el broadcast
 // escuchar eñ scanscontroller

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo); //escuchara el flujo de informacion de scnas controlle
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);


  dispose(){
    _scansController?.close();
  }

  agregarScan(ScanModel scan ) async{
      await DBProvider.db.nuevoScan(scan);
      obtnerScans();
  }

  //obtener la info de los scans
  obtnerScans() async{
      _scansController.sink.add(await DBProvider.db.getTodosScans());
  }

  borrarScan(int id) async{
    await DBProvider.db.deleteScan(id);
    obtnerScans();
  }
  borrarScanTODOS() async{
     await DBProvider.db.deleteAll();
     obtnerScans();
  }
}