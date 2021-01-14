import 'package:farm_app/models/User.dart';
import 'package:farm_app/services/registration_response.dart';
import 'package:farm_app/views/LoginScreen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    implements RegistrationCallback {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  RegistratinResponse _response;

  _RegistrationScreenState() {
    _response = new RegistratinResponse(this);
  }

  void _submit(User user) {
    setState(() {
      _isLoading = true;
      _response.doRegistration(user);
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
                  "Registration",
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
                          _isLoading ? "Please wait..." : "Register",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        //Register user
                        User user = User(
                            username: usernameController.text,
                            password: passwordController.text);
                        _submit(user);
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
                            "Already have an account?",
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
                                  "Sign in",
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
                              //
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
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
  void onRegistrationError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onRegistrationSuccess(int result) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    print("RESULTS:" + result.toString());
  }
}
