import 'package:fixyourprint/screens/RegisterScreen.dart';
import 'package:fixyourprint/screens/WelcomeScreen.dart';
import 'package:fixyourprint/services/AuthService.dart';
import 'package:fixyourprint/widgets/CustomButton.dart';
import 'package:fixyourprint/widgets/FormField.dart';
import 'package:fixyourprint/widgets/TapText.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool _obscureText = true;
  String token = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  loginUser() {
    setState(() {
      _isLoading = true;
    });
    AuthService().loginUser(email, password).then((value) {
      token = value;
      print(token);
      if (token != '') {
        _isLoading = false;
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: WelcomeScreen(token: token),
                type: PageTransitionType.fade));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                          width: 300,
                          child: Image.asset(
                            'assets/login/leafv3.png',
                            fit: BoxFit.contain,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "Sign in to Continue.",
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      FormFieldWidget(
                          labelText: 'email',
                          onChanged: (value) {
                            email = value;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(
                        height: 25,
                      ),
                      FormFieldWidget(
                        labelText: 'password',
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onPressed: () {
                          loginUser();
                        },
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New user?',
                            style: TextStyle(fontSize: 15),
                          ),
                          TapText(
                            tapText: ' Sign up Here!',
                            nextScreen: RegisterScreen(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
