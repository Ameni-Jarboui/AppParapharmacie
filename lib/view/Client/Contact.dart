import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';
import 'package:myparaconnect/view/Client/drawerClient.dart';

class Contact extends StatefulWidget {
  Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {


  @override



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
      body:  Center(
        child: ListView(
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
           Text("Contact Para-Connect",style: TextStyle(fontSize: width*0.035),),
           Column(
             children: [
             Container(
             width: width * 0.9,
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.grey, width: 2.0),
                 borderRadius: BorderRadius.circular(8.0),
               ),

             padding: EdgeInsets.all(16.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'Administration',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),
                 ),
                 Divider(
                   height: 4,),
                 // Name Section with Icon
                 Row(
                   children: [
                     Icon(
                       Icons.person, // Icon for name
                       color: Colors.black,
                     ),
                     Text(
                       'Nom',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                   ],
                 ),
                 // Contact Section with Icon
                 Row(
                   children: [


                     Text(
                       'Contact ParaConnect',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                   ],
                 ),

                 // Telephone Section
                 Row(
                   children: [
                     Icon(
                       Icons.phone, // Icon for email
                       color: Colors.black,
                     ),
                     Text(
                       'Telephone',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                   ],
                 ),
                 Text(
                   '71 138 780 - 71 138 781 - 71 138 782 - 71 138 783 - 71 138 784',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.black,
                   ),
                 ),
                 // Address Section
                 Row(
                   children: [
                     Icon(
                       Icons.place, // Icon for email
                       color: Colors.black,
                     ),
                     Text(
                       'Adresse',
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                   ],
                 ),
                 Text(
                   '021, Patrice Lumumba, Tunis 1008',
                   style: TextStyle(
                     fontSize: 16,
                     color: Colors.black,
                   ),
                 ),
                 // Email Section with Icon
                 Row(
                   children: [

                     Text(
                       'example@mail.com', // Replace with actual email
                       style: TextStyle(
                         fontSize: 18,
                         color: Colors.black,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
               SizedBox(height: height*0.02,),
               Container(
                 width: width * 0.9,
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey, width: 2.0),
                   borderRadius: BorderRadius.circular(8.0),
                 ),

                 padding: EdgeInsets.all(16.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Responsable Général',
                       style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),
                     ),
                     Divider(
                       height: 4,),
                     // Name Section with Icon
                     Row(
                       children: [
                         Icon(
                           Icons.person, // Icon for name
                           color: Colors.black,
                         ),
                         Text(
                           'Nom',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     // Contact Section with Icon
                     Row(
                       children: [


                         Text(
                           'Arbia Farhat',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),

                     // Telephone Section
                     Row(
                       children: [
                         Icon(
                           Icons.phone, // Icon for email
                           color: Colors.black,
                         ),
                         Text(
                           'Telephone',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     Text(
                       '71 138 780 - 71 138 781 - 71 138 782 - 71 138 783 - 71 138 784',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,
                       ),
                     ),
                     // Address Section
                     Row(
                       children: [
                         Icon(
                           Icons.place, // Icon for email
                           color: Colors.black,
                         ),
                         Text(
                           'Adresse',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     Text(
                       '021, Patrice Lumumba, Tunis 1008',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,
                       ),
                     ),
                     // Email Section with Icon
                     Row(
                       children: [

                         Text(
                           'example@mail.com', // Replace with actual email
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               SizedBox(height: height*0.02,),
               Container(
                 width: width * 0.9,
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey, width: 2.0),
                   borderRadius: BorderRadius.circular(8.0),
                 ),

                 padding: EdgeInsets.all(16.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Responsable Réclamation',
                       style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),
                     ),
                     Divider(
                       height: 4,),
                     // Name Section with Icon
                     Row(
                       children: [
                         Icon(
                           Icons.person, // Icon for name
                           color: Colors.black,
                         ),
                         Text(
                           'Nom',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     // Contact Section with Icon
                     Row(
                       children: [


                         Text(
                           'Hadhemi',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),

                     // Telephone Section
                     Row(
                       children: [
                         Icon(
                           Icons.phone, // Icon for email
                           color: Colors.black,
                         ),
                         Text(
                           'Telephone',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     Text(
                       '71 138 780 - 71 138 781 - 71 138 782 - 71 138 783 - 71 138 784',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,
                       ),
                     ),
                     // Address Section
                     Row(
                       children: [
                         Icon(
                           Icons.place, // Icon for email
                           color: Colors.black,
                         ),
                         Text(
                           'Adresse',
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                     Text(
                       '021, Patrice Lumumba, Tunis 1008',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,
                       ),
                     ),
                     // Email Section with Icon
                     Row(
                       children: [

                         Text(
                           'example@mail.com', // Replace with actual email
                           style: TextStyle(
                             fontSize: 18,
                             color: Colors.black,
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),

             ],
           )
          ],
        ),
      ),
    );
  }
}