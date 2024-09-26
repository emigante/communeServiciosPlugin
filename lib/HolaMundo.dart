import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: Text("Hola mundo, este es un widget de un plugin externo")),
    );
  }
}
