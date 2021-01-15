import 'dart:convert';

import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/models/User.dart';
import 'package:farm_app/services/fetch_farmer_response.dart';
import 'package:farm_app/views/FarmPage.dart';
import 'package:farm_app/views/OnBoardFarmerScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    implements FetchFarmerCallBack {
  //current user
  User user;
  List<Farmer> _farmers = [];

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FetchFarmerResponse _response;

  _DashboardScreenState() {
    _response = new FetchFarmerResponse(this);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchFarmers();
  }

  void fetchFarmers() {
    setState(() {
      _response.doFetching();
    });
  }

  void getCurrentUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map json = jsonDecode(pref.getString('currentUser'));
    setState(() {
      user = User.fromJson(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 70),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user != null ? "Hi, " + user.username : "Hi,",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Welcome back!",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 80),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "List of all farmers",
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              "add farmer",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnBoardFarmerScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.64,
                    child: ListView.builder(
                        itemCount: _farmers!= null ? _farmers.length: 0,
                        itemBuilder: (context, index) {
                          return buildFarmer(context, _farmers[index]);
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildFarmer(BuildContext context, Farmer farmer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 300,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  title: Text(
                    farmer.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(farmer.phone),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.remove_red_eye),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "View",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        onTap: () {
           Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FarmPage(
          farmer: farmer,
        )),
      );
        },
      ),
    );
  }

  @override
  void onDataFetched(List<Farmer> farmers) {
    // TODO: implement onDataFetched
    setState(() {
      _farmers = farmers;
    });
  }

  @override
  void onFetchError(String error) {
    // TODO: implement onFetchError
  }
}
