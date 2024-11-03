
import 'package:flutter/material.dart';
import 'package:myparaconnect/view/Admin/GestionClient.dart';
import 'package:myparaconnect/view/Admin/GestionProduit.dart';
import 'package:myparaconnect/view/Admin/GestionArticle.dart';
import 'package:myparaconnect/view/Admin/GestionDocuments.dart';
import 'package:myparaconnect/view/Admin/GestionMarque.dart';
import 'package:myparaconnect/view/Admin/homeAdmin.dart';
import 'package:myparaconnect/view/login.dart';


class MyDrawerAdmin extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;

    return Scaffold(
      body:ListView  (
        children: [
          SizedBox(
            height:10,
          ),
          Container(
            height: 200,
            width: double.infinity,
            padding: EdgeInsets.all(10),


            child: Row(
                children:[

                  SizedBox(
                    width: width*0.22,
                  ),
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage("images/profile.png"),
                        ),
                      ),
                      SizedBox(height: height*0.01,),

                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:Colors.green,
                            radius: 5,
                          ),
                          SizedBox(width: width*0.02,),

                          Text("Online",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize:18
                          ),),
                        ],
                      ),


                    ],
                  )

                ]),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Documents', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.file_copy,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestionDocuments()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Comptes', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.group,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestionClient()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Gestion Produits', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.production_quantity_limits,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestionProduit()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Publicité', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.campaign,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestionArticle()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text('Marques', style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.storefront,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GestionMarque()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),
          Container(
            padding: EdgeInsets.all(5),
            child: ListTile(
                title: Text("Déconnection", style:TextStyle(fontWeight: FontWeight.bold, fontSize: width*0.06)),

                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor:Colors.transparent,
                  child: Icon(Icons.login,size: 30,color: Colors.grey,),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );

                }
            ),
          ),
          Divider(
            height: 4,),





        ],
      ),


    );
  }

}