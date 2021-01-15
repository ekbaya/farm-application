import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/services/farmer_registration_response.dart';
import 'package:farm_app/views/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class OnBoardFarmerScreen extends StatefulWidget {
  @override
  _OnBoardFarmerScreenState createState() => _OnBoardFarmerScreenState();
}

class _OnBoardFarmerScreenState extends State<OnBoardFarmerScreen> implements FarmerRegistrationCallback{
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  ///full Kenya sample.
  Country _selected = Country(
    asset: "assets/flags/ke_flag.png",
    dialingCode: "254",
    isoCode: "KE",
    name: "Kenya",
    currency: "Kenya Shillings",
    currencyISO: "KES",
  );

  bool _isLoading = false;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FarmerRegistratinResponse _response;

  _OnBoardFarmerScreenState() {
    _response = new FarmerRegistratinResponse(this);
  }

  void _submit(Farmer farmer) {
    setState(() {
      _isLoading = true;
      _response.doRegistration(farmer);
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
      appBar: AppBar(
        title: Text("Register new Farmer"),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: nameController,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    maxLines: null,
                    controller: phoneController,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Country",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey)),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryPicker(
                        showDialingCode: true,
                        onChanged: (Country country) {
                          setState(() {
                            _selected = country;
                          });

                          print("County Code:" + _selected.dialingCode);
                        },
                        selectedCountry: _selected,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    _isLoading?"Please wait...":"Create a Farmer",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                onTap: () {
                  //Create a farmer object
                  Farmer farmer = Farmer(
                    name: nameController.text,
                    phone: phoneController.text,
                    country: _selected.name
                  );

                  _submit(farmer);
                },
              ),
            ),
          )
        ],
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
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
    print("RESULTS:" + result.toString());
  }
}
