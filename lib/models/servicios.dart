// To parse this JSON data, do
//
//     final servicios = serviciosFromJson(jsonString);

import 'dart:convert';

List<Servicios> serviciosFromJson(String str) => List<Servicios>.from(json.decode(str).map((x) => Servicios.fromJson(x)));

String serviciosToJson(List<Servicios> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Servicios {
    String? nombreServicio;
    String? descripcion;
    int? precio;
    bool? desde;
    List<Agenda>? agendas;
    String? idProveedor;
    List<Agenda>? categorias;
    List<Galeria>? galeria;
    bool? activo;

    Servicios({
        this.nombreServicio,
        this.descripcion,
        this.precio,
        this.desde,
        this.agendas,
        this.idProveedor,
        this.categorias,
        this.galeria,
        this.activo,
    });

    factory Servicios.fromJson(Map<String, dynamic> json) => Servicios(
        nombreServicio: json["nombreServicio"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        desde: json["desde"],
        agendas: json["agendas"] == null ? [] : List<Agenda>.from(json["agendas"]!.map((x) => Agenda.fromJson(x))),
        idProveedor: json["idProveedor"],
        categorias: json["categorias"] == null ? [] : List<Agenda>.from(json["categorias"]!.map((x) => Agenda.fromJson(x))),
        galeria: json["galeria"] == null ? [] : List<Galeria>.from(json["galeria"]!.map((x) => Galeria.fromJson(x))),
        activo: json["activo"],
    );

    Map<String, dynamic> toJson() => {
        "nombreServicio": nombreServicio,
        "descripcion": descripcion,
        "precio": precio,
        "desde": desde,
        "agendas": agendas == null ? [] : List<dynamic>.from(agendas!.map((x) => x.toJson())),
        "idProveedor": idProveedor,
        "categorias": categorias == null ? [] : List<dynamic>.from(categorias!.map((x) => x.toJson())),
        "galeria": galeria == null ? [] : List<dynamic>.from(galeria!.map((x) => x.toJson())),
        "activo": activo,
    };
}

class Agenda {
    String id;

    Agenda({
        required this.id,
    });

    factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
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
