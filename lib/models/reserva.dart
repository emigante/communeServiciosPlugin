// To parse this JSON data, do
//
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class Reserva {
    String? id;
    String? idProveedor;
    String? idServicio;
    String? idResidente;
    String? idTrabajador;
    String? hora;
    String? idFraccionamiento;
    String? idlote;
    String? descripcion;
    String? fecha;
    String? status;
    String? nombreResidente;
    String? direccion;
    String? nombreServicio;
    List<Galeria>? galeria;


    Reserva({
        this.id,
        this.idProveedor,
        this.fecha,
        this.idTrabajador,
        this.descripcion,
        this.hora,
        this.idFraccionamiento,
        this.idResidente,
        this.idServicio,
        this.idlote,
        this.galeria,
        this.status,
        this.nombreResidente,
        this.nombreServicio,
        this.direccion
    });

    factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
        id: json["id"],
        idProveedor: json["idProveedor"],
        fecha: json["fecha"],
        idTrabajador: json["idTrabajador"],
        descripcion: json["descripcion"],
        hora: json["hora"],
        idFraccionamiento: json["idFraccionamiento"],
        idResidente: json["idResidente"],
        idServicio: json["idServicio"],
        idlote: json["idlote"],
        status: json["status"],
        direccion: json["direccion"],
        nombreResidente: json["nombreResidente"],
        nombreServicio: json["nombreServicio"],
        galeria: json["galeria"] == null ? [] : List<Galeria>.from(json["galeria"]!.map((x) => Galeria.fromJson(x))),
    );
    
    
    factory Reserva.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      Map data = doc.data();
      return Reserva(
          id: data["id"],
          idProveedor: data["idProveedor"],
          fecha: data["fecha"],
          idTrabajador: data["idTrabajador"],
          descripcion: data["descripcion"],
          hora: data["hora"],
          idFraccionamiento: data["idFraccionamiento"],
          idResidente: data["idResidente"],
          idServicio: data["idServicio"],
          idlote: data["idlote"],
          status: data["status"],
          direccion: data["direccion"],
          nombreResidente: data["nombreResidente"],
          nombreServicio: data["nombreServicio"],
          galeria: data["galeria"] == null ? [] : List<Galeria>.from(data["galeria"]!.map((x) => Galeria.fromJson(x))),
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "idProveedor": idProveedor,
        "fecha": fecha,
        "idTrabajador": idTrabajador,
        "descripcion": descripcion,
        "hora": hora,
        "idFraccionamiento": idFraccionamiento,
        "idResidente": idResidente,
        "idServicio": idServicio,
        "idlote": idlote,
        "status": status,
        "direccion": direccion,
        "nombreResidente": nombreResidente,
        "nombreServicio": nombreServicio,
        "galeria": galeria == null ? [] : List<dynamic>.from(galeria!.map((x) => x.toJson())),
    };
}
class Galeria {
    String id;
    String url;

    Galeria({
        required this.id,
        required this.url,
    });

    factory Galeria.fromJson(Map<String, dynamic> json) => Galeria(
        id: json["id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
    };
}
