// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';
// Recibe un Json en forma de string y regresa una nueva instancia del modelo
ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));
// Toma el modelo y lo pasa por un json encode propio de dart:convert
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    ProductoModel({
        this.id,
        this.titulo = '',
        this.valor  = 0.0,
        this.disponible = true,
        this.fotoUrl,
    });
    // Regresa una nueva instancia del modelo
    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id            : json["id"],
        titulo        : json["titulo"],
        valor         : json["valor"],
        disponible    : json["disponible"],
        fotoUrl       : json["fotoUrl"],
    );
    // Toma el modelo y lo convierte a un json
    Map<String, dynamic> toJson() => {
        // Evitamos enviar el id:
        //"id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotoUrl": fotoUrl,
    };
}
