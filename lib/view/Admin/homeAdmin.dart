import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Admin/MyDrawerAdmin.dart';
import'package:myparaconnect/view/Admin/homeAdmin.dart';
import'package:myparaconnect/view/home/homeUser.dart';
import 'package:myparaconnect/view/listData/userList.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {


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
              height: height*0.05,
              width: width*0.48,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Text("Responsable Général ", style: TextStyle(
                  fontSize: width*0.042,color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
            SizedBox(width: width*0.02,),
            Container(
              height: height*0.045,
              width: width*0.22,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Row(
                children: [
                  SizedBox(width: width*0.02,),
                  CircleAvatar(
                    radius: 15,

                    backgroundColor:Colors.grey.shade100,
                    child: Icon(Icons.person,size: 25,color: Colors.grey,),
                  ),
                  SizedBox(width: width*0.01,),
                  Text("CRM", style: TextStyle(
                      fontSize: width*0.03,
                      fontWeight: FontWeight.bold
                  ),),

                ],
              ),
            ),
          ],
        ),


      ),
      drawer: Drawer(
        child: MyDrawerAdmin()
      ),
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
            Container(
                child: Column(
                  children: [

                  ],
                ),
              ),

            
            
            
            Container(
                height: height*0.2,
                width: width*0.6,
                child: Text("home " , style: TextStyle(
                  fontSize:15
                ),)),
          ],
        ),
      ),
    );
  }
}
