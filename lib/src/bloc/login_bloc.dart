import 'dart:async';
import 'package:formvalidation/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {

  // BehaviorSubject no necesita de un broadcast
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

 
  // Recuperar los datos del Stream
 // Stream<String> este rio lo que contiene son Strings
 Stream<String> get emailStream => _emailController.stream.transform(validarEmail); 
 Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
 
 Stream<bool> get formValidStream => 
 CombineLatestStream.combine2(emailStream, passwordStream,(e,p) => true);
 // Insertar valors al Stream
 // sin paréntesis es referencia, con () es ejecución:
 Function(String) get changeEmail => _emailController.sink.add;
 Function(String) get changePassword => _passwordController.sink.add;

 // Obtener el último valor ingresado a los streams
 String get email => _emailController.value;
 String get password => _passwordController.value;


  dispose(){
    // ? se usa para evitar que si es nulo no ejecute el close
    _emailController?.close();
    _passwordController?.close();
  }

}