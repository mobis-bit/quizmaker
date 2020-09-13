import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String name, email, password;

  AuthService authService = new AuthService();

  bool _isLoading = false;

  signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.signUpWithEmailAndPassword(email, password).then((val) {
        if (val != null) {
          setState(() {
            _isLoading = false;
          });
          HelperFunctions.saveUserLoggedIn(isLoggedIn: true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Name' : null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? 'Enter Email id' : null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      obscureText: true,
                      validator: (val) {
                        return val.isEmpty ? 'Enter password' : null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(height: 24),
                    GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: blueButton(context: context, label: 'Sign Up')),
                    SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In ",
                            style: TextStyle(
                              fontSize: 15.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
    );
  }
}
