
import 'package:flutter/material.dart';
import 'package:servicioscommune/columnBuilder.dart';
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/servicios.dart';
import 'package:servicioscommune/widgets/cardResultados.dart';

class ResultadosPage extends StatefulWidget {
  const ResultadosPage({super.key});

  @override
  State<ResultadosPage> createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  double w=0,h=0;
  DatabaseServices db = DatabaseServices();
  List<Servicios> _listaServicios = [];

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Text("Plomeria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
                    
          _getServicios()
        ]),
      ),

    );
  }

   _getServicios() {
    return FutureBuilder(
      future: db.getAllServicios(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snap.hasData) {
          if (_listaServicios.isEmpty) {
            _listaServicios = snap.data;
          }
          
          return ColumnBuilder(
            itemCount: _listaServicios.length,
            itemBuilder: (context, index) {              
              return CardResultados(servicios: _listaServicios[index]);
            });
        } else {
          return const SizedBox();
        }
      });
}
}