// Se encarga de hacer las interacciones directas con mi base de datos
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:mime_type/mime_type.dart';

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


  Future<bool> editarProducto( ProductoModel producto) async {

    final url = '$_url/productos/${producto.id}.json';

    final resp = await http.put(url, body: productoModelToJson(producto));
    // producto.toJson envía un Json, pero firebase pide un string

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }


  Future<List<ProductoModel>> cargarProductos() async{

    final url = '$_url/productos.json'; 

    final resp = await http.get(url);
    
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if (decodedData == null) return [];

    decodedData.forEach((id, prod){

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      
      productos.add(prodTemp);

    });

    // print( productos[0].id);
    return productos;
  }

  Future<int> borrarProducto( String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen( File imagen) async {
    //xw3zrwjc
    final url = Uri.parse('https://api.cloudinary.com/v1_1/flutter123465/image/upload?upload_preset=xw3zrwjc');
    final mimeType = mime(imagen.path).split('/'); //imagen/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );
  
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salió mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }

}