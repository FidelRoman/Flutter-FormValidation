import 'package:flutter/material.dart';
import 'package:formvalidation/src/bloc/login_bloc.dart';


class Provider extends InheritedWidget{

  final loginBloc = LoginBloc();

  Provider({Key key, Widget child})
  : super(key: key, child: child);

  @override
  // Al actualizarce debe notificar a sus hijos?
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){

  // toma el contexto y busca un provider
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

}

  
