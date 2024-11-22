import 'dart:convert';

import 'package:servicioscommune/models/reserva.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReservaDetail extends StatefulWidget {
  Reserva reserva;
  ReservaDetail({ required this.reserva});

  @override
  State<ReservaDetail> createState() => _ReservaDetailState();
}

class _ReservaDetailState extends State<ReservaDetail> {
  double w = 0, h=0;
  Reserva? _reserva;
  @override
  void initState() {
    _reserva = widget.reserva;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Detalle de la reserva", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Fecha y hora:  "+_reserva!.nombreServicio.toString() +" "+_reserva!.hora.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Fecha y hora:  "+_reserva!.fecha.toString() +" "+_reserva!.hora.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
               Container(
                padding: EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Reserva: "+_reserva!.status.toString(), style: TextStyle(fontSize: 18),),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Residencial: "+ _reserva!.idFraccionamiento.toString().toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Nombre del residente: "+ _reserva!.nombreResidente.toString().toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Dirección: ${_reserva?.direccion}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                alignment: Alignment.centerLeft,
                child: Text("Descripción del problema: ${_reserva?.descripcion}",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              
              Container(
                padding: EdgeInsets.only(top: 15, bottom: 25),
                alignment: Alignment.centerLeft,
                child: Text("Fotos: ", style: TextStyle(fontSize: 18),),
              ),
              _fotos(),
            ],
          ),
        ),
      ),
    );
  }

   _fotos(){
    List<Widget> _list = [];

    _reserva!.galeria?.forEach((element) {
      if(element.url.contains("firebasestorage")){
        _list.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: w/2,
          child: Image.network(element.url, fit: BoxFit.cover,),

        ));
      }else{
        _list.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: w/1.5,
          child: Image.memory(
              base64Decode(element.url),
              fit: BoxFit.cover,
            )
        ));
      }
      
    });
    return Column(children: _list,);
  }
}