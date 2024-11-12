
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/reserva.dart';
import 'package:servicioscommune/pages/reserva/reservaDetail.dart';
import 'package:servicioscommune/widgets/columnBuilder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReservaPage extends StatefulWidget {
  const ReservaPage({super.key});

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  DatabaseServices _db = DatabaseServices();
  List<Reserva>? _reservasList = [];
  double w=0, h=0;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Text("Listado de reservas", style: TextStyle(fontSize: 22),),
          ),
          _reservas()
        ]),
      ),
    );
  }

  Widget _reservas(){
     return FutureBuilder(
        future: _db.getReservas("1U0oeAT9VTTsWfcIy0kh1PlhCe12_aqua_1"),
        builder: (c, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          _reservasList = snapshot.data;
          if(_reservasList != []){
            return SingleChildScrollView(
              child: ColumnBuilder(
                itemCount: _reservasList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      
                      _cardReserva(_reservasList![index])
                    ]),
                  );
                }
              ));
          }else{
            return SizedBox();
          }
          
        });
  }

  _cardReserva(Reserva _reserva){
    return Container(
      width: w,
      
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReservaDetail(reserva: _reserva)),
          );
        },
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text("Reserva: "+_reserva.status.toString(), style: TextStyle(fontSize: 18),),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Fecha y hora:  "+_reserva.fecha.toString() +" "+_reserva.hora.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Residencial: "+ _reserva.idFraccionamiento.toString().toUpperCase(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            
          ]),
        ),
      ),
    );
  }
}