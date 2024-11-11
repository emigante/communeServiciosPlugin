
import 'package:servicioscommune/controls/connection.dart';
import 'package:servicioscommune/models/proveedor.dart';
import 'package:servicioscommune/models/servicios.dart';
import 'package:servicioscommune/pages/detail/detail.dart';
import 'package:servicioscommune/widgets/columnBuilder.dart';
import 'package:flutter/material.dart';

class CardResultados extends StatefulWidget {
  Servicios servicios;
  CardResultados({super.key, required this.servicios});

  @override
  State<CardResultados> createState() => _CardResultadosState();
}

class _CardResultadosState extends State<CardResultados> {
  double w=0,h=0;
  Servicios? _servicios;
  DatabaseServices db = DatabaseServices();
  Proveedor? proveedor;

  @override
  void initState() {
    _servicios = widget.servicios;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
        width: w,
        height: h/2,
        child: Card(        
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Container(
              child: Image.network(_servicios?.galeria?.first.url.toString() ?? "", height: 160, fit: BoxFit.cover, width: w,),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5),
              child:
               Text(_servicios?.nombreServicio.toString() ?? "", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            ),
           
            
            Container(
              padding:const EdgeInsets.only(left: 10, top: 5),
              child: SizedBox()//Text(_servicios!.descripcion.toString().substring(0, 70)+ "..." , style: TextStyle(fontSize: 16),),
            ),
             _proveedor(),
             
            Container(
              alignment: Alignment.bottomRight,
              padding:const EdgeInsets.only(left: 10, top: 5, right: 15),
              child: Text((_servicios?.desde ?? false) ?
                ( "Precio desde \$" + _servicios!.precio.toString() ) 
                : ("Precio \$"+_servicios!.precio.toString()),
                style: TextStyle(fontSize: 18),),),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => DetailsPage(servicios: _servicios as Servicios,)),
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
          ]),
        ),
      
    );
  }

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
            margin: const EdgeInsets.only( left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [                                
                Container(
                  margin:  const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text("Proveedor: "+proveedor!.body.nombre.toString()),
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 0),
                //   child: Text(proveedor?.body.correo ?? ""),
                // )
                
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      });
  }
}