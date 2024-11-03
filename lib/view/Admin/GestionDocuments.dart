import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart'; // For date formatting
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

class Document {
  String description;
  String imageUrl;
  int ref; // Reference number
  String date; // Date of the document

  Document({
    required this.description,
    required this.imageUrl,
    required this.ref,
    required this.date,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      description: json['Description'],
      imageUrl: json['Docimage'],
      ref: Random().nextInt(1001) + 4000, // Generate ref between 4000 and 5000
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()), // Set current date
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Description': description,
      'Docimage': imageUrl,
      'Ref': ref,
      'Date': date,
    };
  }
}

class ListMarque {
  static List<Document> marques = [];

  // Load from JSON (ignoring ref and date as they're generated dynamically)
  static Future<void> loadMarques() async {
    String jsonString = await rootBundle.loadString('assets/documents.json');
    List<dynamic> jsonData = json.decode(jsonString);
    marques = jsonData.map((item) => Document.fromJson(item)).toList();
  }

  // Create a new marque
  static void addMarque(Document newMarque) {
    marques.add(newMarque);
  }

  // Read (get list)
  static List<Document> getMarques() {
    return marques;
  }

  // Update
  static void updateMarque(int index, Document updatedMarque) {
    marques[index] = updatedMarque;
  }

  // Delete
  static void deleteMarque(int index) {
    marques.removeAt(index);
  }
}

class GestionDocuments extends StatefulWidget {
  @override
  _GestionDocumentsState createState() => _GestionDocumentsState();
}

class _GestionDocumentsState extends State<GestionDocuments> {
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
    final filteredMarques = ListMarque.getMarques()
        .where((document) =>
        document.description.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                labelText: 'Search Document',
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
              Text("description",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),),
                ],
              ),
              leading: Container(
                width: 60,
                height: 60,
                child:Row(
                  children: [
                    Text("Document", style: TextStyle(fontSize: 8,color: Colors.grey.shade800),),
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
                  subtitle: Text('Ref: ${marque.ref}, Date: ${marque.date}'),
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Image.network(marque.imageUrl, width: 50, height: 50),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showMarqueDialog(context, index, marque);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
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
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _showMarqueDialog(BuildContext context, int? index, Document? marque) {
    final _descriptionController =
    TextEditingController(text: marque != null ? marque.description : '');
    final _imageUrlController =
    TextEditingController(text: marque != null ? marque.imageUrl : '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? 'Add New Document' : 'Edit Document'),
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
                ),
              ),
            ),
            SizedBox(height: 18),
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
                ),
              ),
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
                  // Add new marque with random ref and current date
                  setState(() {
                    ListMarque.addMarque(Document(
                      description: _descriptionController.text,
                      imageUrl: _imageUrlController.text,
                      ref: Random().nextInt(1001) + 4000, // Generate ref between 4000-5000
                      date: DateFormat('yyyy-MM-dd').format(DateTime.now()), // Current date
                    ));
                  });
                } else {
                  // Update existing marque
                  setState(() {
                    ListMarque.updateMarque(
                      index,
                      Document(
                        description: _descriptionController.text,
                        imageUrl: _imageUrlController.text,
                        ref: marque!.ref, // Keep the existing ref
                        date: marque.date, // Keep the existing date
                      ),
                    );
                  });
                }
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: Text(index == null ? 'Add' : 'Update' , style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
