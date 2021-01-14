import 'dart:convert';

import 'package:farm_app/models/User.dart';
import 'package:farm_app/services/login_response.dart';
import 'package:farm_app/views/DashBoard.dart';
import 'package:farm_app/views/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginCallBack {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginResponse _response;

  _LoginScreenState() {
    _response = new LoginResponse(this);
  }

  void _submit(String username, String password) {
    setState(() {
      _isLoading = true;
      _response.doLogin(username, password);
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backround.jpeg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Elias farming Services",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7315,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: Card(
                        elevation: 2.5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  controller: usernameController,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.green,
                                    ),
                                    hintText: "Username",
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.green,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  obscureText: _obscureText,
                                  controller: passwordController,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.green,
                                    ),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.green,
                                        ),
                                        onPressed: _toggle),
                                    hintText: "Password",
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          _isLoading ? "Please wait..." : "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        //login user
                        _submit(
                            usernameController.text, passwordController.text);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dont have an account?",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 1,
                                  child: Container(
                                    width: 65,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationScreen()),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async{
    if (user != null) {
      String currentUser = json.encode(user);
      SharedPreferences prefes = await SharedPreferences.getInstance();
          prefes.setString("currentUser", currentUser);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // TODO: implement onLoginSuccess
      _showSnackBar("Invalid credentials");
      setState(() {
        _isLoading = false;
      });
    }
  }
}
