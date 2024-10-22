import 'package:flutter/material.dart';
import 'package:servicioscommune/models/servicios.dart';

class DetailsPage extends StatefulWidget {
  Servicios servicios;
  DetailsPage({super.key, required this.servicios});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Servicios? _servicios;

  @override
  void initState() {
    _servicios = widget.servicios;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Image.network(_servicios?.galeria?.first.url ?? ""),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Text(_servicios?.nombreServicio.toString() ?? "" ,
             style: const TextStyle(fontSize:18, fontWeight: FontWeight.bold ),)
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Text(_servicios?.descripcion.toString() ?? "",
              //"Tenemos el equipo necesario para atender todo tipo de requerimientos, ya sea a nivel residencial o comercial. Acudimos a diversos negocios como hoteles, hospitales, gimnasios, restaurantes, oficinas, consultorios, talleres y otros sitios que soliciten el servicio de plomería en general, siempre manejando los mejores precios del mercado.",
             style: TextStyle(fontSize:16 ), textAlign: TextAlign.justify,)
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Text("Ofrecemos una amplia variedad de servicios")
          ),
        ],),
      ),
    );
  }
}