// To parse this JSON data, do
//
//     final horario = horarioFromJson(jsonString);

import 'dart:convert';

List<Horario> horarioFromJson(String str) => List<Horario>.from(json.decode(str).map((x) => Horario.fromJson(x)));

String horarioToJson(List<Horario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Horario {
    int id;
    String hora;

    Horario({
        required this.id,
        required this.hora,
    });

    factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        id: json["id"],
        hora: json["hora"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hora": hora,
    };
}
