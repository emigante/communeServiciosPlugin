
import 'package:http/http.dart' as http;
import 'package:servicioscommune/models/evento.dart';
import 'package:servicioscommune/models/horario.dart';
import 'package:servicioscommune/models/proveedor.dart';
import 'package:servicioscommune/models/reserva.dart';
import 'package:servicioscommune/models/servicios.dart';
import 'dart:convert';

import 'package:servicioscommune/models/tipoServicios.dart';



class DatabaseServices {
  //final FirebaseFirestore db = FirebaseFirestore.instance;

    Future<List<TipoServicios>> getCatalogoServicios() async {
    List<TipoServicios> lista = [];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/getcatalogos/api/getcatalogos";

    final response = await http.get(Uri.parse(url));

     try {
      if (response.statusCode == 200) {

        print(response.body);
        //final decodeData = json.decode(utf8.decode(response.bodyBytes));
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(TipoServicios.fromJsonService(dd));
        }
        

        
        print("Datos cargados");
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible get getEstadoDireccion at this time. Unexpected error:\n$e");
    }

    //https://us-central1-servicioscommune.cloudfunctions.net/getcatalogos/api/getcatalogos

    /*QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection('catalogoServicios')
        .get();

    for (var element in snap.docs) {
      lista.add(TipoServicios.fromJson(element));
    }*/

    return lista;
  }
  Future<List<Servicios>> getAllServicios() async {
    List<Servicios> lista = [];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/aall/api/getServicios";

    final response = await http.get(Uri.parse(url));

     try {
      if (response.statusCode == 200) {

        print(response.body);
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(Servicios.fromJson(dd));
        }        
        
        print("Datos cargados");
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible get getEstadoDireccion at this time. Unexpected error:\n$e");
    }
    return lista;
  }

  Future<List<Reserva>> getAllReservas(String idResidente) async {
    List<Reserva> lista = [];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/aall/api/getServicios";

    final response = await http.get(Uri.parse(url));

     try {
      if (response.statusCode == 200) {

        print(response.body);
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(Reserva.fromJson(dd));
        }        
        
        print("Datos cargados");
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible get getEstadoDireccion at this time. Unexpected error:\n$e");
    }
    return lista;
  }

  /**Future<List<Evento>> getEventos(String idProveedor) async {
    List<Evento> lista = [];

    QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection('eventos')
        .where("idProveedor", isEqualTo: idProveedor)
        //.where("estatus", isEqualTo: "3")
        //.limit(10)
        .get();

    //print(snap);

    for (var element in snap.docs) {
      print(element);
      Evento event = Evento.fromJson(element.data());
      //if (usuario.estatus != "3") {
      lista.add(event);
      //}
    }

    return lista;
  } */
  Future<List<Evento>> getEventos(String idProveedor) async {
    List<Evento> lista = [];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/eventos/api/getEventos/"+idProveedor;

    final response = await http.get(Uri.parse(url));

     try {
      if (response.statusCode == 200) {

        print(response.body);
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(Evento.fromJson(dd));
        }        
        
        print("Datos cargados");
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible get getEstadoDireccion at this time. Unexpected error:\n$e");
    }
    return lista;
  }

  Future<Proveedor?> getProveedor(String idProveedor) async {
    Proveedor? proveedor;

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/proveedores/api/get/";

    final response = await http.get(Uri.parse(url+idProveedor));

     try {
      if (response.statusCode == 200) {

        print(response.body);
        proveedor = Proveedor.fromJson(json.decode(response.body));
        
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible get getEstadoDireccion at this time. Unexpected error:\n$e");
    }
    return proveedor;
  }

  Future<String?> saveReserva(Reserva reserva) async {
    Reserva? proveedor;
    final bdy = jsonEncode(reserva.toJson());
    String url = "https://us-central1-servicioscommune.cloudfunctions.net/reservaa/api/saveReserva";
    print(reserva.toJson());

   Map<String,String> headers = {'Content-Type': 'application/json'};


    final response = await http.post(Uri.parse(url),headers:headers, body:bdy,);

     try {
      if (response.statusCode == 200) {

        print(response.body);
        //proveedor = Proveedor.fromJson(json.decode(response.body));

        
      } else {
        print(" service status code: ${response.body}");
      }
    } catch (e) {
      print(
          "Is not possible save reserva at this time. Unexpected error:\n$e");
      return "500";
      
    }
    return "200";
  }

  Future<List<Horario>?> getHorariosByProveedor(String idProveedor, String fecha) async {
    List<Horario> lista =[];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/eventos/api/getHorasDisponibles/${idProveedor}/${fecha}";

    final response = await http.get(Uri.parse(url));

    print(response.request);

     try {
      if (response.statusCode == 200) {

        print(response.body);
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(Horario.fromJson(dd));
        }        
      }
    } catch (e) {
      print(
          "Is not possible get horarios at this time. Unexpected error:\n$e");
    }
    return lista;
  }
  Future<List<Reserva>?> getReservas(String idProveedor) async {
    List<Reserva> lista =[];

    String url = "https://us-central1-servicioscommune.cloudfunctions.net/reservaas/api/getReservas/${idProveedor}";

    final response = await http.get(Uri.parse(url));

    print(response.request);

     try {
      if (response.statusCode == 200) {

        print(response.body);
        final List<dynamic> decodeData =
            json.decode(utf8.decode(response.bodyBytes));

        
        for (var val in decodeData) {
          final dd = ((val));
          
          lista.add(Reserva.fromJson(dd));
        }        
      }
    } catch (e) {
      print(
          "Is not possible get horarios at this time. Unexpected error:\n$e");
    }
    return lista;
  }


}