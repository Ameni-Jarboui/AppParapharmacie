import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

class Produit {
  String code;
  String description;
  String produitUrl;

  Produit({
    required this.code,
    required this.description,
    required this.produitUrl,
  });

  factory Produit.fromJson(Map<String, dynamic> json) {
    return Produit(
      code: json['code'],
      description: json['Description'],
      produitUrl: json['produit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'Description': description,
      'produit': produitUrl,
    };
  }
}

class ListProduit {
  static List<Produit> produits = [];

  static Future<void> loadProduits() async {
    String jsonString = await rootBundle.loadString('assets/produit.json');
    List<dynamic> jsonData = json.decode(jsonString);
    produits = jsonData.map((item) => Produit.fromJson(item)).toList();
  }

  static void addProduit(Produit newProduit) {
    produits.add(newProduit);
  }

  static List<Produit> getProduits() {
    return produits;
  }

  static void updateProduit(int index, Produit updatedProduit) {
    produits[index] = updatedProduit;
  }

  static void deleteProduit(int index) {
    produits.removeAt(index);
  }
}

class GestionProduit extends StatefulWidget {
  @override
  _GestionProduitState createState() => _GestionProduitState();
}

class _GestionProduitState extends State<GestionProduit> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProduits();
  }

  Future<void> _loadProduits() async {
    await ListProduit.loadProduits();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredProduits = ListProduit.getProduits()
        .where((produit) => produit.description.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
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
                  Text(
                    "CRM",
                    style: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawerAdmin(),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Produit',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

      Container(
        height: 50,
        child: ListTile(
          title: Row(
            children: [
              Container(
                  width: width*0.15,
                  child: Text("code",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: width*0.03),)),
              SizedBox(width: 12,),
              Container(
                  width: width*0.2,
                  child: Text("description",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800,fontSize: width*0.03),)),
            ],
          ),
          leading: Container(
            width: 60,
            height: 60,
            child:Row(
              children: [
                Text("produit",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                SizedBox(width: 12,),

              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Text("Action",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
              SizedBox()
            ],
          ),
        ),
      ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProduits.length,
              itemBuilder: (context, index) {
                final produit = filteredProduits[index];
                return ListTile(
                  title: Row(
                    children: [
                      Container(
                  width: width*0.12,
                          child: Text(produit.code , style: TextStyle(fontSize: width*0.03,),)),
                      SizedBox(width:width*0.04,),
                      Container(
                          width: width*0.2,
                          child: Text(produit.description , style: TextStyle(fontSize: width*0.03,),)),

                    ],
                  ),
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Image.network(produit.produitUrl, width: 50, height: 50),
                  ),
                  trailing: Container
                    (
                    width:width*0.27,


                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _showProduitDialog(context, index, produit);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              ListProduit.deleteProduit(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _showProduitDialog(context, null, null); // Add new produit
        },
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showProduitDialog(BuildContext context, int? index, Produit? produit) {
    final _codeController = TextEditingController(text: produit != null ? produit.code : '');
    final _descriptionController = TextEditingController(text: produit != null ? produit.description : '');
    final _produitUrlController = TextEditingController(text: produit != null ? produit.produitUrl : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add New Produit' : 'Edit Produit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: "Code*",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: "Description*",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: _produitUrlController,
              decoration: InputDecoration(
                hintText: 'Produit URL',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_codeController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _produitUrlController.text.isNotEmpty) {
                if (index == null) {
                  // Add new produit
                  setState(() {
                    ListProduit.addProduit(Produit(
                      code: _codeController.text,
                      description: _descriptionController.text,
                      produitUrl: _produitUrlController.text,
                    ));
                  });
                } else {
                  // Update existing produit
                  setState(() {
                    ListProduit.updateProduit(
                      index,
                      Produit(
                        code: _codeController.text,
                        description: _descriptionController.text,
                        produitUrl: _produitUrlController.text,
                      ),
                    );
                  });
                }
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Color(0xFF0B3D91),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
