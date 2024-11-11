
import 'package:flutter/material.dart';
import 'package:servicioscommune/columnBuilder.dart';
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/horario.dart';
import 'package:servicioscommune/models/proveedor.dart';
import 'package:servicioscommune/models/servicios.dart';
import 'package:servicioscommune/pages/detail/calendar.dart';
import 'package:servicioscommune/pages/detail/formReserva.dart';
import 'package:intl/intl.dart';



class DetailsPage extends StatefulWidget {
  Servicios servicios;
  String idResidente;
  int idLote;
  String idFraccionamiento;
  DetailsPage({super.key,required this.servicios, required this.idFraccionamiento, required this.idLote, required this.idResidente});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Servicios? _servicios;
  double w=0,h=0;
  DatabaseServices db = DatabaseServices();
  Proveedor? proveedor;
  List<Horario>? lista;
  DateTime dt =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);
  String? fecha;

  @override
  void initState() {
    fecha = DateFormat('dd-MM-yyyy').format(dt);
    _servicios = widget.servicios;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Image.network(_servicios?.galeria?.first.url ?? "", width: w, fit: BoxFit.fitWidth, height: 200,),
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
          _proveedor(),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Text("Precios desde \$"+_servicios!.precio.toString(),
              //"Tenemos el equipo necesario para atender todo tipo de requerimientos, ya sea a nivel residencial o comercial. Acudimos a diversos negocios como hoteles, hospitales, gimnasios, restaurantes, oficinas, consultorios, talleres y otros sitios que soliciten el servicio de plomería en general, siempre manejando los mejores precios del mercado.",
             style: TextStyle(fontSize:18 ), textAlign: TextAlign.justify,)
          ), 
          _fechas(),   
          _horarios(),    
          Container(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => CalendarPage(servicios: _servicios as Servicios,)),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                    color: Colors.blue,                    
                    borderRadius: BorderRadius.all(
                        Radius.circular(25.0) //                 <--- border radius here
                    ),
                  ),
                  child: Text("Ver más", style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              ),
            ),
        ],),
      ),
    );
  }

   _fechas() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: TextButton(
        onPressed: () {
          _calend();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Fecha " + DateFormat('dd-MM-yyyy').format(dt),//DateFormat.yMEd('es_MX').format(dt),
              style: const TextStyle(color: Color(0xFF003C91), fontSize: 18),
            ),
            const Icon(
              Icons.expand_more,
              color: Color(0xFF003C91),
            )
          ],
        ),
      ),
    );
  }

  _calend() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dt,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day+1),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 8));

    if (picked != null && picked != dt) {
      setState(() {
        dt = picked;
        fecha = DateFormat('dd-MM-yyyy').format(dt);
      });
    }
  }

  _horarios(){
     return FutureBuilder(
      future: db.getHorariosByProveedor(_servicios?.idProveedor.toString() ?? "",fecha.toString() ),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snap.hasData) {         
          lista = snap.data;                    
          return ColumnBuilder(
            itemCount: lista!.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                padding:const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3.0
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(5.0) //                 <--- border radius here
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(lista?[index].hora.toString() ?? "", style: TextStyle(fontSize: 16),),
                    Container(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                              MaterialPageRoute(builder: (context) => 
                                FormReserva(servicios: _servicios as Servicios, 
                                   horario: lista?[index] as Horario, fecha: fecha.toString(), 
                                    idFraccionamiento: widget.idFraccionamiento, idLote: widget.idLote, idResidente: widget.idResidente,)
                              ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            color: Colors.blue,                    
                            borderRadius: BorderRadius.all(
                                Radius.circular(25.0) //                 <--- border radius here
                            ),
                          ),
                          child: Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
        } else {
          return const SizedBox();
        }
      });
  }

  // _horarios(){
  //   List<Widget> list = [];

  //   list.add(
  //     Container(
  //         margin: EdgeInsets.only(top: 15),
  //         child: Text("Horarios disponibles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
  //       )
  //   );
  //   _servicios?.agendas?.forEach((element) {
  //     list.add(
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
  //         padding:const EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           border: Border.all(
  //             width: 3.0
  //           ),
  //           borderRadius: const BorderRadius.all(
  //               Radius.circular(5.0) //                 <--- border radius here
  //           ),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             Text(element.horario.toString(), style: TextStyle(fontSize: 16),),
  //             Container(
  //               child: InkWell(
  //                 onTap: (){
  //                   Navigator.push(
  //                     context,
  //                       MaterialPageRoute(builder: (context) => FormReserva()),
  //                   );
  //                 },
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 10, bottom: 10),
  //                   padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
  //                   decoration: const BoxDecoration(
  //                     color: Colors.blue,                    
  //                     borderRadius: BorderRadius.all(
  //                         Radius.circular(25.0) //                 <--- border radius here
  //                     ),
  //                   ),
  //                   child: Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 16),),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     );
  //   });

  //   return Container(
  //     child: Column(
  //       children: list),
  //   );
  // }

  _proveedor(){
     return FutureBuilder(
      future: db.getProveedor(_servicios?.idProveedor.toString() ?? ""),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snap.hasData) {         
          proveedor = snap.data;                    
          return Container(
            margin: const EdgeInsets.only( left: 15, top: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [                                
                Container(
                  margin:  const EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  child: Text("Proveedor", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin:  const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text("Nombre: "+proveedor!.body.nombre.toString(), style: TextStyle(fontSize: 16),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Text("Correo electrónico: "+proveedor!.body.correo.toString(), style: TextStyle(fontSize: 16)),
                )
                
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      });
  }
}