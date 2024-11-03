import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';
import 'package:myparaconnect/view/Client/drawerClient.dart';

class Factures extends StatefulWidget {
  Factures({Key? key}) : super(key: key);

  @override
  _FacturesState createState() => _FacturesState();
}

class _FacturesState extends State<Factures> {
  List<dynamic> facturesList = [];
  List<dynamic> filteredFacturesList = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadFactures();
  }

  Future<void> loadFactures() async {
    // Load the JSON data
    final String response = await rootBundle.loadString('assets/factures.json');
    final data = await json.decode(response);
    setState(() {
      facturesList = data; // Update the state with the loaded data
      filteredFacturesList = data; // Initialize the filtered list
    });
  }

  void _filterFactures(String query) {
    setState(() {
      searchQuery = query;
      filteredFacturesList = facturesList.where((facture) {
        return facture['Numero'].toString().toLowerCase().contains(query.toLowerCase()) ||
            facture['date'].toString().toLowerCase().contains(query.toLowerCase());
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
                  SizedBox(width: screenWidth * 0.01),
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
            Text("Mes factures", style: TextStyle(fontSize: 23)),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                SizedBox(width: width*0.02,),
                Container(

                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade900, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("20", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Text("Livraisons non facturées ", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                        ],
                      ),

                    // The icon


                    ],
                  ),
                ),
                SizedBox(width: width*0.02,),
                Container(



                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade900, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("65", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Container(

                            child: Text(" Solde Client", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),

                  // The icon


                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            // Search Field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: TextField(
                onChanged: _filterFactures,
                decoration: InputDecoration(
                  labelText: "Rechercher par numéro ou date",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Display the list of filtered invoices
            Expanded(
              child: ListView.builder(
                itemCount: filteredFacturesList.length,
                itemBuilder: (context, index) {
                  var facture = filteredFacturesList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      title: Text("Numéro: ${facture['Numero']}"),
                      subtitle: Row(
                        children: [
                          Container(
                            width:width*0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date: ${facture['date']}"),
                                Text("HT: ${facture['HT']}"),
                                Text("TVA: ${facture['TVA']}"),
                                Text("TTC: ${facture['TTC']}"),
                              ],
                            ),
                          ),
                          SizedBox(

                            width: width*0.02,
                          ),

                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Image.asset(

                                            'images/cap2.png', // Your image asset
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
                                  width: width*0.18,
                                 decoration: BoxDecoration(
                                   color: Colors.blue.shade900,
                                   borderRadius: BorderRadius.circular(5)
                                 ),
                                  child: Center(child: Text("Facture", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                ),
                              ),

                              SizedBox(height: height*0.025,),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Image.asset(

                                            'images/cap2.png', // Your image asset
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
                                  width: width*0.18,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade900,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(child: Text("Relevé", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                                ),
                              ),

                            ],
                          )



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
