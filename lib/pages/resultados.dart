import 'package:flutter/material.dart';
import 'package:servicioscommune/widgets/cardResultados.dart';

class ResultadosPage extends StatefulWidget {
  const ResultadosPage({super.key});

  @override
  State<ResultadosPage> createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  double w=0,h=0;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(child: Text("Plomeria", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),),
          CardResultados(),
          CardResultados(),
        ]),
      ),

    );
  }
}