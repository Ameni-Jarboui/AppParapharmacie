import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Admin/GestionArticle.dart';
import 'package:myparaconnect/view/Admin/GestionDocuments.dart';
import 'package:myparaconnect/view/Admin/GestionMarque.dart';
import 'package:myparaconnect/view/Admin/GestionProduit.dart';
import 'package:myparaconnect/view/Client/Contact.dart';
import 'package:myparaconnect/view/Client/accueil.dart';
import 'package:myparaconnect/view/Client/achats.dart';
import 'package:myparaconnect/view/Client/commandes.dart';
import 'package:myparaconnect/view/Client/factures.dart';
import 'package:myparaconnect/view/splash_screen/splash_screen1.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home:  Achats(),
      debugShowCheckedModeBanner: false,
    );
  }
}
