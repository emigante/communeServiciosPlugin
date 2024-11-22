import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/horario.dart';
import 'package:servicioscommune/models/reserva.dart';
import 'package:servicioscommune/models/reserva.dart' as gale;
import 'package:servicioscommune/models/servicios.dart';
import 'package:servicioscommune/pages/home.dart';
import 'package:servicioscommune/widgets/gallery.dart';
import 'package:servicioscommune/widgets/splashProvider.dart';
import 'package:servicioscommune/widgets/textfielborder.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FormReserva extends StatefulWidget {
  Servicios servicios;
  Horario horario;
  String fecha;
  String idResidente;
  int idLote;
  String idFraccionamiento;
  String nombreResidente;
  String direccion;
  FormReserva({super.key, required this.servicios, required this.fecha, required this.horario, 
    required this.idFraccionamiento, required this.idLote, required this.idResidente,
    required this.direccion, required this.nombreResidente
  });

  @override
  State<FormReserva> createState() => _FormReservaState();
}

class _FormReservaState extends State<FormReserva> {
  final TextEditingController _descripcion = TextEditingController();
  List<File> listaImagenes = [];
  bool typePhoto = false;
  final picker = ImagePicker();
  String? urlPhoto;
  String? urlPhotoId;
  double w = 0, h =0;
  
  DatabaseServices _db = DatabaseServices();
  
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    
    
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoadingProvider>(
            create: (_) => LoadingProvider(),
          ),
        ],
      child: Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Datos de reserva", style: TextStyle(fontSize: 18),), centerTitle: true,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(        
        child: Column(children: [
          _resumen(),        
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
              child: const Text(
                "Descripción del problema",
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF2d4e3d)),
              ),
            ),
           Padding(
              padding:const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                minLines: 6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                controller:  _descripcion,
                decoration: InputDecoration(
                  //prefixIcon: prefixIcon,
                  filled: true,
                  enabled: true,
                  labelText: "Escriba los detalles del problema",
                  fillColor: Colors.white,
                  hintText: "",
                  enabledBorder: border(false),
                  focusedBorder: border(true),
                  border: border(false),
                ),
                
                maxLines: null,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
              child: const Text(
                "Fotos del problema",
                style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF2d4e3d)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: const Text(
                "Te recomendamos fotos donde se aprecie bien el problema",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Galery(list: (l) {
              setState(() {
                listaImagenes = l;
              });
              
            }),

            Container(
              child: InkWell(
              onTap: () async{        
                try{
                  //Provider.of<LoadingProvider>(context, listen: false).setLoad(true);
                  Reserva? _reserva = Reserva();
                  
                  _reserva.descripcion = _descripcion.text;
                  _reserva.fecha = widget.fecha;
                  _reserva.hora = widget.horario.hora;
                  _reserva.idFraccionamiento = widget.idFraccionamiento;
                  _reserva.idProveedor =  widget.servicios.idProveedor;
                  _reserva.idResidente =  widget.idResidente;
                  _reserva.idServicio = widget.servicios.id;
                  _reserva.nombreResidente = widget.nombreResidente;
                  _reserva.direccion = widget.direccion;
                  _reserva.nombreServicio = widget.servicios.nombreServicio.toString();
                  //_reserva.idTrabajador = "njdnd";
                  _reserva.idlote = "255";
                  var uuid = Uuid();
                  var id = uuid.v1();
                  _reserva.id =id;
                  _reserva.status = "Creada";
                  _reserva.galeria = [];

                  List<gale.Galeria> galery = [];
                  
                   listaImagenes.forEach((element) {
                    print(element);
                    print("aqui***");
                    List<int> imageBytes = element.readAsBytesSync();
                    String base64Image = base64Encode(imageBytes); 
                    print(base64Image);
                    gale.Galeria gal =  gale.Galeria(id: "aaa", url: base64Image);
                    galery.add(gal);
                    
                    
                  });
                  _reserva.galeria = galery;

                  /*List<int> imageBytes = file.readAsBytesSync();
                  String base64Image = base64Encode(imageBytes); */

                  final resp = await _db.saveReserva(_reserva);

                  if(resp == "200"){
                    Fluttertoast.showToast(
                    msg: 'Se ha guardado la reserva',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey[800],
                    );
                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (context) => HomePage(
                        idFraccionamiento: widget.idFraccionamiento, idLote: widget.idLote, idResidente: widget.idResidente, 
                        direccion: widget.direccion, nombreResidente: widget.nombreResidente)),
                    );
                    return;
                  }

                  //Provider.of<LoadingProvider>(context, listen: false).setLoad(false);
                  
                  

                }catch(ex){
                  Fluttertoast.showToast(
                    msg: 'Ocurrió un error, intentar de nuevo',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey[800],
                    );
                  print(ex);
                }



              },
              child: Container(
                width: w/2,
                margin: EdgeInsets.only(top: 30, bottom: 10),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                  color: Colors.blue,                    
                  borderRadius: BorderRadius.all(
                      Radius.circular(25.0) //                 <--- border radius here
                  ),
                ),
                child: Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
              ),
            ),
          ),

        ]),
      ),
    ));
  }

  _resumen(){
    return Container(
      width: w,            
      child: Card(
        margin: const EdgeInsets.only(left:15, right: 15, top: 20, bottom: 20),
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),              
              child: Text("Servicio: "+ widget.servicios.nombreServicio.toString(), 
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),  
              child: Text("Fecha: "+ widget.fecha, style: const TextStyle(fontSize: 16),),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),  
              child: Text("Hora: "+ widget.horario.hora, style: const TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );

  }
}