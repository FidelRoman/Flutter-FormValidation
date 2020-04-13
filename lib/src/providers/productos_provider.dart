// Se encarga de hacer las interacciones directas con mi base de datos
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {

  final String _url = 'https://flutter-varios-76cce.firebaseio.com';

  Future<bool> crearProducto( ProductoModel producto) async {

    final url = '$_url/productos.json';

    final resp = await http.post(url, body: productoModelToJson(producto));
    // producto.toJson envía un Json, pero firebase pide un string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }
}