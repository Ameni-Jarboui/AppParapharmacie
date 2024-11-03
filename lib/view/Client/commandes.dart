import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';
import 'package:myparaconnect/view/Client/drawerClient.dart';

class Commande extends StatefulWidget {
  Commande({Key? key}) : super(key: key);

  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
  List<dynamic> commandes = [];
  List<dynamic> filteredCommandes = [];
  TextEditingController searchController = TextEditingController();
  bool showImage = false;
  @override
  void initState() {
    super.initState();
    loadCommandeData(); // Load data when the widget is initialized
  }

  Future<void> loadCommandeData() async {
    final String response = await rootBundle.loadString('assets/commande.json');
    final data = await json.decode(response);
    setState(() {
      commandes = data; // Store the parsed data
      filteredCommandes = commandes; // Initialize filtered list
    });
  }
  void toggleImageVisibility() {
    setState(() {
      showImage = !showImage; // Toggle the visibility of the image
    });
  }

  void filterCommandes(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCommandes = commandes; // Reset to original list
      });
    } else {
      setState(() {
        filteredCommandes = commandes.where((commande) {
          return commande["NCommande"].toString().contains(query) ||
              commande["NLivraison"].toString().contains(query) ||
              commande["Statut"].toString().toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
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
              height: height * 0.05,
              width: width * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Text(
                  "Responsable Général ",
                  style: TextStyle(
                    fontSize: width * 0.042,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
            Container(
              height: height * 0.045,
              width: width * 0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  SizedBox(width: width * 0.02),
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
              height: height * 0.1,
              width: width * 0.88,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/img.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                SizedBox(width: width*0.02,),
                Container(

                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("1", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Text("En préparation ", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Container(

                          width: width*0.12,
                          child: Icon(Icons.timelapse, color: Colors.red , size: width*0.1,)), // The icon


                    ],
                  ),
                ),
                SizedBox(width: width*0.02,),
                Container(



                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("6", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Container(

                            child: Text("Commande Prête", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),

                      Container(

                          width: width*0.12,
                          child: Icon(Icons.document_scanner_rounded, color: Colors.yellow , size: width*0.1,)), // The icon


                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.01,),
            Row(
              children: [
                SizedBox(width: width*0.02,),
                Container(

                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent.shade700, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("188", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Text("En cours de livraison ", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Container(

                          width: width*0.12,
                          child: Icon(Icons.car_crash_sharp, color: Colors.blueAccent.shade700 , size: width*0.1,)), // The icon


                    ],
                  ),
                ),
                SizedBox(width: width*0.02,),
                Container(



                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent.shade700 , width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("6", style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                          Container(

                            child: Text("Livrée", style: TextStyle(fontSize: width*0.025, fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),

                      Container(

                          width: width*0.12,
                          child: Icon(Icons.check_box, color: Colors.greenAccent.shade700 , size: width*0.1,)), // The icon


                    ],
                  ),
                ),
              ],
            ),


            SizedBox(height: height*0.02,),
            Text(
              "La liste de mes commandes par état de traitement",
              style: TextStyle(fontSize: width * 0.035, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height * 0.02),
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: TextField(
                controller: searchController,
                onChanged: filterCommandes,
                decoration: InputDecoration(
                  labelText: 'Search Commande',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            // Add the ListView here
            Expanded(
              child: ListView.builder(
                itemCount: filteredCommandes.length,
                itemBuilder: (context, index) {
                  var commande = filteredCommandes[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width:width*0.7,
                              child: ListTile(
                                title: Text(' N° Commande: ${commande["NCommande"]}', style: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),),
                                subtitle: Text(
                                  'N° Livraison: ${commande["NLivraison"]}\nStatut: ${commande["Statut"]}\nDate: ${commande["date"]} ${commande["Heure"]}\nMontant: ${commande["Montant"]}',

                                  style: TextStyle(color: Colors.black,fontSize: width*0.035),
                                ),
                              ),
                            ),
                        Container(
                          width:width*0.2,
                          

                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Image.asset(

                                            'images/cap.png', // Your image asset
                                            width: width*0.75, // Adjust width as needed
                                            height: height*0.8, // Adjust height as needed
                                          ),
                                        ],
                                      ),
                                      duration: Duration(seconds: 3), // Duration for the snackbar
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.blue,
                                  child: Text("BC"),
                                ),
                              ),

                              SizedBox(height: height*0.01,),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          Image.asset(

                                            'images/cap.png', // Your image asset
                                            width: width*0.75, // Adjust width as needed
                                            height: height*0.8, // Adjust height as needed
                                          ),
                                        ],
                                      ),
                                      duration: Duration(seconds: 3), // Duration for the snackbar
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                  child: Text("BL"),
                                ),
                              ),


                            ],
                          ),
                          
                        )


                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02)
                    ],
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
