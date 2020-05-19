import 'dart:math';

import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue[800],
                  Theme.of(context).primaryColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 80,
                    alignment: Alignment.center,
                    width: deviceSize.width * 0.9,
                    margin: EdgeInsets.all(20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    // ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            alignment: Alignment.center,
                            height: double.infinity,
                            child: Image.asset(
                              'assets/images/srmapsquare.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 30,
                            ),
                            alignment: Alignment.topLeft,
                            height: double.infinity,
                            child: Text(
                              'HOMS',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 53,
                                fontFamily: 'Raleway',
                                
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      // Log user in
    } else {
      // Sign user up
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 8.0,
      child: Container(
        alignment: Alignment.center,
        height: _authMode == AuthMode.Signup ? 450 : 360,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 420 : 320),
        width: deviceSize.width * 0.9,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                    },
                    onSaved: (value) {
                      _authData['email'] = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 50,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
