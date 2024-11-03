import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

// Model class for Marque
class Marque {
  String description;
  String imageUrl;

  Marque({required this.description, required this.imageUrl});

  factory Marque.fromJson(Map<String, dynamic> json) {
    return Marque(
      description: json['Description'],
      imageUrl: json['Marqueimage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Description': description,
      'Marqueimage': imageUrl,
    };
  }
}

// Static class to manage CRUD operations
class ListMarque {
  static List<Marque> marques = [];

  // Load from JSON
  static Future<void> loadMarques() async {
    String jsonString = await rootBundle.loadString('assets/marques.json');
    List<dynamic> jsonData = json.decode(jsonString);
    marques = jsonData.map((item) => Marque.fromJson(item)).toList();
  }

  // Create
  static void addMarque(Marque newMarque) {
    marques.add(newMarque);
  }

  // Read (get list)
  static List<Marque> getMarques() {
    return marques;
  }

  // Update
  static void updateMarque(int index, Marque updatedMarque) {
    marques[index] = updatedMarque;
  }

  // Delete
  static void deleteMarque(int index) {
    marques.removeAt(index);
  }
}

class GestionMarque extends StatefulWidget {
  @override
  _GestionMarqueState createState() => _GestionMarqueState();
}

class _GestionMarqueState extends State<GestionMarque> {
  // Search query for filtering marques
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMarques(); // Load marques when the widget is created
  }

  Future<void> _loadMarques() async {
    await ListMarque.loadMarques();
    setState(() {}); // Refresh UI after loading data
  }

  @override
  Widget build(BuildContext context) {
    // Filtered marques based on search query
    final filteredMarques = ListMarque.getMarques()
        .where((marque) =>
        marque.description.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(

      backgroundColor: Colors.white,
      appBar:   AppBar(
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
                  "Responsable Général ",
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
          // Search field
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Marque',
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
          // List of marques
          Container(
            height: 50,
            child: ListTile(
              title: Row(
                children: [
                Text("description",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                ],
              ),
              leading: Container(
                width: 60,
                height: 60,
                child:Row(
                  children: [
                    Text("Marque",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
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
              itemCount: filteredMarques.length,
              itemBuilder: (context, index) {
                final marque = filteredMarques[index];
                return ListTile(
                  title: Text(marque.description),
                  leading:Container(
                    width: 60,
                    height: 60,
                    child:  Image.network(marque.imageUrl, width: 50, height: 50),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue,),
                        onPressed: () {
                          // Edit marque
                          _showMarqueDialog(context, index, marque);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {
                          // Delete marque
                          setState(() {
                            ListMarque.deleteMarque(index);
                          });
                        },
                      ),
                    ],
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
          _showMarqueDialog(context, null, null); // Add new marque
        },
        child: Icon(Icons.add,color: Colors.white,size: 30,),
      ),
    );
  }

  // Dialog to add or edit marque
  void _showMarqueDialog(BuildContext context, int? index, Marque? marque) {
    final _descriptionController = TextEditingController(
        text: marque != null ? marque.description : '');
    final _imageUrlController = TextEditingController(
        text: marque != null ? marque.imageUrl : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add New Marque' : 'Edit Marque'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(

                hintText: "Description*",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),

            ),
            SizedBox(height:18,),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                  hintText: 'Image URL',

                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Color(0xFF0B3D91),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              if (_descriptionController.text.isNotEmpty &&
                  _imageUrlController.text.isNotEmpty) {
                if (index == null) {
                  // Add new marque
                  setState(() {
                    ListMarque.addMarque(Marque(
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                    ));
                  });
                } else {
                  // Update existing marque
                  setState(() {
                    ListMarque.updateMarque(
                      index,
                      Marque(
                        description: _descriptionController.text,
                        imageUrl: _imageUrlController.text,
                      ),
                    );
                  });
                }
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'SAVE',
              style: TextStyle(

                color: Colors.white,
              ),
            ),
          ),




          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel' , style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );
  }
}
