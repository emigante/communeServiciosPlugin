
import 'package:flutter/material.dart';
import 'package:servicioscommune/pages/detail.dart';

class CardResultados extends StatefulWidget {
  const CardResultados({super.key});

  @override
  State<CardResultados> createState() => _CardResultadosState();
}

class _CardResultadosState extends State<CardResultados> {
  double w=0,h=0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
        width: w,
        height: h/2.3,
        child: Card(        
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Column(children: [
            Container(
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/servicioscommune.appspot.com/o/859.jpg?alt=media&token=b0c99711-79fc-429a-ad6a-389bcf878d9c"),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 5),
              child:
              const Text("Hermanos Perez", 
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5, left: 10),
              child:
              const Text("Proveedor: Juan Pérez", 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              padding:const EdgeInsets.only(left: 10, top: 5),
              child: const Text("Tenemos más de 10 años de experiencia en todo tipo de reparaciones"),),

            Container(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                      MaterialPageRoute(builder: (context) => const DetailsPage()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
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
}