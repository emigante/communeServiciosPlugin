import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicioscommune/models/tipoServicios.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class DatabaseServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

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

    return lista;
  }


}