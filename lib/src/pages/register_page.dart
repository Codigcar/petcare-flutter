import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare/src/bloc/login_bloc.dart';
import 'package:petcare/src/bloc/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    final totalSize = MediaQuery.of(context).size;

    final backgroundPetCare = Container(
      height: totalSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(7, 103, 125, 1.0),
        Color.fromRGBO(46, 177, 185, 1.0),
      ])),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          /*  borderRadius: BorderRadius.circular(100.0), */
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: <Widget>[
        backgroundPetCare,
        Positioned(
          child: circle,
          top: 90.0,
          left: 30.0,
        ),
        Positioned(
          child: circle,
          top: -40.0,
          right: -30.0,
        ),
        Positioned(
          child: circle,
          bottom: -50.0,
          right: -10.0,
        ),
        Positioned(
          child: circle,
          bottom: 120.0,
          right: 20.0,
        ),
        Positioned(
          child: circle,
          bottom: -20.0,
          left: -20.0,
        ),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          width: double.infinity,
          height: 200.0,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.paw,
                color: Colors.white,
                size: 70.0,
              ),
              SizedBox(
                height: 10.0, /* , width: double.infinity, */
              ),
              Text(
                '¡Bienvenido a PetCare!',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final totalSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          Container(
            width: totalSize.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: <Widget>[
                Text('Registro', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _createEmail(bloc),
                SizedBox(height: 30.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('¿Ya tienes cuenta? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login')
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email,
                    color: Color.fromRGBO(46, 177, 185, 1.0)),
                hintText: 'example@mail.com',
                labelText: 'email',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline,
                      color: Color.fromRGBO(46, 177, 185, 1.0)),
                  labelText: 'password',
                  counterText: snapshot.data,
                  /* errorText: 'Contraseña inválido' */
                  errorText: snapshot.error),
              onChanged: bloc.changePassword,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0));
      },
    );
  }

  Widget _createButton( LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        return RaisedButton(
          child: Container(
            child: Text('Login'),
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          /* elevation: 0.0, */
          color: Color.fromRGBO(46, 177, 185, 1.0),
          textColor: Colors.white,
          onPressed: snapshot.hasData? () => _printDataEmailPassword(bloc, context) : null
        );

      },
    );
  }

  _printDataEmailPassword(LoginBloc bloc, BuildContext context) {
    print('===========');
    print('Email: ${ bloc.get_email }');
    print('Email: ${ bloc.get_password }');

    /* Navigator.pushNamed(context, 'home'); */
    Navigator.pushReplacementNamed(context, 'home');
  }
}
