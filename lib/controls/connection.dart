import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicioscommune/models/tipoServicios.dart';

class DatabaseServices {
  final FirebaseFirestore db = FirebaseFirestore.instance;

    Future<List<TipoServicios>> getCatalogoServicios() async {
    List<TipoServicios> lista = [];

    QuerySnapshot<Map<String, dynamic>> snap = await db
        .collection('catalogoServicios')
        .get();

    for (var element in snap.docs) {
      lista.add(TipoServicios.fromJson(element));
    }

    return lista;
  }


}