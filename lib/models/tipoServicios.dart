// To parse this JSON data, do
//
//     final qrModel = qrModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


TipoServicios qrModelFromJson(String str) => TipoServicios.fromJson(json.decode(str));

String qrModelToJson(TipoServicios data) => json.encode(data.toJson());

class TipoServicios {
    String? id;
    String? nombre;

    TipoServicios({
        this.id,
        this.nombre,
    });

    factory TipoServicios.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      Map data = doc.data();
        return TipoServicios(
          id: data["id"],
          nombre: data['nombre'] ?? '',
      );
    }
    factory TipoServicios.fromJsonService(Map<String, dynamic> data) {
      
        return TipoServicios(
          id: data["id"],
          nombre: data['nombre'] ?? '',
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
