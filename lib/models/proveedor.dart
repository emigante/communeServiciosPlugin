// To parse this JSON data, do
//
//     final proveedor = proveedorFromJson(jsonString);

import 'dart:convert';

Proveedor proveedorFromJson(String str) => Proveedor.fromJson(json.decode(str));

String proveedorToJson(Proveedor data) => json.encode(data.toJson());

class Proveedor {
    int status;
    Body body;

    Proveedor({
        required this.status,
        required this.body,
    });

    factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
        status: json["status"],
        body: Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "body": body.toJson(),
    };
}

class Body {
    String? correo;
    String? fotourl;
    String? telefono;
    String? nombre;
    String? rfc;

    Body({
         this.correo,
         this.fotourl,
         this.telefono,
         this.nombre,
         this.rfc,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        correo: json["correo"],
        fotourl: json["fotourl"],
        telefono: json["telefono"],
        nombre: json["nombre"],
        rfc: json["rfc"],
    );

    Map<String, dynamic> toJson() => {
        "correo": correo,
        "fotourl": fotourl,
        "telefono": telefono,
        "nombre": nombre,
        "rfc": rfc,
    };
}
