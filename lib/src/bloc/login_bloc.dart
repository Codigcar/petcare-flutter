import 'dart:async';

import 'package:petcare/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController =
      BehaviorSubject<String>(); /* StreamController<String>.broadcast(); */
  final _passwordController =
      BehaviorSubject<String>(); /* StreamController<String>.broadcast(); */

  // recuperar los datos del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validatorEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatorPassword);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // inserta valor al string
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // obtener el ultimo valor ingresado a los streams
  String get get_email => _emailController.value;
  String get get_password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
