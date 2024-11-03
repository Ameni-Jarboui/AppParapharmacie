import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';

class GestionClient extends StatefulWidget {
  GestionClient({Key? key}) : super(key: key);

  @override
  _GestionClientState createState() => _GestionClientState();
}

class _GestionClientState extends State<GestionClient> {
  List<Map<String, dynamic>> listUsers = [];
  List<Map<String, dynamic>> filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadUsers(); // Load the users when the widget is initialized
  }

  Future<void> loadUsers() async {
    String jsonString = await rootBundle.loadString('assets/users.json');
    List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      listUsers = List<Map<String, dynamic>>.from(jsonData);
      filteredUsers = listUsers; // Initialize filteredUsers
    });
  }




  void _startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void _filterUsers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredUsers = listUsers.where((user) {
        return user['username'].toLowerCase().contains(query) ||
            user['Email'].toLowerCase().contains(query);
      }).toList();
    });
  }


  void _clearSearch() {
    setState(() {
      _searchController.clear();
      filteredUsers = listUsers; // Reset to show all users
      isSearching = false;
    });
  }


  void _showDetails(Map<String, dynamic> user) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight= MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenheight;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          height: height*0.5,

          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Container(
          color:  Colors.grey.shade200,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height*0.01,),
                  Text(
                    'Username: ${user['username']}',

                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),

                  ),
                  Divider(height: 4),
                 SizedBox(height: height*0.01,),
                 Text(" Email: ${user['Email']}"  ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  Divider(height: 4),
                  Text(" Role: ${user['role'] ?? 'N/A'}",  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  Divider(height: 4),
                  SizedBox(height: height*0.01,),

                      Text("Pharmacy: ${user['pharmacie'] ?? 'N/A' }",   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: height*0.01,),
                  Divider(height: 4),
                     Text("Type: ${user['type'] ?? 'N/A'}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: height*0.01,),
                  Divider(height: 4),
                     Text("Number: ${user['num'] ?? 'N/A'}" , style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),



        ),
        duration: Duration(seconds:4),
      ),
    );
  }


  void _editUser(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(
          user: user,
          onUpdate: (updatedUser) {
            setState(() {
              int index = listUsers.indexWhere((u) => u['username'] == user['username']);
              if (index != -1) {
                listUsers[index] = updatedUser;
                filteredUsers = listUsers;
              }
            });
          },
        ),
      ),
    );
  }

  void _deleteUser(Map<String, dynamic> user) {
    setState(() {
      listUsers.remove(user);
      filteredUsers.remove(user);
    });
  }

  void _addNewUser() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(
          onAdd: (newUser) {
            setState(() {
              listUsers.add(newUser);
              filteredUsers = listUsers;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                  SizedBox(width: width * 0.01),
                  Text(
                    "CRM",
                    style: TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(child: MyDrawerAdmin()),
      body:  Center(
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: _clearSearch,
                        ),
                      ),
                      onChanged: (text) {
                        _filterUsers(); // Filter users on text change
                      },
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green.shade800,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.add, size: height * 0.045),
                      onPressed: _addNewUser,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            Row(
              children: [
                SizedBox(width: width * 0.04),
                Text("List des utilisateurs", style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: width * 0.05
                )),
              ],
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(user['username']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: width * 0.1,
                              height: height * 0.02,
                              decoration: BoxDecoration(
                                color: user['statut'] == 'Actif' ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(user['statut'])),
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_red_eye_sharp),
                              onPressed: () => _showDetails(user),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editUser(user),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteUser(user),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 4),
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
class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final void Function(Map<String, dynamic>) onUpdate;

  EditUserPage({required this.user, required this.onUpdate});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _roleController;
  late TextEditingController _pharmacieController;
  late TextEditingController _typeController;
  late TextEditingController _numController;
  late TextEditingController _statutController;

  bool? _isActive;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user['username']);
    _emailController = TextEditingController(text: widget.user['Email']);
    _roleController = TextEditingController(text: widget.user['role']);
    _pharmacieController = TextEditingController(text: widget.user['pharmacie']);
    _typeController = TextEditingController(text: widget.user['type']);
    _numController = TextEditingController(text: widget.user['num']);
    _statutController = TextEditingController(text: widget.user['statut']);

    // Initialize _isActive based on user status
    _isActive = widget.user['statut'] == 'true'; // Assuming 'true' or 'false' as string
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _pharmacieController.dispose();
    _typeController.dispose();
    _numController.dispose();
    _statutController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedUser = {
      'username': _usernameController.text,
      'Email': _emailController.text,
      'role': _roleController.text,
      'pharmacie': _pharmacieController.text,
      'type': _typeController.text,
      'num': _numController.text,
      'statut': _statutController.text,
    };

    widget.onUpdate(updatedUser);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text('Update User Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username*",
                hintStyle: TextStyle(fontSize: width * 0.04),
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
            SizedBox(height: height * 0.03),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email*",
                hintStyle: TextStyle(fontSize: width * 0.04),
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
            SizedBox(height: height * 0.03),
            DropdownButtonFormField<String>(
              value: _pharmacieController.text, // Use controller text as initial value
              onChanged: (String? newValue) {
                setState(() {
                  _pharmacieController.text = newValue!;
                });
              },
              items: <String>['Pharmacie Abid Mohamed ali','Queen para hnene hajer', 'pharmacie hamdi amel', 'Payless para Tunis', 'Pharmacie ben marzouk mahdi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: "",
                hintStyle: TextStyle(fontSize: width * 0.04),
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
            SizedBox(height: height * 0.03),
            DropdownButtonFormField<String>(
              value: _typeController.text, // Use controller text as initial value
              onChanged: (String? newValue) {
                setState(() {
                  _typeController.text = newValue!;
                });
              },
              items: <String>['Utilisateur', 'Pharmacien']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: "",
                hintStyle: TextStyle(fontSize: width * 0.04),
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
            SizedBox(height: height * 0.03),
            TextField(
              controller: _numController,
              decoration: InputDecoration(
                hintText: "Phone*",
                hintStyle: TextStyle(fontSize: width * 0.04),
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
            SizedBox(height: height * 0.03),
            Text(
              'Activation',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey.shade600),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Actif'),
                    value: true,
                    groupValue: _isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActive = value!;
                        _statutController.text = value.toString(); // Update the controller text
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Non Actif'),
                    value: false,
                    groupValue: _isActive,
                    onChanged: (bool? value) {
                      setState(() {
                        _isActive = value!;
                        _statutController.text = value.toString(); // Update the controller text
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height:height*0.03),

            Container(
              height: height * 0.065,
              width: width * 0.85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF0B3D91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _saveChanges,
                child: Text(
                  'ENREGISTRER',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}





class AddUserPage extends StatefulWidget {
  final void Function(Map<String, dynamic>) onAdd;

  AddUserPage({required this.onAdd});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController=TextEditingController();
  final TextEditingController _pharmacieController =TextEditingController();
  final TextEditingController _typeController =TextEditingController();
  final TextEditingController _numController=TextEditingController();
  final TextEditingController _passwordController =TextEditingController();



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _pharmacieController.dispose();
    _typeController.dispose();
    _numController.dispose();
    super.dispose();
  }

  void _addUser() {
    // Check if required fields are not empty
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      // Show an error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs '),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the function if any field is empty
    }


    // Proceed with adding the user if all fields are filled
    final newUser = {
      'username': _usernameController.text,
      'Email': _emailController.text,
      'role': _roleController.text,
      'ref': '4000041', // Default value or you can customize as needed
      'pharmacie': _pharmacieController.text,
      'type': _typeController.text,
      'num': _numController.text,
      'password': _passwordController.text,
      'statut': 'Actif', // Default value or you can customize as needed
    };

    widget.onAdd(newUser);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    String? _selectedPharmacie;
    String? _selectedType;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.grey.shade200,
        title: Text('Ajouter un utilisateur'),

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username*",
                hintStyle: TextStyle(fontSize: width * 0.04),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),
            ),
            SizedBox(height:height*0.03),

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email*",
                hintStyle: TextStyle(fontSize: width * 0.04),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),
            ),
            SizedBox(height:height*0.03),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password*",
                hintStyle: TextStyle(fontSize: width * 0.04),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),
            ),
            SizedBox(height:height*0.03),

            DropdownButtonFormField<String>(
              value: _selectedPharmacie, // Initial selected value
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPharmacie = newValue!;
                  _pharmacieController.text = newValue; // Update the controller text
                });
              },
              items: <String>['Pharmacie Abid Mohamed ali','Queen para hnene hajer', 'pharmacie hamdi amel', 'Payless para Tunis', 'Pharmacie ben marzouk mahdi']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: "",
                hintStyle: TextStyle(fontSize: width * 0.04),
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

            SizedBox(height:height*0.03),
            TextField(
              controller: _numController,
              decoration: InputDecoration(
                hintText: "Phone*",
                hintStyle: TextStyle(fontSize: width * 0.04),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),),
            ),
            SizedBox(height:height*0.03),

            DropdownButtonFormField<String>(
              value: _selectedType, // Initial selected value
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                  _typeController.text = newValue; // Update the controller text
                });
              },
              items: <String>['Utilisateur', 'Pharmacien']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                hintText: "",
                hintStyle: TextStyle(fontSize: width * 0.04),
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

            SizedBox(height:height*0.03),

            Container(
              height: height * 0.065,
              width: width * 0.85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Color(0xFF0B3D91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _addUser,
                child: Text(
                  'ENREGISTRER',
                  style: TextStyle(
                    fontSize: width * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),


    );
  }
}