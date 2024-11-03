import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';
import 'package:myparaconnect/view/Client/drawerClient.dart';

class Achats extends StatefulWidget {
  Achats({Key? key}) : super(key: key);

  @override
  _AchatsState createState() => _AchatsState();
}

class _AchatsState extends State<Achats> {
  List<dynamic> achatsList = [];
  List<dynamic> filteredAchatsList = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadAchats();
  }

  Future<void> loadAchats() async {
    // Load the JSON data
    final String response = await rootBundle.loadString('assets/achats.json');
    final data = await json.decode(response);
    setState(() {
      achatsList = data; // Update the state with the loaded data
      filteredAchatsList = data; // Initialize the filtered list
    });
  }

  void _filterAchats(String query) {
    setState(() {
      searchQuery = query;
      filteredAchatsList = achatsList.where((achat) {
        return achat['BL/Avoir'].toString().toLowerCase().contains(query.toLowerCase()) ||
            achat['date'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Row(
          children: [
            Container(
              height: screenHeight * 0.05,
              width: screenWidth * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Text(
                  "Responsable Général",
                  style: TextStyle(
                    fontSize: screenWidth * 0.042,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Container(
              height: screenHeight * 0.045,
              width: screenWidth * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.02),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey.shade100,
                    child: Icon(Icons.person, size: 25, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(child: MyDrawerClient()),
      body: Center(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.88,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text("Mes Achats", style: TextStyle(fontSize: 29)),
            SizedBox(height: screenHeight * 0.02),
            // Search Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextField(
                onChanged: _filterAchats,
                decoration: InputDecoration(
                  labelText: "Rechercher par BL/Avoir ou date",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Display the list of filtered purchases
            Expanded(
              child: ListView.builder(
                itemCount: filteredAchatsList.length,
                itemBuilder: (context, index) {
                  var achat = filteredAchatsList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text("BL/Avoir:"),
                      GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Image.asset(

                                      'images/achat.png', // Your image asset
                                      width: width*0.75, // Adjust width as needed
                                      height: height*0.8, // Adjust height as needed
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 3), // Duration for the snackbar
                              ),
                            );
                          },

                            child: Container(
                                width: width*0.23,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    borderRadius: BorderRadius.circular(5)
                                ),

                                child: Center(child: Text(" ${achat['BL/Avoir']}", style: TextStyle(color: Colors.white),))),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date: ${achat['date']}"),
                          Text("HT: ${achat['HT']}"),
                          Text("TVA: ${achat['TVA']}"),
                          Text("TTC: ${achat['TTC']}"),
                          Text("État: ${achat['Etat']}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
