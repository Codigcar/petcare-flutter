
import 'dart:async';

import 'package:petcare/src/bloc/validators.dart';

class LoginBloc with Validators {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  // recuperar los datos del stream
  Stream<String> get emailStream => _emailController.stream.transform(validatorEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatorPassword);


  // inserta valor al string
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  dispose() {
    _emailController?.close();
    _passwordController?.close();

  }
} 