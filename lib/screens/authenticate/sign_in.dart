import 'package:flutter/material.dart';
import 'package:learn_it/screens/wrapper.dart';
import 'package:learn_it/services/auth.dart';
import 'package:learn_it/shared/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // For Auth Connection
  final AuthService _authService = AuthService();
  // For validation
  final _formKey = GlobalKey<FormState>();

  // For textfield
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(0, 74, 140, 1),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Image.asset(
                'assets/logo.png',
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text(
                "LEARN IT",
                style: TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (val) {
                          return val!.isEmpty ? 'Enter email Id' : null;
                        },
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Email Field
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (val) {
                          return val!.length < 6 ? 'Enter long password' : null;
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 350,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  Color.fromRGBO(0, 74, 140, 1), // background
                              onPrimary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius:
                                      BorderRadius.circular(15)), // foreground
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    _authService.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'could not sign in with those credentials';
                                  });
                                } else {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Wrapper()));
                                }
                              }
                            }),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Dont have an account?"),
                          Text("  SIGN UP",
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 74, 140, 1),
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(
                        height: 190,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}