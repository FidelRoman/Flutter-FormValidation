import 'dart:async';

class LogicBloc {

  // broadcasta hace que se pueda escuchar por varias personas
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

 
 // Recuperar los datos del Stream
 // Stream<String> este rio lo que contiene son Strings
 Stream<String> get emailStream => _emailController.stream; 
 Stream<String> get passwordStream => _passwordController.stream;
 
 // Insertar valors al Stream
 // sin paréntesis es referencia, con () es ejecución:
 Function(String) get changeEmail => _emailController.sink.add;
 Function(String) get changePassword => _passwordController.sink.add;

  dispose(){
    // ? se usa para evitar que si es nulo no ejecute el close
    _emailController?.close();
    _passwordController?.close();
  }

}