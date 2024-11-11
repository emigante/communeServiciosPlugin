// To parse this JSON data, do
//
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Evento eventoFromJson(String str) => Evento.fromJson(json.decode(str));

String eventoToJson(Evento data) => json.encode(data.toJson());

class Evento {
    String? id;
    String? idProveedor;
    String? asunto;
    String? fecha;
    String? idTrabajador;
    String? horainicio;
    String? horafin;
    Colorevent? colorevent;

    Evento({
        this.id,
        this.idProveedor,
        this.asunto,
        this.fecha,
        this.idTrabajador,
        this.horainicio,
        this.horafin,
        this.colorevent,
    });

    Color toColor(){
      return Color.fromARGB(colorevent!.a!, colorevent!.r!, colorevent!.g!, colorevent!.b!);
    }

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        id: json["id"],
        idProveedor: json["idProveedor"],
        asunto: json["asunto"],
        fecha: json["fecha"],
        horainicio: json["horainicio"],
        idTrabajador: json["idTrabajador"],
        horafin: json["horafin"],
        colorevent: json["colorevent"] == null ? null : Colorevent.fromJson(json["colorevent"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idProveedor": idProveedor,
        "asunto": asunto,
        "fecha": fecha,
        "idTrabajador": idTrabajador,
        "horainicio": horainicio,
        "horafin": horafin,
        "colorevent": colorevent?.toJson(),
    };
}

class Colorevent {
    int? a;
    int? r;
    int? g;
    int? b;

    Colorevent({
        this.a,
        this.r,
        this.g,
        this.b,
    });

    factory Colorevent.fromJson(Map<String, dynamic> json) => Colorevent(
        a: json["a"],
        r: json["r"],
        g: json["g"],
        b: json["b"],
    );

    Map<String, dynamic> toJson() => {
        "a": a,
        "r": r,
        "g": g,
        "b": b,
    };
}
