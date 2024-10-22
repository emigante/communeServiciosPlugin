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
  double w=0,h=0;

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Image.network(_servicios?.galeria?.first.url ?? "", width: w, fit: BoxFit.fitWidth,),
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
          _horarios()
        ],),
      ),
    );
  }

  _horarios(){
    List<Widget> list = [];

    list.add(
      Container(
          margin: EdgeInsets.only(top: 15),
          child: Text("Horarios disponibles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        )
    );
    _servicios?.agendas?.forEach((element) {
      list.add(
        Container(
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
              Text(element.horario.toString(), style: TextStyle(fontSize: 16),),
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
                    child: Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 16),),
                  ),
                ),
              ),
            ],
          ),
        )
      );
    });

    return Container(
      child: Column(
        children: list),
    );
  }
}