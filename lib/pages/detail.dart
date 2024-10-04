import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Image.network("https://firebasestorage.googleapis.com/v0/b/servicioscommune.appspot.com/o/859.jpg?alt=media&token=b0c99711-79fc-429a-ad6a-389bcf878d9c"),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child:const Text("Hermanos Perez ",
             style: TextStyle(fontSize:18, fontWeight: FontWeight.bold ),)
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child:const Text("Tenemos el equipo necesario para atender todo tipo de requerimientos, ya sea a nivel residencial o comercial. Acudimos a diversos negocios como hoteles, hospitales, gimnasios, restaurantes, oficinas, consultorios, talleres y otros sitios que soliciten el servicio de plomería en general, siempre manejando los mejores precios del mercado.",
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