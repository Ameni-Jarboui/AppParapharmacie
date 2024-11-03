import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Admin/GestionClient.dart';
import 'package:myparaconnect/view/Admin/homeAdmin.dart';
import 'package:myparaconnect/view/Client/accueil.dart';
import 'package:myparaconnect/view/listData/userList.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initializeUsers();
  }

  Future<void> _initializeUsers() async {
    await ListUser.loadUsers(); // Load users from JSON file
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 30,
        left: MediaQuery.of(context).size.width / 2 - 150,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void _validateAndLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Veuillez remplir tous les champs.');
      return;
    }

    // Validate user credentials
    final user = ListUser.listUsers.firstWhere(
            (user) => user['username'] == email && user['password'] == password,
        orElse: () => {} // Return an empty map if no user is found
    );

    if (user.isEmpty) {
      _showSnackbar('Utilisateur ou mot de passe incorrect.');
    } else {
      // Check user role and navigate accordingly
      if (user['role'] == 'Utilisateur') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Accueil()),
        );
      } else if (user['role'] == 'admin') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GestionClient()),
        );
      }
    }
  }

// (The rest of the build method remains unchanged)



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: height,
          width: width,
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.2,
              ),
              Container(
                child: Center(
                  child: Container(
                    height: height * 0.1,
                    width: width * 0.88,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/img.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.all(width * 0.1),
                child: Divider(
                  height: height * 0.0005,
                ),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.01,
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.85,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Nom d'utilisateur*",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre Nom';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Container(
                      height: height * 0.065,
                      width: width * 0.85,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          hintText: "Mot de passe*",
                          hintStyle: TextStyle(fontSize: width * 0.04),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0B3D91), width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              size: width * 0.065,
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: _obscureText ? Colors.grey : Color(0xFF0B3D91),
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.045),
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
                        onPressed: _validateAndLogin,
                        child: Text(
                          'Se connecter',
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
            ],
          ),
        ),
      ),
    );
  }
}

