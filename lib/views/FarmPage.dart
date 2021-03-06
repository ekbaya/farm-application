import 'package:farm_app/models/Breed.dart';
import 'package:farm_app/models/Farmer.dart';
import 'package:farm_app/services/create_breed_response.dart';
import 'package:farm_app/services/fetch_breed_response.dart';
import 'package:farm_app/services/get_farmer_response.dart';
import 'package:farm_app/services/update_farmer_response.dart';
import 'package:farm_app/views/CalenderPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FarmPage extends StatefulWidget {
  Farmer farmer;
  FarmPage({this.farmer});
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage>
  implements BreedRegistrationCallback, FetchBreedCallBack , UpdationCallback,
  FarmerCallBack{
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final farmerNameController = TextEditingController();
  final farmerPhoneController = TextEditingController();
  final farmerCountryController = TextEditingController();

  Farmer _farmer;

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BreedRegistratinResponse _response;
  FetchBreedResponse response;
  UpdateFarmerResponse farmerResponse;
  GetFarmerResponse getFarmerResponse;

  List<Breed> _breeds = [];

  _FarmPageState() {
    getFarmerResponse = new GetFarmerResponse(this);
    _response = new BreedRegistratinResponse(this);
    response = new FetchBreedResponse(this);
    farmerResponse = new UpdateFarmerResponse(this);
  }

  void _submit(Breed breed) {
    setState(() {
      _response.doRegistration(breed);
    });
  }

  void getBreeds(String owner) {
    setState(() {
      response.doFetching(owner);
    });
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getFarmer(widget.farmer.id);
    getBreeds(widget.farmer.id.toString());
    super.initState();
  }

  void getFarmer(int id){
    //get the farmer from db instead
    getFarmerResponse.doFetchFarmer(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(_farmer!= null ?_farmer.name + "'s Farm Page":"Farm Page"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              switch (value) {
                case 'View Scheduled Visits':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CalenderPage(
                        farmer: widget.farmer,
                      ),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                'View Scheduled Visits',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
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
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(_farmer!= null ?_farmer.name:"",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14))
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 20,
                              ),
                              onTap: () {
                                farmerNameController.text = _farmer.name;
                                buildUpdateNameDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 30),
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(_farmer!= null?_farmer.phone:"",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14))
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 20,
                              ),
                              onTap: () {
                                farmerPhoneController.text = _farmer.phone;
                                buildUpdatePhoneDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 30),
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Country",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    Text(_farmer!=null?_farmer.country:"",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 14))
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 20,
                              ),
                              onTap: (){
                                farmerCountryController.text = _farmer.country;
                                buildUpdateCountryDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90, right: 30),
                        child: SizedBox(
                          height: 1,
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "List of all Breeds",
                              style: TextStyle(fontSize: 20),
                            ),
                            InkWell(
                              child: CircleAvatar(
                                radius: 20.0,
                                child: Icon(Icons.add),
                              ),
                              onTap: () {
                                buildInputShowDialog(context);
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'SL#',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Number',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              ...buildBreeds(_breeds != null ? _breeds : []),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> buildBreeds(List<Breed> breeds) {
    List<DataRow> dataRows = [];
    for (int i = 0; i < breeds.length; i++) {
      dataRows.add(buildDataRow(breeds[i], i));
    }

    return dataRows;
  }

  DataRow buildDataRow(Breed breed, int index) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(
          (index + 1).toString(),
        )),
        DataCell(Text(breed.name)),
        DataCell(Text(breed.number)),
      ],
    );
  }

  Future buildInputShowDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ), //this right here
            child: SingleChildScrollView(
              child: Container(
                width: width * 0.75,
                height: height * 0.40,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CREATE NEW BREED",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () => {
                              //CLOSE dialogue
                              Navigator.of(context).pop(),
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1.0),
                        ),
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          "Number",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1.0),
                        ),
                        child: TextField(
                          controller: numberController,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1)),
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: Center(
                                    child: Text(
                                  "Create a breed",
                                  style: TextStyle(color: Colors.white),
                                ))),
                            onTap: () async {
                              Navigator.of(context).pop();
                              //create Breed
                              Breed breed = Breed(
                                  owner: widget.farmer.id.toString(),
                                  name: nameController.text,
                                  number: numberController.text);

                              _submit(breed);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future buildUpdateNameDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ), //this right here
            child: SingleChildScrollView(
              child: Container(
                width: width * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UPDATE NAME",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () => {
                              //CLOSE dialogue
                              Navigator.of(context).pop(),
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          "Name",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1.0),
                        ),
                        child: TextField(
                          controller: farmerNameController,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1)),
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ))),
                            onTap: () async {
                              Navigator.of(context).pop();
                              //create Farmer
                              Farmer farmer = Farmer(
                                name: farmerNameController.text,
                                phone: _farmer.phone,
                                country: _farmer.country,
                              );
                              farmerResponse.doFarmerUpdation(farmer, widget.farmer.id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future buildUpdatePhoneDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ), //this right here
            child: SingleChildScrollView(
              child: Container(
                width: width * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UPDATE PHONE",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () => {
                              //CLOSE dialogue
                              Navigator.of(context).pop(),
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          "Phone",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1.0),
                        ),
                        child: TextField(
                          controller: farmerPhoneController,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1)),
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ))),
                            onTap: () async {
                               Navigator.of(context).pop();
                              //create Farmer
                              Farmer farmer = Farmer(
                                name: _farmer.name,
                                phone: farmerPhoneController.text,
                                country: _farmer.country,
                              );
                              farmerResponse.doFarmerUpdation(farmer, widget.farmer.id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future buildUpdateCountryDialog(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ), //this right here
            child: SingleChildScrollView(
              child: Container(
                width: width * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "UPDATE COUNTRY",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () => {
                              //CLOSE dialogue
                              Navigator.of(context).pop(),
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          "Country",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1.0),
                        ),
                        child: TextField(
                          controller: farmerCountryController,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1)),
                              child: Center(
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green),
                                child: Center(
                                    child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ))),
                            onTap: () async {
                               Navigator.of(context).pop();
                              //create Farmer
                              Farmer farmer = Farmer(
                                name: _farmer.name,
                                phone: _farmer.phone,
                                country: farmerCountryController.text,
                              );
                              farmerResponse.doFarmerUpdation(farmer, widget.farmer.id);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void onRegistrationError(String error) {
    // TODO: implement onRegistrationError
    _showSnackBar(error);
  }

  @override
  void onRegistrationSuccess(int result) {
    // TODO: implement onRegistrationSuccess
    print("ID*******************$result");
    setState(() {
      getBreeds(widget.farmer.id.toString());
    });
  }

  @override
  void onDataFetched(List<Breed> breeds) {
    // TODO: implement onDataFetched\
    setState(() {
      _breeds = breeds;
    });
  }

  @override
  void onFetchError(String error) {
    // TODO: implement onFetchError
  }

  @override
  void onError(String error) {
      // TODO: implement onError
    _showSnackBar(error);
      
    }
  
    @override
    void onSuccessUpdation(int result) {
    // TODO: implement onSuccessUpdation
    print("****************ROW AFFETCTED******************$result");
    getFarmer(widget.farmer.id);
  }

  @override
  void onFarmerReceived(Farmer farmer) {
      // TODO: implement onFarmerReceived
      setState(() {
        _farmer = farmer;
      });
    }
  
    @override
    void onFetchFarmerError(String error) {
    // TODO: implement onFetchFarmerError
  }
}
