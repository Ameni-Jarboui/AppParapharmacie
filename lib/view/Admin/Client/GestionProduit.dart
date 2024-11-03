import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

class GestionProduits extends StatefulWidget {
  GestionProduits({Key? key}) : super(key: key);

  @override
  _GestionProduitsState createState() => _GestionProduitsState();
}

class _GestionProduitsState extends State<GestionProduits> {
  File? _image;
  final _codeController = TextEditingController();
  final _designationController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  final _searchController = TextEditingController();

  List<Map<String, dynamic>> listProduits = [];
  List<Map<String, dynamic>> filteredProduits = []; // To hold filtered products

  @override
  void initState() {
    super.initState();
    // Initially, set filteredProduits to the full list of products
    filteredProduits = listProduits;
    // Add a listener to the search controller to filter the list dynamically
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to filter products based on search query
  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProduits = listProduits.where((product) {
        final designation = product['Designation'].toLowerCase();
        final code = product['ProductCode'].toLowerCase();
        return designation.contains(query) || code.contains(query);
      }).toList();
    });
  }

  // Function to show the bottom sheet for adding/editing a product
  void _showProductBottomSheet(BuildContext context, {int? index}) {
    if (index != null) {
      // Editing an existing product
      _codeController.text = listProduits[index]['ProductCode'];
      _designationController.text = listProduits[index]['Designation'];
      _additionalInfoController.text = listProduits[index]['AdditionalInfo'] ?? '';
      _image = listProduits[index]['ProductImage'] != null ? File(listProduits[index]['ProductImage']) : null;
    } else {
      // Adding a new product
      _codeController.clear();
      _designationController.clear();
      _additionalInfoController.clear();
      _image = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _image == null
                    ? Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.add_a_photo, size: 40, color: Colors.grey.shade700),
                )
                    : Image.file(_image!, width: 100, height: 100),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(labelText: 'Product Code'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _designationController,
                decoration: InputDecoration(labelText: 'Designation'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _additionalInfoController,
                decoration: InputDecoration(labelText: 'Additional Info (Optional)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF0B3D91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () => _saveProduct(index: index),
                child: Text(
                  index == null ? 'Save Product' : 'Update Product',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Function to save or update a product
  void _saveProduct({int? index}) {
    final code = _codeController.text;
    final designation = _designationController.text;

    if (designation.isNotEmpty) {
      setState(() {
        if (index == null) {
          // Adding a new product
          listProduits.add({
            'ProductCode': code,
            'Designation': designation,
            'ProductImage': _image?.path,
            'AdditionalInfo': _additionalInfoController.text,
          });
        } else {
          // Updating an existing product
          listProduits[index] = {
            'ProductCode': code,
            'Designation': designation,
            'ProductImage': _image?.path,
            'AdditionalInfo': _additionalInfoController.text,
          };
        }

        _image = null;
        _codeController.clear();
        _designationController.clear();
        _additionalInfoController.clear();
        Navigator.pop(context); // Close the bottom sheet
        _filterProducts(); // Re-filter the list after saving
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add a designation')),
      );
    }
  }

  // Function to delete a product
  void _deleteProduct(int index) {
    setState(() {
      listProduits.removeAt(index);
      _filterProducts(); // Re-filter the list after deletion
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
drawer: MyDrawerAdmin(),
   appBar:    AppBar(
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

      body: Center(
        child: ListView.builder(
          itemCount: filteredProduits.length + 1, // Add 1 for the title
          itemBuilder: (context, index) {
            if (index == 0) {
              // Display the title at the top
              return Padding(
                padding: const EdgeInsets.all(16.0),
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

                    PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search Products',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),

                    Text(
                      "List of Products",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              // Display the list of products
              final product = filteredProduits[index - 1];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  leading: product['ProductImage'] != null
                      ? Image.file(
                    File(product['ProductImage']),
                    width: 50,
                    height: 50,
                  )
                      : Icon(Icons.image_not_supported, size: 50),
                  title: Text(product['Designation']),
                  subtitle: Text('Code: ${product['ProductCode']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showProductBottomSheet(context, index: index - 1),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteProduct(index - 1),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductBottomSheet(context),
        backgroundColor: Colors.green.shade800,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
