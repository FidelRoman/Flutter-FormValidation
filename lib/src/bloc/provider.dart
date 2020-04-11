import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';
export 'package:formvalidation/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{

  static Provider _instancia;

  // La idea del factory es determinar si necesito regresar 
  // una nueva instancia de la clase o utilizar la existente
  factory Provider({Key key, Widget child}) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;

  }
  // Obtiene argumentos y los envia al factory
  Provider._internal({Key key, Widget child})
   : super(key: key, child: child);

  // En un hot reload aquí perdemos la información, por que se crea de nuevo
  // Solución: crear un singleton
  final loginBloc = LoginBloc();

  // Provider({Key key, Widget child})
  // : super(key: key, child: child);

  @override
  // Al actualizarce debe notificar a sus hijos?
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){

  // toma el contexto y busca un provider
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}

  
