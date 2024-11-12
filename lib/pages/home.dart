import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:servicioscommune/columnBuilder.dart';
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/firebase_options.dart';
import 'package:servicioscommune/models/tipoServicios.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servicioscommune/pages/reserva/reservaPage.dart';
import 'package:servicioscommune/pages/resultados.dart';



class HomePage extends StatefulWidget {
  String idResidente;
  int idLote;
  String idFraccionamiento;
  HomePage({super.key, required this.idFraccionamiento, required this.idLote, required this.idResidente});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseServices db = DatabaseServices();
  List<TipoServicios> _tipoServiciosList = [];
  TipoServicios? _tipoElegido;

  @override
  void initState() {
    //inicio();
    super.initState();
  }

  // inicio() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     name: "servicioscommune",
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReservaPage()),
              );

            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(FontAwesomeIcons.calendar)),
          )
        ],
      ),
      body: SingleChildScrollView(                
        child: Column(children: [          
          Container(
            margin: const EdgeInsets.only(top: 10, left: 15),
            child: const Text("¿Qué servicio estas buscando?", style: TextStyle(fontSize: 22),),
          ),
          _dropCatalogo(),
        ]),
      ),
    );
  }

  _dropCatalogo() {
    return FutureBuilder(
      future: db.getCatalogoServicios(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snap.hasData) {
          if (_tipoServiciosList.isEmpty) {
            _tipoServiciosList = snap.data;
          }
          if (_tipoElegido == null || _tipoElegido?.nombre == null) {
            _tipoElegido = _tipoServiciosList.first;
          }
          return ColumnBuilder(
            itemCount: _tipoServiciosList.length,
            itemBuilder: (context, index) {

              
              return ListTile(
                title: Text(_tipoServiciosList[index].nombre.toString(), style: TextStyle(fontSize: 18),),
                onTap: (){
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) =>  ResultadosPage(idFraccionamiento: widget.idFraccionamiento, idLote: widget.idLote, idResidente: widget.idResidente,)),
                  );

                },
              );
            });
        } else {
          return const SizedBox();
        }
      });
}
}